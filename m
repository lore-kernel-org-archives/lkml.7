Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFCAC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 16:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2125421655
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 16:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=singleboardsolutions.com header.i=@singleboardsolutions.com header.b="Z6F45GnZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbfLLQHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 11:07:40 -0500
Received: from gateway33.websitewelcome.com ([192.185.146.80]:29841 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729247AbfLLQHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 11:07:39 -0500
X-Greylist: delayed 1285 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Dec 2019 11:07:38 EST
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id F2FFB567C0D
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 09:46:11 -0600 (CST)
Received: from e36.ehosts.com ([192.185.128.17])
        by cmsmtp with SMTP
        id fQfLi3ZCnOdBHfQfLiCfkj; Thu, 12 Dec 2019 09:46:11 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=singleboardsolutions.com; s=default; h=Message-ID:CC:To:Date:From:Subject:
        Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UMrk7SVJBaZoF5+E4IWNlDb5JQkYTRr384MzHtkSMNA=; b=Z6F45GnZxN2pseuh0IHHkf69/s
        ZLOxtsygVBMQDpO7ull4wMLqcSmdySbPZvytspNyu2pUslfuHN/55s2KRqikKLBC5+E5gapNgaaXl
        NAknwJTUy7yBoxUao54lCEhsviPaOlUAFap8Ls3ZQ7zGD04OjmJjFdakIOnDIAgOkGblTHOpaKUT7
        GGxhZmp2azaq1Yd6hLkYjDBMnUAuljMr/tgsucpANmmnJAwdndG6GDFTNKm68bwyqQ7U/+Om0ahbG
        5/4QYPZzmFm75kkCvNBRN3X/3NRJvQnmkWKmlccw/oAe1JruqtpbPQdf2pErpAlMCdRfUTE3lSC2T
        vkLtKQHA==;
Received: from [172.58.138.77] (port=57064 helo=[IPV6:2607:fb90:1784:5f4e:a5d4:b11d:2550:9cec])
        by e36.ehosts.com with esmtpa (Exim 4.92)
        (envelope-from <tmckahan@singleboardsolutions.com>)
        id 1ifQfL-001viD-Fm; Thu, 12 Dec 2019 08:46:11 -0700
In-Reply-To: <678df227-38be-47af-7ee3-741a391a196c@fivetechno.de>
References: <678df227-38be-47af-7ee3-741a391a196c@fivetechno.de>
X-Referenced-Uid: 55
Thread-Topic: [PATCH 2/3] arm64: dts: rockchip: Enable PD for USB-C-Port on rk3399-roc-pc.
X-Is-Generated-Message-Id: true
X-Blue-Identity: !l=635&o=43&fo=3004&pl=525&po=0&qs=PREFIX&f=HTML&n=Thomas%20McKahan&e=tmckahan%40singleboardsolutions.com&m=!%3ANDg0ODA5OGEtZmVjOS00NjIyLTkwMTUtZGI5MTM5OGY1ZGU3%3ASU5CT1g%3D%3ANTU%3D%3AANSWERED&p=491&q=SHOW
User-Agent: Android
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 2/3] arm64: dts: rockchip: Enable PD for USB-C-Port on rk3399-roc-pc.
From:   Thomas McKahan <tmckahan@singleboardsolutions.com>
Date:   Thu, 12 Dec 2019 10:46:09 -0500
To:     Markus Reichl <m.reichl@fivetechno.de>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        narmstrong@baylibre.com
Message-ID: <84920a36-230f-42a6-a960-a71e685be99f@singleboardsolutions.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - e36.ehosts.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - singleboardsolutions.com
X-BWhitelist: no
X-Source-IP: 172.58.138.77
X-Source-L: No
X-Exim-ID: 1ifQfL-001viD-Fm
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([IPV6:2607:fb90:1784:5f4e:a5d4:b11d:2550:9cec]) [172.58.138.77]:57064
X-Source-Auth: tmckahan@singleboardsolutions.com
X-Email-Count: 2
X-Source-Cap: ZWxlY3RyaTk7ZWxlY3RyaTk7ZTM2LmVob3N0cy5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Markus,

=C2=A0=C2=A0=C2=A0 I have been working with this as well, ca=
me across it on Armbian=2E I was also trying to eliminate the warning conce=
rning the lack of port with limited success=2E=C2=A0 I also missed the inte=
rrupt pin definition I see=2E=C2=A0 I will test this later today=2E=C2=A0 
=

=C2=A0=C2=A0 I've added Neil Armstrong for information in case any boards =
on the Amlogic side are similarly configured, I think a few other Rockchip =
ones at least are missing connector nodes, it appears to be a consistent is=
sue presumably due to driver changes=2E

-Tony


=E2=81=A3

On Dec 10, 2019=
, 7:45 AM, at 7:45 AM, Markus Reichl <m=2Ereichl@fivetechno=2Ede> wrote:
>U=
SB-C-Port 0 on rk3399-roc-pc is designed to supply the board=2E
>To meet th=
e power requirements of up to 45W a power delivery (PD)
>compatible supply =
is needed=2E To configure the PD the node of the
>fusb302 needs a connector=
 property with desired PD description=2E
>
>Signed-off-by: Markus Reichl <m=
=2Ereichl@fivetechno=2Ede>
>---
>Presently the board in mainline has to be =
powered from a 12V supply,
>connected to two pins on the expansion header a=
s the standard 5V
>delivered by the unconfigured USB-C plug is not enough f=
or higher
>loads or peripherals on USB or M=2E2=2E
>
>With this patch the b=
oard requests 15V from the PD and runs fine
>on high loads with NVME SSD, E=
thernet, SDIO WLAN and USB peripherals=2E
>During boot the 12V supply is st=
ill needed for some seconds,
>as the fusb302 shuts down or resets the PD sh=
ortly when initializing
>(BUG?)=2E
>
>The board's 12V line is running prese=
ntly on 5V, the default output
>voltage of the MP8859 on I2C-7, for wich no=
 mainline kernel driver
>exists yet=2E
>---
>  arch/arm64/boot/dts/rockchip=
/rk3399-roc-pc=2Edtsi | 16 ++++++++++++++--
>  1 file changed, 14 insertion=
s(+), 2 deletions(-)
>
>diff --git a/arch/arm64/boot/dts/rockchip/rk3399-ro=
c-pc=2Edtsi
>b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc=2Edtsi
>index 8e0=
1b04144b7=2E=2E90783b2b1d1f 100644
>--- a/arch/arm64/boot/dts/rockchip/rk33=
99-roc-pc=2Edtsi
>+++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc=2Edtsi
>=
@@ -6,6 +6,7 @@
>  /dts-v1/;
>  #include <dt-bindings/input/linux-event-cod=
es=2Eh>
>  #include <dt-bindings/pwm/pwm=2Eh>
>+#include <dt-bindings/usb/p=
d=2Eh>
>  #include "rk3399=2Edtsi"
>  #include "rk3399-opp=2Edtsi"
>  
>@@ =
-540,11 +541,22 @@ fusb0: usb-typec@22 {
>  		compatible =3D "fcs,fusb302";=

>  		reg =3D <0x22>;
>  		interrupt-parent =3D <&gpio1>;
>-		interrupts =
=3D <2 IRQ_TYPE_LEVEL_LOW>;
>+		interrupts =3D <RK_PA2 IRQ_TYPE_LEVEL_LOW>;=

>  		pinctrl-names =3D "default";
>  		pinctrl-0 =3D <&fusb0_int>;
>  		vb=
us-supply =3D <&vcc_vbus_typec0>;
>-		status =3D "okay";
>+
>+		usb_con: co=
nnector {
>+			compatible =3D "usb-c-connector";
>+			label =3D "USB-C-0";
=
>+			power-role =3D "dual";
>+			try-power-role =3D "sink";
>+			source-pdo=
s =3D <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
>+			sink-pdos =3D <PDO_=
FIXED(5000, 3000, PDO_FIXED_USB_COMM)
>+				     PDO_VAR(5000, 15000, 3000)=

>+				     PDO_PPS_APDO(5000, 15000, 3000)>;
>+			op-sink-microwatt =3D <4=
5000000>;
>+		};
>  	};
>  };
>  
>-- 
>2=2E24=2E0
>
>
>___________________=
____________________________
>Linux-rockchip mailing list
>Linux-rockchip@l=
ists=2Einfradead=2Eorg
>http://lists=2Einfradead=2Eorg/mailman/listinfo/lin=
ux-rockchip

