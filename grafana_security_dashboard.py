import dash
from dash import dcc, html
import pandas as pd
import plotly.express as px
from datetime import datetime, timedelta
import numpy as np

app = dash.Dash(__name__)

timestamps = [datetime.now() - timedelta(minutes=i*15) for i in range(20)]
failed_logins = np.random.randint(0, 10, 20)
vote_spam_attempts = np.random.randint(0, 20, 20)
fraud_attempts = np.random.choice([0, 1, 3, 5], 20)

df = pd.DataFrame({
    "Time": timestamps,
    "Failed Logins": failed_logins,
    "Vote Spam": vote_spam_attempts,
    "Treasury Fraud": fraud_attempts,
})

fig1 = px.line(df, x="Time", y="Failed Logins", title="Failed Login Attempts Over Time")
fig2 = px.line(df, x="Time", y="Vote Spam", title="Vote Manipulation Detection")
fig3 = px.line(df, x="Time", y="Treasury Fraud", title="Treasury Fraud Alerts Over Time")

app.layout = html.Div([
    html.H1("🔒 AI-Powered Security Dashboard"),
    dcc.Graph(figure=fig1),
    dcc.Graph(figure=fig2),
    dcc.Graph(figure=fig3),
])

if __name__ == "__main__":
    app.run_server(debug=True)
