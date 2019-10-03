Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D457C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69C02086A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="fnDbHZBC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbfJCKGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 06:06:05 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:13488 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725892AbfJCKGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 06:06:04 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x93A1X0C005362;
        Thu, 3 Oct 2019 12:05:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=/wp1iPbxskdZoxALyqazsiyERNct5sj1Muer0F1tD74=;
 b=fnDbHZBC7gucaOq1OwiWvpk9mi5otnSna/X8G/DRKg97jhqQR+ap1O2bayscHekH9JBM
 z0qOfV6rZfg7gci5/bRttu8mkYRScTYbXp09AJid7ej1V8bXYpIaxxBaH5dwE5GtW59h
 Rhqztw09BN6gGMpoJirZh0XhjZpM9oN+Al2N46HtdrO5zA21+68yPBIQBww2wgmOiKMt
 o1f+9hgtzWQOai55THnJxEHM6yt9N/xEPLYxZXyeTaYDcNVN+ECzv3xp2ztZRwgODHQh
 MlcquGFHPBEpEUkdcqDZ+TqY/thYM37QSxZAiX2PMfbzYEmvupvHrNlsFBv2svFyRT/5 +g== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vcem38t31-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 03 Oct 2019 12:05:51 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 931DA4D;
        Thu,  3 Oct 2019 10:05:47 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4AF6C2B5CAA;
        Thu,  3 Oct 2019 12:05:47 +0200 (CEST)
Received: from SFHDAG5NODE1.st.com (10.75.127.13) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Oct
 2019 12:05:46 +0200
Received: from SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6]) by
 SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6%20]) with mapi id
 15.00.1473.003; Thu, 3 Oct 2019 12:05:47 +0200
From:   Gerald BAEZA <gerald.baeza@st.com>
To:     Alexandre TORGUE <alexandre.torgue@st.com>,
        Jonathan Corbet <corbet@lwn.net>
CC:     "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Documentation: add link to stm32mp157 docs
Thread-Topic: [PATCH] Documentation: add link to stm32mp157 docs
Thread-Index: AQHVXNGu+WgWi0gJwE+sfJwWkTflzacPHSFxgDnL12A=
Date:   Thu, 3 Oct 2019 10:05:46 +0000
Message-ID: <8d097a0486e94257952600bf6d20975d@SFHDAG5NODE1.st.com>
References: <1566908347-92201-1-git-send-email-gerald.baeza@st.com>
 <20190827074825.64a28e88@lwn.net>
 <5257eff7-418b-8e94-1ced-30718dd3f5dc@st.com>
In-Reply-To: <5257eff7-418b-8e94-1ced-30718dd3f5dc@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-03_04:2019-10-01,2019-10-03 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9uYXRoYW4NCg0KPiBGcm9tOiBBbGV4YW5kcmUgVE9SR1VFIDxhbGV4YW5kcmUudG9yZ3Vl
QHN0LmNvbT4NCj4gSGkgSm9uYXRoYW4sDQo+IA0KPiBPbiA4LzI3LzE5IDM6NDggUE0sIEpvbmF0
aGFuIENvcmJldCB3cm90ZToNCj4gPiBPbiBUdWUsIDI3IEF1ZyAyMDE5IDEyOjE5OjMyICswMDAw
DQo+ID4gR2VyYWxkIEJBRVpBIDxnZXJhbGQuYmFlemFAc3QuY29tPiB3cm90ZToNCj4gPg0KPiA+
PiBMaW5rIHRvIHRoZSBvbmxpbmUgc3RtMzJtcDE1NyBkb2N1bWVudGF0aW9uIGFkZGVkIGluIHRo
ZSBvdmVydmlldy4NCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogR2VyYWxkIEJhZXphIDxnZXJh
bGQuYmFlemFAc3QuY29tPg0KPiA+PiAtLS0NCj4gPj4gICBEb2N1bWVudGF0aW9uL2FybS9zdG0z
Mi9zdG0zMm1wMTU3LW92ZXJ2aWV3LnJzdCB8IDYgKysrKysrDQo+ID4+ICAgMSBmaWxlIGNoYW5n
ZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlv
bi9hcm0vc3RtMzIvc3RtMzJtcDE1Ny1vdmVydmlldy5yc3QNCj4gPj4gYi9Eb2N1bWVudGF0aW9u
L2FybS9zdG0zMi9zdG0zMm1wMTU3LW92ZXJ2aWV3LnJzdA0KPiA+PiBpbmRleCBmNjJmZGM4Li44
ZDVhNDc2IDEwMDY0NA0KPiA+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2FybS9zdG0zMi9zdG0zMm1w
MTU3LW92ZXJ2aWV3LnJzdA0KPiA+PiArKysgYi9Eb2N1bWVudGF0aW9uL2FybS9zdG0zMi9zdG0z
Mm1wMTU3LW92ZXJ2aWV3LnJzdA0KPiA+PiBAQCAtMTQsNiArMTQsMTIgQEAgSXQgZmVhdHVyZXM6
DQo+ID4+ICAgLSBTdGFuZGFyZCBjb25uZWN0aXZpdHksIHdpZGVseSBpbmhlcml0ZWQgZnJvbSB0
aGUgU1RNMzIgTUNVIGZhbWlseQ0KPiA+PiAgIC0gQ29tcHJlaGVuc2l2ZSBzZWN1cml0eSBzdXBw
b3J0DQo+ID4+DQo+ID4+ICtSZXNvdXJjZXMNCj4gPj4gKy0tLS0tLS0tLQ0KPiA+PiArDQo+ID4+
ICtEYXRhc2hlZXQgYW5kIHJlZmVyZW5jZSBtYW51YWwgYXJlIHB1YmxpY2x5IGF2YWlsYWJsZSBv
biBTVCB3ZWJzaXRlOg0KPiA+PiArLi4gX1NUTTMyTVAxNTc6DQo+ID4+ICtodHRwczovL3d3dy5z
dC5jb20vZW4vbWljcm9jb250cm9sbGVycy0NCj4gbWljcm9wcm9jZXNzb3JzL3N0bTMybXAxNTcu
aHQNCj4gPj4gK21sDQo+ID4+ICsNCj4gPg0KPiA+IEFkZGluZyB0aGUgVVJMIGlzIGEgZmluZSBp
ZGVhLiAgQnV0IHlvdSBkb24ndCBuZWVkIHRoZSBleHRyYSBzeW50YXggdG8NCj4gPiBjcmVhdGUg
YSBsaW5rIGlmIHlvdSdyZSBub3QgZ29pbmcgdG8gYWN0dWFsbHkgbWFrZSBhIGxpbmsgb3V0IG9m
IGl0Lg0KPiA+IFNvIEknZCB0YWtlIHRoZSAiLi4gX1NUTTMyTVAxNTc6IiBwYXJ0IG91dCBhbmQg
bGlmZSB3aWxsIGJlIGdvb2QuDQo+ID4NCj4gDQo+IFdlIGFsc28gZGlkIGl0IGZvciBvbGRlciBz
dG0zMiBwcm9kdWN0LiBJZGVhIHdhcyB0byBub3QgaGF2ZSB0aGUgImZ1bGwiDQo+IGFkZHJlc3Mg
YnV0IGp1c3QgYSBzaG9ydGN1dCBvZiB0aGUgbGluayB3aGVuIGh0bWwgZmlsZSBpcyByZWFkLiBJ
dCBtYXliZSBtYWtlcw0KPiBubyBzZW5zID8gKGlmIHllcyB3ZSB3aWxsIGhhdmUgdG8gdXBkYXRl
IG9sZGVyIHN0bTMyIG92ZXJ2aWV3IDopKQ0KDQpFeGFtcGxlIGluIGh0dHBzOi8vd3d3Lmtlcm5l
bC5vcmcvZG9jL2h0bWwvbGF0ZXN0L2FybS9zdG0zMi9zdG0zMmg3NDMtb3ZlcnZpZXcuaHRtbA0K
DQpEbyB5b3UgYWdyZWUgdG8gY29udGludWUgbGlrZSB0aGlzID8NCg0KQmVzdCByZWdhcmRzLA0K
DQpHw6lyYWxkDQoNCj4gdGhhbmtzDQo+IEFsZXgNCj4gDQo+IA0KPiA+IFRoYW5rcywNCj4gPg0K
PiA+IGpvbg0KPiA+DQo=
