Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18522CA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E49BD2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbfJUKYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 06:24:50 -0400
Received: from wp126.webpack.hosteurope.de ([80.237.132.133]:34158 "EHLO
        wp126.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727767AbfJUKYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 06:24:50 -0400
Received: from [2003:a:659:3f00:1e6f:65ff:fe31:d1d5] (helo=hermes.fivetechno.de); authenticated
        by wp126.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1iMUre-00016G-4C; Mon, 21 Oct 2019 12:24:38 +0200
X-Virus-Scanned: by amavisd-new 2.11.1 using newest ClamAV at
        linuxbbg.five-lan.de
Received: from [192.168.34.101] (p5098d998.dip0.t-ipconnect.de [80.152.217.152])
        (authenticated bits=0)
        by hermes.fivetechno.de (8.15.2/8.14.5/SuSE Linux 0.8) with ESMTPSA id x9LAOa9m003414
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 21 Oct 2019 12:24:37 +0200
From:   Markus Reichl <m.reichl@fivetechno.de>
Subject: [PATCH] arm64: dts: rockchip: Add LED nodes on rk3399-roc-pc
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Autocrypt: addr=m.reichl@fivetechno.de; prefer-encrypt=mutual; keydata=
 xsDNBFs02GcBDADRBOYE75/gs54okjHfQ1LK8FfNH5yMq1/3MxhqP7gsCol5ZGbdNhJ7lnxX
 jIEIlYfd6EgJMJV6E69uHe4JF9RO0BDdIy79ruoxnYaurxB40qPtb+YyTy3YjeNF3NBRE+4E
 ffvY5AQvt3aIUP83u7xbNzMfV4JuxaopB+yiQkGo0eIAYqdy+L+5sHkxj/MptMAfDKvM8rvT
 4LaeqiGG4b8xsQRQNqbfIq1VbNEx/sPXFv6XDYMehYcbppMW6Zpowd46aZ5/CqP6neQYiCu2
 rT1pf/s3hIJ6hdauk3V5U8GH/vupCNKA2M2inrnsRDVsYfrGHC59JAB545/Vt8VNJT5BAPKP
 ka4lgIofVmErILAhLtxu3iSH6gnHWTroccM/j0kHOmrMrAmCcLrenLMmB6a/m7Xve5J7F96z
 LAWW6niQyN757MpgVQWsDkY2c5tQeTIHRlsZ5AXxOFzA44IuDNIS7pa603AJWC+ZVqujr80o
 rChE99LDPe1zZUd2Une43jEAEQEAAc0iTWFya3VzIFJlaWNobCA8cmVpY2hsQHQtb25saW5l
 LmRlPsLA8AQTAQoAGgQLCQgHAhUKAhYBAhkBBYJbNNhnAp4BApsDAAoJEDol3g5rGv2ygaMM
 AMuGjrnzf6BOeXQvadxcZTVas9HJv7Y0TRgShl4ItT6u63+mvOSrns/w6iNpwZxzhlP9OIrb
 v2gorWDvW8VUXaCpA81EEz7LTrq+PYFEfIdtGgKXCOqn0Om8AHx5EmEuPF+dvUjESVoG85hL
 Q6r6PJUh8xhYGMUYMer/ka2jAu2hT1sLpmPijXnw9TvC2K9W3paouf4u5ZtG32fegvUeoQ1R
 t30k0bYRNqX8xboD1mMKgc4IWLsH6I0MROwTF7JvarkC9rU/M6OL6dwnNuauLvGVs/aXLrn2
 UYxas9erPOwr+M45f8OR7O8xxvKoP5WSU6qWB/EExfm/ZBUkDKq8nDgItEpm+UUxpS9EpyvC
 TIQ3qkqHGn1cf2+XRUjaCGsRG6fyY7XM4v5ariuMrg8RV7ec2jxIs3546pXx4GFP6rBcZZoW
 f6y2A6h47rWGHAhbZ6cnJp/PMDIQrnVkzQHYBkTuhTp1bzUGhCfKLhz2M/UAIo+4VNUicJ56
 PgDT5NYvvc7AzQRbNNhnAQwAmbmYfkV7PA3zrsveqraUIrz5TeNdI3GPO/kBWPFXe/ECaCoX
 IVfacTV8miHvxqU92Vr/7Zw7lland+UgHa7MGlJfNHoqXIVL8ZWAj+mGf4jMo02S+XtUvdL7
 LtALQwXlT7GD0e9Efyk/AV9vL8aiseT/SmW6+sAhs9Q7XPvZWE/ME1M/WRlDsi32g04mkvOz
 G/bGN9De+LoSgn/220udTgLpq2aJEYGgvgZRVDKeOGSeP9cAKYQPjsW0okFfVyezZubNHLwd
 yjVFxGB2XIH/XIVo13E2SFvWHrdjmCcZek37k4uftdYG90iBXS3Dtp0u87yiOIoL2PXM8qLU
 2+FhXphjce6Ef33nKQpelWLXxlrXUr1lOmNTAHfVIsKmGsRBqRBmphLMJOfyD6enYR0B/f+s
 LVDtKFrMzhkjqvanwlcQkbpN6DvD409QRaUwxQiUaCcplUqHnJvKdjO7zCI4u6T6hjvciBrg
 EBB+uN15uGg+LODRZ4Ue0KaWoiH6n1IxABEBAAHCwN8EGAEKAAkFgls02GcCmwwACgkQOiXe
 Dmsa/bKWFgwAw3hc1BGC65BhhcYyikqRNI6jnHQVC29ax1RTijC2PJZ5At+uASYAy97A2WjC
 L3UdLU/B6yhcEt3U6gwQgQbfrbPObjeZi8XSQzP2qZI8urjnIPUG7WYDK8grFqpjvAWPBhpS
 B5CeMaICi9ppZnqkE3/d/NMXHCU/qbARpATJGODk64GnJEnlSWDbWfTgEUd+lnUQVKAZfy5Z
 5oYabpGpG5tDM49LxuC4ZpTkKiX+eT1YxsKH9fCSFnETR54ZVCS7NQDOTtpHDA2Qz2ie3sNC
 H7YyH580i9znwePyhCFQQeX+jo2r2GQ0v+kOQrL9wwluW6xNWBakhLanQFrHypn7azpOCaIr
 pWfxOm9CPEk4zGjQmE7sW1HfIdYC39OeEEnoPdnNGxn7sf6Fuv+fahAs8ls33JBdtEAPLiR8
 Dm43HZwTBXPwasFHnGkF10N7aXf3r8WYpctbZYlcT5EV9m9i4jfWoGzHS5V4DXmv6OBmdLYk
 eD/Xv4SsK2JTO4nkQYw8
Organization: five technologies GmbH
Message-ID: <7d8d85c9-5fde-7943-a6b6-639bca38bdc1@fivetechno.de>
Date:   Mon, 21 Oct 2019 12:24:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ma6Nskd4tpvP5vsRVUnUWsgiIS2DwbBnW"
X-bounce-key: webpack.hosteurope.de;m.reichl@fivetechno.de;1571653489;eae68682;
X-HE-SMSGID: 1iMUre-00016G-4C
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ma6Nskd4tpvP5vsRVUnUWsgiIS2DwbBnW
Content-Type: multipart/mixed; boundary="yJZwcp1Ymsuklh7aGS9WMHUNJ1nnL5i5j";
 protected-headers="v1"
From: Markus Reichl <m.reichl@fivetechno.de>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Heiko Stuebner <heiko@sntech.de>, Jagan Teki <jagan@amarulasolutions.com>,
 Markus Reichl <m.reichl@fivetechno.de>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Message-ID: <7d8d85c9-5fde-7943-a6b6-639bca38bdc1@fivetechno.de>
Subject: [PATCH] arm64: dts: rockchip: Add LED nodes on rk3399-roc-pc

--yJZwcp1Ymsuklh7aGS9WMHUNJ1nnL5i5j
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

rk3399-roc-pc has three gpio LEDs, enable them.

Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
---
 .../arm64/boot/dts/rockchip/rk3399-roc-pc.dts | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts b/arch/arm64/=
boot/dts/rockchip/rk3399-roc-pc.dts
index faf60b2a7673..ba52e1053a2d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
@@ -28,6 +28,33 @@
 		#clock-cells =3D <0>;
 	};
=20
+	leds {
+		compatible =3D "gpio-leds";
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&work_led_gpio>, <&diy_led_gpio>, <&yellow_led_gpio>;
+
+		work-led {
+			label =3D "green:work";
+			gpios =3D <&gpio2 RK_PD3 GPIO_ACTIVE_HIGH>;
+			default-state =3D "on";
+			linux,default-trigger =3D "heartbeat";
+		};
+
+		diy-led {
+			label =3D "red:diy";
+			gpios =3D <&gpio0 RK_PB5 GPIO_ACTIVE_HIGH>;
+			default-state =3D "off";
+			linux,default-trigger =3D "mmc1";
+		};
+
+		yellow-led {
+			label =3D "yellow:yellow-led";
+			gpios =3D <&gpio0 RK_PA2 GPIO_ACTIVE_HIGH>;
+			default-state =3D "off";
+			linux,default-trigger =3D "mmc0";
+		};
+	};
+
 	sdio_pwrseq: sdio-pwrseq {
 		compatible =3D "mmc-pwrseq-simple";
 		clocks =3D <&rk808 1>;
@@ -494,6 +521,20 @@
 		};
 	};
=20
+	leds {
+		work_led_gpio: work_led-gpio {
+			rockchip,pins =3D <2 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		diy_led_gpio: diy_led-gpio {
+			rockchip,pins =3D <0 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		yellow_led_gpio: yellow_led-gpio {
+			rockchip,pins =3D <0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	pmic {
 		vsel1_gpio: vsel1-gpio {
 			rockchip,pins =3D <1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_down>;
--=20
2.20.1





--yJZwcp1Ymsuklh7aGS9WMHUNJ1nnL5i5j--

--ma6Nskd4tpvP5vsRVUnUWsgiIS2DwbBnW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEVKeIeBh0ZWJOldzLOiXeDmsa/bIFAl2th2QACgkQOiXeDmsa
/bKXBwv7BhRzi03I9j+Me1Zp9yG27lXAQ6FOPpHmt5GJdmFZkpuurRQQ6lBOJmfd
61KOr6gNYLLVObMeRcZ30gonXE5TK0lLP6mOajtI4YBB0+/4dy3Kwf5qzmtAIaM3
47NZ9WiTlxR7Oh1ESVFLxGk7exnMq1R0zF2TLafDZxP1vZXcow7aCpgcx8HMgivf
DN+uAQ8+mMCd3i7heyBrqDUx4oBQamdPF20SpRSfX6oNMmNbO9Vno2ly8JfXBv9O
1+ThOXF+wVnO5V3Q2OQdHsyZGt3vZDugnbq9RQXjdpJkJfA3rmuGgCgnOcad0+11
g0kxyU+0il07SuUVfXVZXGraWYZ4WyOpKkOOD5YhWP8cYSK4tOFQlCpeNo/UykHc
F6bXAwcc8x5naL2J6L4N4hFmGI4I0woqZsTKNX4gHPi30XHf91mJ5n2TatPCquZ0
Li6fangI5vix3UEMbiFF09g9rKYg2k8v/UiTjYgkj5qMdklM3qgMTToYYq1rm2ay
yWfVA1OG
=KTOi
-----END PGP SIGNATURE-----

--ma6Nskd4tpvP5vsRVUnUWsgiIS2DwbBnW--
