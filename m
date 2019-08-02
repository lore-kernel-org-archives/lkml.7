Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F88C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5A92073D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="HWeHHE6s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404491AbfHBIuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 04:50:04 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:23702 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731704AbfHBIuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 04:50:04 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x728kgEI025069;
        Fri, 2 Aug 2019 10:49:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=7oP2TLk/bh7ktiksulnUxikTpCmAWCoZAQWzbFRiYiI=;
 b=HWeHHE6szTeWTy7KRD9hXztk/dcwcjroscp14WCDjeynCAKs1YtJuV93C8R24aMH6X2/
 EfLpdAaLcPk2hJ0XTBKZcahfqNhMntQYofovPgkbscSe3UCn1GB3iwaLJ9KPcGRoW2i9
 Eap4KVSTpobAcweeLSqLNRvZJp2G2j+MfMMrmV4xRL8z1MqL8S9gGAJoIyyqxnwc4xUP
 DsYHilkOT1wVfxEa7FmRJcskW3oKcIDTSA4OVeYkAQa4nmQ89m8apJ24fTVdBruvY+24
 pEF03c1VjSlplo+hTVBIO3CvFq1v4DJtzNwKppgJgkIWFQ6ppdM3JpNKn5KN9WXwIikC Tg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2u0c2yu8yk-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 02 Aug 2019 10:49:49 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2823E41;
        Fri,  2 Aug 2019 08:49:48 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E7AEB20754E;
        Fri,  2 Aug 2019 10:49:48 +0200 (CEST)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 2 Aug
 2019 10:49:48 +0200
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Fri, 2 Aug 2019 10:49:48 +0200
From:   Olivier MOYSAN <olivier.moysan@st.com>
To:     Alexandre TORGUE <alexandre.torgue@st.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: stm32: add DFSDM pins to stm32mp157c
Thread-Topic: [PATCH] ARM: dts: stm32: add DFSDM pins to stm32mp157c
Thread-Index: AQHVSQmlOW7lqPM0IEWEE+OpQQXuJKbnat+A
Date:   Fri, 2 Aug 2019 08:49:48 +0000
Message-ID: <0e9689a6-0636-b1f2-22f7-009180709891@st.com>
References: <1564645567-13156-1-git-send-email-olivier.moysan@st.com>
 <a95e5d74-c8e3-42f9-cabf-f42623aee255@st.com>
In-Reply-To: <a95e5d74-c8e3-42f9-cabf-f42623aee255@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9043CAB016B58A46BA78A79224654C44@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-02_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQUxleCwNCg0KT24gOC8yLzE5IDEwOjA5IEFNLCBBbGV4YW5kcmUgVG9yZ3VlIHdyb3RlOg0K
PiBIaSBPbGl2aWVyDQo+IA0KPiBPbiA4LzEvMTkgOTo0NiBBTSwgT2xpdmllciBNb3lzYW4gd3Jv
dGU6DQo+PiBBZGQgREZTRE0gcGlucyB0byBzdG0zMm1wMTU3Yy4NCj4+DQo+PiBTaWduZWQtb2Zm
LWJ5OiBPbGl2aWVyIE1veXNhbiA8b2xpdmllci5tb3lzYW5Ac3QuY29tPg0KPj4gLS0tDQo+PiAg
ICBhcmNoL2FybS9ib290L2R0cy9zdG0zMm1wMTU3LXBpbmN0cmwuZHRzaSB8IDM5ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysNCj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAzOSBpbnNlcnRp
b25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL3N0bTMybXAxNTct
cGluY3RybC5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvc3RtMzJtcDE1Ny1waW5jdHJsLmR0c2kN
Cj4+IGluZGV4IDllYWVjOWJmOGNiOC4uZjk2YTkyOGNiYzQ5IDEwMDY0NA0KPj4gLS0tIGEvYXJj
aC9hcm0vYm9vdC9kdHMvc3RtMzJtcDE1Ny1waW5jdHJsLmR0c2kNCj4+ICsrKyBiL2FyY2gvYXJt
L2Jvb3QvZHRzL3N0bTMybXAxNTctcGluY3RybC5kdHNpDQo+PiBAQCAtMjMwLDYgKzIzMCw0NSBA
QA0KPj4gICAgCQkJCX07DQo+PiAgICAJCQl9Ow0KPj4gICAgDQo+IA0KPiBJIHVzZSB0byBvbmx5
IHRha2UgcGluY29uZmlnIHdoaWNoIGFyZSB1c2VkIGluIGJvYXJkLiBTbyBwbGVhc2UgcmVzZW5k
DQo+IHdpdGggdGhlICJib2FyZCBwYXRjaCIuDQo+IA0KDQpUaGUgREZTRE0gaXMgb25lIG9mIHRo
ZSBpbnRlcmZhY2UgdXNlZCBpbiB0aGUgU1RNMzJNUDE1IHNvdW5kY2FyZC4NClRoaXMgc291bmRj
YXJkIGFsc28gdXNlcyB0aGUgV29sZnNvbiB3bTg5OTQgYXVkaW8gY29kZWMuDQpUaGUgd204OTk0
IGNvZGVjIGRyaXZlciByZXF1aXJlcyBhZGFwdGF0aW9ucywgYW5kIHRoZSB1cHN0cmVhbSBvZg0K
dGhlc2UgY2hhbmdlcyBpcyBub3QgcGxhbm5lZCB0b2RheS4NClNvLCB0aGUgcmVsYXRlZCBib2Fy
ZCBwYXRjaGVzIGNhbm5vdCBiZSBzZW50Lg0KDQpCUnMNCk9saXZpZXINCg0KPiByZWdhcmRzDQo+
IEFsZXgNCj4gDQo+IA0KPj4gKwkJCWRmc2RtX2Nsa291dF9waW5zX2E6IGRmc2RtLWNsa291dC1w
aW5zLTAgew0KPj4gKwkJCQlwaW5zIHsNCj4+ICsJCQkJCXBpbm11eCA9IDxTVE0zMl9QSU5NVVgo
J0InLCAxMywgQUYzKT47IC8qIERGU0RNX0NLT1VUICovDQo+PiArCQkJCQliaWFzLWRpc2FibGU7
DQo+PiArCQkJCQlkcml2ZS1wdXNoLXB1bGw7DQo+PiArCQkJCQlzbGV3LXJhdGUgPSA8MD47DQo+
PiArCQkJCX07DQo+PiArCQkJfTsNCj4+ICsNCj4+ICsJCQlkZnNkbV9jbGtvdXRfc2xlZXBfcGlu
c19hOiBkZnNkbS1jbGtvdXQtc2xlZXAtcGlucy0wIHsNCj4+ICsJCQkJcGlucyB7DQo+PiArCQkJ
CQlwaW5tdXggPSA8U1RNMzJfUElOTVVYKCdCJywgMTMsIEFOQUxPRyk+OyAvKiBERlNETV9DS09V
VCAqLw0KPj4gKwkJCQl9Ow0KPj4gKwkJCX07DQo+PiArDQo+PiArCQkJZGZzZG1fZGF0YTFfcGlu
c19hOiBkZnNkbS1kYXRhMS1waW5zLTAgew0KPj4gKwkJCQlwaW5zIHsNCj4+ICsJCQkJCXBpbm11
eCA9IDxTVE0zMl9QSU5NVVgoJ0MnLCAzLCBBRjMpPjsgLyogREZTRE1fREFUQTEgKi8NCj4+ICsJ
CQkJfTsNCj4+ICsJCQl9Ow0KPj4gKw0KPj4gKwkJCWRmc2RtX2RhdGExX3NsZWVwX3BpbnNfYTog
ZGZzZG0tZGF0YTEtc2xlZXAtcGlucy0wIHsNCj4+ICsJCQkJcGlucyB7DQo+PiArCQkJCQlwaW5t
dXggPSA8U1RNMzJfUElOTVVYKCdDJywgMywgQU5BTE9HKT47IC8qIERGU0RNX0RBVEExICovDQo+
PiArCQkJCX07DQo+PiArCQkJfTsNCj4+ICsNCj4+ICsJCQlkZnNkbV9kYXRhM19waW5zX2E6IGRm
c2RtLWRhdGEzLXBpbnMtMCB7DQo+PiArCQkJCXBpbnMgew0KPj4gKwkJCQkJcGlubXV4ID0gPFNU
TTMyX1BJTk1VWCgnRicsIDEzLCBBRjYpPjsgLyogREZTRE1fREFUQTMgKi8NCj4+ICsJCQkJfTsN
Cj4+ICsJCQl9Ow0KPj4gKw0KPj4gKwkJCWRmc2RtX2RhdGEzX3NsZWVwX3BpbnNfYTogZGZzZG0t
ZGF0YTMtc2xlZXAtcGlucy0wIHsNCj4+ICsJCQkJcGlucyB7DQo+PiArCQkJCQlwaW5tdXggPSA8
U1RNMzJfUElOTVVYKCdGJywgMTMsIEFOQUxPRyk+OyAvKiBERlNETV9EQVRBMyAqLw0KPj4gKwkJ
CQl9Ow0KPj4gKwkJCX07DQo+PiArDQo+PiAgICAJCQlldGhlcm5ldDBfcmdtaWlfcGluc19hOiBy
Z21paS0wIHsNCj4+ICAgIAkJCQlwaW5zMSB7DQo+PiAgICAJCQkJCXBpbm11eCA9IDxTVE0zMl9Q
SU5NVVgoJ0cnLCA1LCBBRjExKT4sIC8qIEVUSF9SR01JSV9DTEsxMjUgKi8NCj4+
