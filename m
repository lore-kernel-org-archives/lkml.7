Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778B6C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 19:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 457A020882
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 19:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ekKuPid3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731520AbfCaTQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 15:16:39 -0400
Received: from mout.gmx.net ([212.227.17.22]:42017 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731476AbfCaTQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 15:16:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554059777;
        bh=4kjV2qohI5s4Okw4s8UDDiR2ogODeNDc9QTkPa88sT8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ekKuPid3WLVvk9gVI9oOhwDxEZOIMc3NUOnlA84DQ7YfY6cujLslhP0o6S14bLg6B
         nKSmmfVx6JcqOcqrBRNgTx9J8j+xz4Gf8Z/UPECbrNScEL5MFR6DtdkswTSqQLm43y
         9uku/mBIPWi6hzUBcY2aP1SfqPQfSIRF3iPd2PT4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LaaVn-1gWRBO0rBn-00mKKT; Sun, 31
 Mar 2019 21:16:17 +0200
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
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: Add vendor prefix for Rakuten Kobo, Inc.
Date:   Sun, 31 Mar 2019 21:16:00 +0200
Message-Id: <20190331191602.3921-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190331191602.3921-1-j.neuschaefer@gmx.net>
References: <20190331191602.3921-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Fb20ANVqUJwa5temuk6zgGS8Ux1VRfWD06s9LFliq93DCFs+iHl
 ZCAn4deMKS3aFh8exN088dFWtXUGUE9JNq1bWPgGKg5zpQboOGifJ00vPKDbiOjpyOsoWqa
 N8pSp0P34BcHZ5e7C9VH/x9aPMCnmxsRmSLannHIiBmcGpGElXN0WatlhFe+W9MHCLd2gWB
 RUmTzVN+PAuusJpWf2EwA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HsOJBwEvQYo=:lFGqpJhi6cRsRd5xAHKFd4
 URGWMwBrz2nnMm59L96wU+WpQ+or24helNM73bx8I6JH0/KEqsaGrFWgJJQsrapaWPInv2fHz
 6OFYJvaIe6hHimjgLMfR+Ut5OF2a1gEyqsLX5h+XRg1ScJJkqoD2fzgmC4E5LsIhA47snMbGb
 hS6M6Ocx8V/6OqqG8o3jmsIbi1ZGu4Y+1s9XnyPSsBJgZOH8ds1WNuRbG29oxPrbfQJ8ZTZvM
 0n3TRb7RKFVMAuL0RtP3Df4yHahidvK6YSOQHPq5eKi8dLt6/rmq6tstIEMtclGrHd4u3rDs6
 hDjjBOljd/sTO+evDpH/MfGMcX0cdeVThSYOSsAP7lc7TapqOLaBvrLDlh/drtcDqHjPNZJfO
 HoF0hvh8YZBWxS17gsdNllkL8gzmPcCiZOqzr58TnXfLZelDfLhaZ7ug6wbj6GxTZu2VvOYC0
 idvm4aC0sYs/CXP+wGoSBeml+TK6s2eHmegUzww7LKkcLQfvMxxHx/MowY/M5+t2bcey3+RrC
 +tymMHuQD4/N6RXKWrfEjGf9K80BxjnRaw8WL9RCEETJsqihk26qoxxyn4e6tWtQTzsRU5W47
 QjIm89qTJZcN7HaOk/Vt4X0zAnXMyCSL5DmNNsvCsO0LIL/vZkBycX/wq2Fh8u7sZFJnANuey
 vZGGQMWRLtpU41m02SFASvABTDicBDuUMk0PCI3guGLD0ImmetyvOzfhwhVzBAJQ/hXsnbadF
 UFYlcFQpmEcaddfnJ+RJpd4cDa9eYA+eEuVTBROAoS8tnaHQWoan7ne5YwlMdLINzsrYsvl3+
 VzWiHGBx2bjzSVn344vcpbe45lXpVHZaEoA1lh2nmGB15q5/t6QEZ8Is9bJ3AQT3YObBxidJg
 CLS7ONoDm/r3Ajm+PnaWo5NIiGdV0aqD3KmEBXE5diutedADE+Q19hZjNf0DWP/bSGWQWulCH
 EG0uINcH28w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rakuten Kobo, Inc. (formerly Kobo, Inc.) is a company that sells e-book
readers and related products. More information is available at:

- https://en.wikipedia.org/wiki/Kobo_Inc.
- https://www.kobo.com/

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Reviewed-by: Rob Herring <robh@kernel.org>
=2D--
v2:
- Add Rob Herring's R-b

v1:
https://lore.kernel.org/lkml/20190319152421.16179-2-j.neuschaefer@gmx.net/
=2D--
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Docum=
entation/devicetree/bindings/vendor-prefixes.txt
index 8162b0eb4b50..6cc50f1fac1c 100644
=2D-- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -210,6 +210,7 @@ kiebackpeter    Kieback & Peter GmbH
 kinetic Kinetic Technologies
 kingdisplay	King & Display Technology Co., Ltd.
 kingnovel	Kingnovel Technology Co., Ltd.
+kobo	Rakuten Kobo Inc.
 koe	Kaohsiung Opto-Electronics Inc.
 kosagi	Sutajio Ko-Usagi PTE Ltd.
 kyo	Kyocera Corporation
=2D-
2.20.1

