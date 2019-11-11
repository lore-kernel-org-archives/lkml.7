Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29DBC17445
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A1D21D7F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfKKOVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:21:44 -0500
Received: from wp126.webpack.hosteurope.de ([80.237.132.133]:58150 "EHLO
        wp126.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726811AbfKKOVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:21:44 -0500
Received: from [2003:a:659:3f00:1e6f:65ff:fe31:d1d5] (helo=hermes.fivetechno.de); authenticated
        by wp126.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1iUAZY-0001Oc-6s; Mon, 11 Nov 2019 15:21:40 +0100
X-Virus-Scanned: by amavisd-new 2.11.1 using newest ClamAV at
        linuxbbg.five-lan.de
Received: from [192.168.34.101] (p5098d998.dip0.t-ipconnect.de [80.152.217.152])
        (authenticated bits=0)
        by hermes.fivetechno.de (8.15.2/8.14.5/SuSE Linux 0.8) with ESMTPSA id xABELdcG011493
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 11 Nov 2019 15:21:39 +0100
From:   Markus Reichl <m.reichl@fivetechno.de>
Subject: [PATCH] arm64: dts: rockchip: Add regulators for pcie on
 rk3399-roc-pc
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Autocrypt: addr=m.reichl@fivetechno.de; prefer-encrypt=mutual; keydata=
 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
 eD/Xv4SsK2JTO4nkQYw8
Organization: five technologies GmbH
Message-ID: <8fa0c3da-b64d-f47f-a9eb-b3456a3fd073@fivetechno.de>
Date:   Mon, 11 Nov 2019 15:21:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------32B8AA59744FD73ACAF813EF"
Content-Language: de-DE
X-bounce-key: webpack.hosteurope.de;m.reichl@fivetechno.de;1573482102;828b1368;
X-HE-SMSGID: 1iUAZY-0001Oc-6s
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------32B8AA59744FD73ACAF813EF
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Add regulators to pcie node from schematics.

Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
---
 .../boot/dts/rockchip/rk3399-roc-pc-mezzanine.dts      |  2 ++
 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi        | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dts b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dts
index d6b3042cffa9..2c9c13a0fca9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dts
@@ -50,6 +50,8 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie_perst>;
 	vpcie3v3-supply = <&vcc3v3_pcie>;
+	vpcie1v8-supply = <&vcc1v8_pmu>;
+	vpcie0v9-supply = <&vcca_0v9>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
index 287f97488f65..2ef8ee2eae02 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
@@ -145,6 +145,16 @@
 		vin-supply = <&dc_12v>;
 	};
 
+	vcca_0v9: vcca-0v9 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcca_0v9";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <900000>;
+		regulator-max-microvolt = <900000>;
+		vin-supply = <&vcc3v3_sys>;
+	};
+
 	/* Actually 3 regulators (host0, 1, 2) controlled by the same gpio */
 	vcc5v0_host: vcc5v0-host-regulator {
 		compatible = "regulator-fixed";
-- 
2.20.1


--------------32B8AA59744FD73ACAF813EF
Content-Type: text/plain; charset=UTF-8;
 name="Nachrichtenteil als Anhang"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="Nachrichtenteil als Anhang"

VGhpcyBpcyBhbiBPcGVuUEdQL01JTUUgc2lnbmVkIG1lc3NhZ2UgKFJGQyA0ODgwIGFuZCAz
MTU2KQotLW1hNk5za2Q0dHB2UDV2c1JWVW5VV3NnaUlTMkR3YkJuVwpDb250ZW50LVR5cGU6
IG11bHRpcGFydC9taXhlZDsgYm91bmRhcnk9InlKWndjcDFZbXN1a2xoN2FHUzlXTUhVTkox
bm5MNWk1aiI7CiBwcm90ZWN0ZWQtaGVhZGVycz0idjEiCkZyb206IE1hcmt1cyBSZWljaGwg
PG0ucmVpY2hsQGZpdmV0ZWNobm8uZGU+ClRvOiBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJu
ZWwub3JnPiwgTWFyayBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT4sCiBIZWlrbyBT
dHVlYm5lciA8aGVpa29Ac250ZWNoLmRlPiwgSmFnYW4gVGVraSA8amFnYW5AYW1hcnVsYXNv
bHV0aW9ucy5jb20+LAogTWFya3VzIFJlaWNobCA8bS5yZWljaGxAZml2ZXRlY2huby5kZT4s
IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnLAogbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnLCBsaW51eC1yb2NrY2hpcEBsaXN0cy5pbmZyYWRlYWQub3JnLAogbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZwpNZXNzYWdlLUlEOiA8N2Q4ZDg1YzktNWZkZS03
OTQzLWE2YjYtNjM5YmNhMzhiZGMxQGZpdmV0ZWNobm8uZGU+ClN1YmplY3Q6IFtQQVRDSF0g
YXJtNjQ6IGR0czogcm9ja2NoaXA6IEFkZCBMRUQgbm9kZXMgb24gcmszMzk5LXJvYy1wYwoK
LS15Slp3Y3AxWW1zdWtsaDdhR1M5V01IVU5KMW5uTDVpNWoKQ29udGVudC1UeXBlOiB0ZXh0
L3BsYWluOyBjaGFyc2V0PXV0Zi04CkNvbnRlbnQtTGFuZ3VhZ2U6IGRlLURFCkNvbnRlbnQt
VHJhbnNmZXItRW5jb2Rpbmc6IHF1b3RlZC1wcmludGFibGUKCnJrMzM5OS1yb2MtcGMgaGFz
IHRocmVlIGdwaW8gTEVEcywgZW5hYmxlIHRoZW0uCgpTaWduZWQtb2ZmLWJ5OiBNYXJrdXMg
UmVpY2hsIDxtLnJlaWNobEBmaXZldGVjaG5vLmRlPgotLS0KIC4uLi9hcm02NC9ib290L2R0
cy9yb2NrY2hpcC9yazMzOTktcm9jLXBjLmR0cyB8IDQxICsrKysrKysrKysrKysrKysrKysK
IDEgZmlsZSBjaGFuZ2VkLCA0MSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvYXJjaC9h
cm02NC9ib290L2R0cy9yb2NrY2hpcC9yazMzOTktcm9jLXBjLmR0cyBiL2FyY2gvYXJtNjQv
PQpib290L2R0cy9yb2NrY2hpcC9yazMzOTktcm9jLXBjLmR0cwppbmRleCBmYWY2MGIyYTc2
NzMuLmJhNTJlMTA1M2EyZCAxMDA2NDQKLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9yb2Nr
Y2hpcC9yazMzOTktcm9jLXBjLmR0cworKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL3JvY2tj
aGlwL3JrMzM5OS1yb2MtcGMuZHRzCkBAIC0yOCw2ICsyOCwzMyBAQAogCQkjY2xvY2stY2Vs
bHMgPTNEIDwwPjsKIAl9Owo9MjAKKwlsZWRzIHsKKwkJY29tcGF0aWJsZSA9M0QgImdwaW8t
bGVkcyI7CisJCXBpbmN0cmwtbmFtZXMgPTNEICJkZWZhdWx0IjsKKwkJcGluY3RybC0wID0z
RCA8JndvcmtfbGVkX2dwaW8+LCA8JmRpeV9sZWRfZ3Bpbz4sIDwmeWVsbG93X2xlZF9ncGlv
PjsKKworCQl3b3JrLWxlZCB7CisJCQlsYWJlbCA9M0QgImdyZWVuOndvcmsiOworCQkJZ3Bp
b3MgPTNEIDwmZ3BpbzIgUktfUEQzIEdQSU9fQUNUSVZFX0hJR0g+OworCQkJZGVmYXVsdC1z
dGF0ZSA9M0QgIm9uIjsKKwkJCWxpbnV4LGRlZmF1bHQtdHJpZ2dlciA9M0QgImhlYXJ0YmVh
dCI7CisJCX07CisKKwkJZGl5LWxlZCB7CisJCQlsYWJlbCA9M0QgInJlZDpkaXkiOworCQkJ
Z3Bpb3MgPTNEIDwmZ3BpbzAgUktfUEI1IEdQSU9fQUNUSVZFX0hJR0g+OworCQkJZGVmYXVs
dC1zdGF0ZSA9M0QgIm9mZiI7CisJCQlsaW51eCxkZWZhdWx0LXRyaWdnZXIgPTNEICJtbWMx
IjsKKwkJfTsKKworCQl5ZWxsb3ctbGVkIHsKKwkJCWxhYmVsID0zRCAieWVsbG93OnllbGxv
dy1sZWQiOworCQkJZ3Bpb3MgPTNEIDwmZ3BpbzAgUktfUEEyIEdQSU9fQUNUSVZFX0hJR0g+
OworCQkJZGVmYXVsdC1zdGF0ZSA9M0QgIm9mZiI7CisJCQlsaW51eCxkZWZhdWx0LXRyaWdn
ZXIgPTNEICJtbWMwIjsKKwkJfTsKKwl9OworCiAJc2Rpb19wd3JzZXE6IHNkaW8tcHdyc2Vx
IHsKIAkJY29tcGF0aWJsZSA9M0QgIm1tYy1wd3JzZXEtc2ltcGxlIjsKIAkJY2xvY2tzID0z
RCA8JnJrODA4IDE+OwpAQCAtNDk0LDYgKzUyMSwyMCBAQAogCQl9OwogCX07Cj0yMAorCWxl
ZHMgeworCQl3b3JrX2xlZF9ncGlvOiB3b3JrX2xlZC1ncGlvIHsKKwkJCXJvY2tjaGlwLHBp
bnMgPTNEIDwyIFJLX1BEMyBSS19GVU5DX0dQSU8gJnBjZmdfcHVsbF9ub25lPjsKKwkJfTsK
KworCQlkaXlfbGVkX2dwaW86IGRpeV9sZWQtZ3BpbyB7CisJCQlyb2NrY2hpcCxwaW5zID0z
RCA8MCBSS19QQjUgUktfRlVOQ19HUElPICZwY2ZnX3B1bGxfbm9uZT47CisJCX07CisKKwkJ
eWVsbG93X2xlZF9ncGlvOiB5ZWxsb3dfbGVkLWdwaW8geworCQkJcm9ja2NoaXAscGlucyA9
M0QgPDAgUktfUEEyIFJLX0ZVTkNfR1BJTyAmcGNmZ19wdWxsX25vbmU+OworCQl9OworCX07
CisKIAlwbWljIHsKIAkJdnNlbDFfZ3BpbzogdnNlbDEtZ3BpbyB7CiAJCQlyb2NrY2hpcCxw
aW5zID0zRCA8MSBSS19QQzIgUktfRlVOQ19HUElPICZwY2ZnX3B1bGxfZG93bj47Ci0tPTIw
CjIuMjAuMQoKCgoKCi0teUpad2NwMVltc3VrbGg3YUdTOVdNSFVOSjFubkw1aTVqLS0KCi0t
bWE2TnNrZDR0cHZQNXZzUlZVblVXc2dpSVMyRHdiQm5XCkNvbnRlbnQtVHlwZTogYXBwbGlj
YXRpb24vcGdwLXNpZ25hdHVyZTsgbmFtZT0ic2lnbmF0dXJlLmFzYyIKQ29udGVudC1EZXNj
cmlwdGlvbjogT3BlblBHUCBkaWdpdGFsIHNpZ25hdHVyZQpDb250ZW50LURpc3Bvc2l0aW9u
OiBhdHRhY2htZW50OyBmaWxlbmFtZT0ic2lnbmF0dXJlLmFzYyIKCi0tLS0tQkVHSU4gUEdQ
IFNJR05BVFVSRS0tLS0tCgppUUd6QkFFQkNBQWRGaUVFVktlSWVCaDBaV0pPbGR6TE9pWGVE
bXNhL2JJRkFsMnRoMlFBQ2drUU9pWGVEbXNhCi9iS1hCd3Y3QmhSemkwM0k5aitNZTFacDl5
RzI3bFhBUTZGT1BwSG10NUdKZG1GWmtwdXVyUlFRNmxCT0ptZmQKNjFLT3I2Z05ZTExWT2JN
ZVJjWjMwZ29uWEU1VEswbExQNm1PYWp0STRZQkIwKy80ZHkzS3dmNXF6bXRBSWFNMwo0N05a
OVdpVGx4UjdPaDFFU1ZGTHhHazdleG5NcTFSMHpGMlRMYWZEWnhQMXZaWGNvdzdhQ3BnY3g4
SE1naXZmCkROK3VBUTgrbU1DZDNpN2hleUJycURVeDRvQlFhbWRQRjIwU3BSU2ZYNm9OTW1O
Yk85Vm5vMmx5OEpmWEJ2OU8KMStUaE9YRit3Vm5PNVYzUTJPUWRIc3laR3QzdlpEdWduYnE5
UlFYamRwSmtKZkEzcm11R2dDZ25PY2FkMCsxMQpnMGt4eVUrMGlsMDdTdVVWZlhWWlhHcmFX
WVo0V3lPcEtrT09ENVloV1A4Y1lTSzR0T0ZRbENwZU5vL1V5a0hjCkY2YlhBd2NjOHg1bmFM
Mko2TDRONGhGbUdJNEkwd29xWnNUS05YNGdIUGkzMFhIZjkxbUo1bjJUYXRQQ3F1WjAKTGk2
ZmFuZ0k1dml4M1VFTWJpRkYwOWc5cktZZzJrOHYvVWlUallna2o1cU1ka2xNM3FnTVRUb1lZ
cTFybTJheQp5V2ZWQTFPRwo9S1RPaQotLS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0KCi0t
bWE2TnNrZDR0cHZQNXZzUlZVblVXc2dpSVMyRHdiQm5XLS0KCgo=
--------------32B8AA59744FD73ACAF813EF
Content-Type: text/plain; charset=UTF-8;
 name="Nachrichtenteil als Anhang"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="Nachrichtenteil als Anhang"

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgt
cm9ja2NoaXAgbWFpbGluZyBsaXN0CkxpbnV4LXJvY2tjaGlwQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1y
b2NrY2hpcAoK
--------------32B8AA59744FD73ACAF813EF--
