Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A913C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 19:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A0C020870
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 19:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="gGRGMmS4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731547AbfCaTQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 15:16:40 -0400
Received: from mout.gmx.net ([212.227.17.22]:38817 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbfCaTQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 15:16:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554059782;
        bh=tHp/iiULCkqVhT1KsH1OFdlDiFqOPn6BCSydpzxcZQU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=gGRGMmS4tAcT+jKC4qXMAMN+o7o/nEqw6w9RQ36D8w+8kq739SavWd2zhJgqjmLJD
         iBa9f1qRL0uvGKScTxGftiV3G/yYN89EHQ4t1+OkFnoTOZD532Xqvby5S7fMESPOZJ
         i2+s8MhcqtKhWBMEmuDTwy8Eun2K2dcnQDUTk6LI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M4TgW-1h0yks2Pts-00yiWL; Sun, 31
 Mar 2019 21:16:22 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        =?UTF-8?q?Vok=C3=A1=C4=8D=20Michal?= <Michal.Vokac@ysoft.com>,
        Thierry Reding <treding@nvidia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: arm: fsl: Add i.MX50 based boards
Date:   Sun, 31 Mar 2019 21:16:01 +0200
Message-Id: <20190331191602.3921-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190331191602.3921-1-j.neuschaefer@gmx.net>
References: <20190331191602.3921-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HiKdOgWDIJBVCocyEytuPzB891gYwIzeTQ8HarNtoxzJ/R6lN0H
 uv6NimwE7V1RlQOGsbGE1rIrgBqFnS6pl8wzsQWfEWAaAjQoPJPz/K1dMu0nlrTeWOHH/4Q
 f1X3ayHK1jM62tybJrDAcjLyJ2ef0jCu/3T+BqD3djpBJCrpFpswPMe4wyMOtwrguWkL6uN
 vnhgDGiBbJkJvkM07sjMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dHp7NG5GJLw=:HVqb4wd07sLQIz6lNsejL5
 9uyAOtiXvhfyeVn5WoXdfgebgNEY5FKRwfDcZqOUoZgl64K/FG587YelQmfniAwvojdRyedKT
 Fovx5KnZE0maY1fLcGbK1Pe/ck/Ec0u/L4rEfISYr9JUMtoNDmLXOLcqHKud1SwFFuZvwaJB6
 fUg9s6NZDJYOHWbw4TfjSAkrKzYML9qgSzvP+YhoGw6zCSDJhUD/u5/zw2MxWrj+2nPp67ixD
 oyY0Oj3ys72h4RJ2rSQ0OKRyQCWMUXWr/8kZM09bcx7X0VykGhlh+xZTpBmnZQM74zC5b/M59
 +xwZFhyRPU0h9LjlNdo/HLGCrQtBkIPg5x8KNdhohQBPPLqMNXrsvNh6k0etHxnjLhwf6FHtM
 y5A9Mh7WHAKmJCkOttnHXTyBb3hwm6mfIA4KtSccqgePP3qbREGPQ7W3CNhCO4qMzbcOlOceb
 QFFiyMC/Wkk9gXgFSVIBkxe9A6YZDzM6YHDBjH2sO8qne3FJADxjFxQ5h2Y9DX+bqhKbGxy/e
 Bom9YgDQbNnGu+kWs24MVuYPOZgo0xK01VdTkeNBUrdGlWL0SScnwI8lCP3u1RLXZA6AalJIh
 fsEpdgurPUWsZosGTX73sc/NDu+yJc9VHJgbLmfYqHZAVxSV1H/4P9bv4uGB9hNUvE5laGVQa
 s1efLUJsY5hRyU9LY7yxg4msPE5Wxky1qWilpuYJm4EXpeolhvYUAQkcfviXUxEB7EElzeeL9
 ERjMAEyNnv9tFZX8lWiCUlc8+89Bh9dyxuExgMTrnLN9mv17rLLndrU1W6aL7oRAofz0+9k8L
 z7R+Ad0yO8il50acINyyrgh8QUly/yAfxYKOUBgTPwflQ/PU93cFQv5fjDzoWvw/y4qrHeUWI
 U6olcMiJAzVsMR2/Y51eJsDAefm4/NtOQvu0nr2raqEFNIbJZQGoZcVWj27OtAvUdkhlggBe7
 VDHRfOUKy0g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fsl,imx50-evk has been used in a devicetree for a while. kobo,aura will
be used soon.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v2: New patch, as suggested by Shawn Guo
=2D--
 Documentation/devicetree/bindings/arm/fsl.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentatio=
n/devicetree/bindings/arm/fsl.yaml
index 7e2cd6ad26bd..618bf58796eb 100644
=2D-- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -51,6 +51,13 @@ properties:
           - const: i2se,duckbill-2
           - const: fsl,imx28

+      - description: i.MX50 based Boards
+        items:
+          - enum:
+              - fsl,imx50-evk
+              - kobo,aura
+          - const: fsl,imx50
+
       - description: i.MX51 Babbage Board
         items:
           - enum:
=2D-
2.20.1

