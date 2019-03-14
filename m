Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEAAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4CF2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=openedev.com header.i=@openedev.com header.b="T7aoFyaS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfCNIN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 04:13:26 -0400
Received: from se15t.web-hosting.com ([162.255.118.154]:60251 "EHLO
        se15t.web-hosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfCNIN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 04:13:26 -0400
Received: from [68.65.123.203] (helo=server153.web-hosting.com)
        by se15.registrar-servers.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <akash@openedev.com>)
        id 1h4KfS-0004zi-6E; Thu, 14 Mar 2019 00:20:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=openedev.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=p7oBEUindrNXrdVNdE/N1Btj9T8KDQpLx5eEhEcMwOo=; b=T7aoFyaSbzkD1ZuP2sS8XFRX6v
        aOfS+MgqPDOWMfe49wcb/YpQ45CPDNmhHXsQqADonOEs2i3vwb3bTCNLsmLHQ6wW97p9ZWhgFDi9B
        qCV6IgEc9LMS5lKwEqRNzOXji64rxzaiydHtuDqvGdzOjSuetJrFVcvVVg2mF5yWch5J9/pBbkJqM
        PHGTh4tWnQmgrfU5rXJN+dA1Jkinub8H+HBt1UHdxpOQL5gGiYSFpaieNgz2EeB95ftNi8v7tsV76
        c2/1g6XiARSALqrFaHTxl+3mWMdPdbdZCJD2LdEGyuINpGpkQPnK0NnHlyDGd4tgKa3d8/+ciSJ9D
        2hWTZ+Kw==;
Received: from nat-inn.mentorg.com ([192.94.34.34]:19766 helo=agajjar-vr.inn-wifi.mentorg.com)
        by server153.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <akash@openedev.com>)
        id 1h4KfK-002iQG-08; Thu, 14 Mar 2019 03:20:35 -0400
From:   Akash Gajjar <akash@openedev.com>
To:     heiko@sntech.de
Cc:     Akash Gajjar <akash@openedev.com>,
        =?UTF-8?q?Andrius=20=C5=A0tikonas?= <andrius@stikonas.eu>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vicente Bergas <vicencb@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: rockchip: add mali gpu support on rockpi4
Date:   Thu, 14 Mar 2019 12:48:41 +0530
Message-Id: <20190314071853.32176-2-akash@openedev.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190314071853.32176-1-akash@openedev.com>
References: <20190314071853.32176-1-akash@openedev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OutGoing-Spam-Status: No, score=-0.5
X-Originating-IP: 68.65.123.203
X-SpamExperts-Domain: nctest.net
X-SpamExperts-Username: whmcalls3
Authentication-Results: registrar-servers.com; auth=pass (login) smtp.auth=whmcalls3@nctest.net
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.03)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5ij+o4XTbdl80nGjUslSxGF602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO9Kz5dih1EthU2MWX/atyIZ0kTMsB94LwW8ZN2sS57gfLwzUX7TXOtaq5aORn2baFRjr
 dLldmwqWZjEw2lWOqONg+6d+vVnClNcaHHg4+HBie3u1qNGW8JhNDRlyXw90mNUojfcw2mvVYgaF
 7R4Nq6PF5EYYKsv1Iy1+p+sENA/1KiBNZ07bQDadIcu8/csL3oG7nsM6SxDKJRrjvIldwrEvf/h3
 fSiR6G1ZJmhs4dtpFHegK+QIj3D1cFGWe4EhszEXR00Vk7A+XBJm/gJGXhFB7E8QnXyyk/hIi6CM
 s/aTvbJpT/mxZlO1IZshKr1EmeODS0oxiz8CEBqhTHaeiLrQQFzDBjhPYYLyyVl/DO04GZWT6Tsv
 DXKv683dSPZhX8v6RglqCRiWLLlJfXqOwsSEQ1zg63VRC9n5o9IubHRCajhI/osHQYQOY9tKQuYh
 V0/2daO84E+CJIUWxPZgHA4oVG4R1QSBae5eMu8El8wp8YJwPcY3BZj5hjW3jSN7kDZQ6OtBjX2d
 hf8r1xeX6dGaEFvYj4y8eeqFFdtAEhWvd4DaCK6Pjpd0ktFAUcyBO1wJcz06mWheBRpSDkCuyxjZ
 VLoBIQ/0Yot61dtATH/YcHV3Z1OBPe/w0eb4hi6pY39q0aZI3qbhXsaDdLgW9bq7ONs0Jo7siUxp
 CnbQuxznTS5wWhJczORue9s9vxMyvT3ZEg7qDAZihU7TNifj61aWKjPv6Se6da4XjLm88/LDLnDH
 LQNX6Z9k7LHvI3S8k8yoD25LMd/8Q6GyVYHQHyyqls2q2f6GiuILRCoVzcAUesmMQdfOVPytGy0v
 aP8A+OIp7Ll3zg39paKeqrIPi/nXs2KsRjKrCowEavDwQuKonn43CVihpNXqOZnA1kmofBq13Vtd
 PYPpQDJAG8jZaE6kPx28ZCmzF6xraiN8yTq5LrsYgOOLVP0PfMA01LCiikBDOYLztKvzrLSd1VxM
 Ru4N5NrpfsZsRnl/I/FTR139Shj4g7fEqX8BGOvWI8yqhtlg1q14MI9rG0MenXlswhagQUZsv+gI
 bNgg9Wk/fX2SRnPRYcAeHV8hxEmZPAz5djibSz1TZEeHqHdttKvBUzCN4NAlGxY6r4hMSxGQ+U5v
 Nu4rMPKlzWU9qMOiGXHBuQl7kvd3Y9+UVnnGTsDuvLq0N5hlE2LuZbV6X+y312KNJBBUMCfNurEz
 NHtW0EZg83LYM3A6BXfvel8OEFDbU50ueTym1wgy3QoDz1w5VXFhebjHJPwXPZ6YHMJ8vHED6QY4
 ei+01UVhKsXWCf/f12Vc+wcBvq1ZAdP9Br8WkgqueLGXOud3vgQ6Lwxr8Zs7itcxKJJ78am5WUrT
 xjBCYAo5Ix7/C9VwqPH/5QpQnZ0BqABLpxpkKfYdpWqgBL2Mh16HX+6x4KcU/f2CYrvOMnz/q172
 TuUUAfA6uqFnxU12
X-Report-Abuse-To: spam@se16.registrar-servers.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add gpu node support on board and add the supplying regulator

Signed-off-by: Akash Gajjar <akash@openedev.com>
Signed-off-by: Andrius Štikonas <andrius@stikonas.eu>
---
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts
index 4a543f2117d4..1e479d06e67e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts
@@ -157,6 +157,11 @@
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&vdd_gpu>;
+	status = "okay";
+};
+
 &hdmi {
 	pinctrl-names = "default";
 	pinctrl-0 = <&hdmi_cec>;
-- 
2.17.1

