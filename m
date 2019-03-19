Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2415BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E158F2177E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="M6DnObNH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfCSPZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:25:10 -0400
Received: from mout.gmx.net ([212.227.17.22]:35213 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727661AbfCSPZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 11:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553009079;
        bh=Pko7ezwagGTe18JIsO/c11K0PwjfQ1g1lrIGGnUWh5M=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=M6DnObNHhK8jvmlMM5tbodz4WHHAzt8QYdtZxGr06Yzr2Ackbb77oS7g5wb3yN/+I
         Vjc87Yy0hFsmYTRur8XWjrfQP/IVtBlgDE51RvrLy9aSLzyZKfEy4MRYxOJdmSycxM
         OFjLpfFzJ6Rmhq9HFcK0voxEdj8t5Chnh2wg2xd4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M3NEK-1gosFD00Jc-00qz4U; Tue, 19
 Mar 2019 16:24:39 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <treding@nvidia.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 1/5] dt-bindings: Add vendor prefix for Rakuten Kobo, Inc.
Date:   Tue, 19 Mar 2019 16:24:16 +0100
Message-Id: <20190319152421.16179-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190319152421.16179-1-j.neuschaefer@gmx.net>
References: <20190319152421.16179-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YVWsPSmUV2YpZNYVpkNQezUqfQG93zHhqEw39dM+feuXEk8j7D0
 NwCt7NeuVvzhgYfj2NohuAuLOnEMndxjthAnR+qlq/ffBwDj6V2H1MjM9mjr5N3c5bUDFmm
 dgEFqn3bU4QdxWRBviiHDZY0JieUwxntZ4IJKAY0ZHDlxSZw/I4dg3qcW1KULVNOOeCmQuq
 +G6Xct8RCRROf8WVGafBw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4P7NY6fdm+w=:GZ/OJdaYUrHvhJNUely6ic
 g49kB+Exhf0Jc6gAtdKTpiw9VsRIAc6jCYjieuEp5unv1BhMrUzRDfg46/Q/oo8Aoz3Cw0GIi
 AF2z4zPMD74T+92pBIjyBlnWtOLWR+HYFxUyOy1nQXItCKjFau7mSTaPPUmqPzfRAf7urZJpU
 6Beixr+G8x0aVyIUp+YDctJelWjNyKkqqimzzLUPmomQSUEJUuoYo2CCxDDTVZWosDRoot+jC
 /AwjEr8EAihgjqnThFDHrZGfhn2qeg50UKGsKIdtpZC+JnFX8DKLPqvdeFMw7cxXqURMfRoip
 /G3akQjcmO4ScldMp2zihCaNtfsbJF59fUpbMwWbgptKbUts8TunBzdS67snDGqM1emhhl+Qk
 MY628/d+JOqm9U47QJ2RTXMcpQ/a1Y1sORmlyhRXPJi+oXfXAryuvL/vQ4mc7k08e2eH7L24i
 usNGaT6Uho6YPwCCLGZIDqH0Ba+qYAbfsIqeGld8XL2Dtgziwi0ajOyOYqZTnL45xupjQWWCP
 5QDuI0Q2Gl2NOpvKSZSMkLvxucky7RNdXN5gHl6b7aIWfZtjBNlUrww8OHHNmDlLPNZPjh4kq
 DoX2pHrlsBnIbdFsX3S3YR8+n2yxdit1r0o0lh2PsZmGyUTY0Vw+Lvpl/hHbM6VC44tdsI09P
 M5mEyyvN+HeC+iL2ympi0dHWHnpB6wF+jI2Pfo9bGo/lJ7tYmq9xKHUpOxyKiVFYvUFe4pzCp
 e1p8CCELHWPhmg+h+pjKa/p7bMa7CMbi89R2A4oaih7pdqYi01naSTJrnERdzeIkM186itfvU
 +vrwH9NyBgvlnYPOM9oKzvUP2RQJCyDl6SQnXXVq37V4HcI1fxgRpVmRK2Xh35xXl6/P6O44+
 LEOYcyuTmR3o7FmYtwxWp2g5n3Evg64c+w6GWfZJ+KfBT+vlBAuI7xf9Uq6MXSPE7LQZEnWiz
 S8wus6lyPUQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rakuten Kobo, Inc. (formerly Kobo, Inc.) is a company that sells e-book
readers and related products. More information is available at:

- https://en.wikipedia.org/wiki/Kobo_Inc.
- https://www.kobo.com/

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
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

