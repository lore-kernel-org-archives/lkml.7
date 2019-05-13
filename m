Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625A3C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221E12146F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="yk3DRz8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfEMHLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 03:11:15 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:31572 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725980AbfEMHLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 03:11:15 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4D76Z3g018397;
        Mon, 13 May 2019 09:11:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=JYRjcj+5cTxazjxY/B951yi7qS02YpZMEXM7PHXUwy4=;
 b=yk3DRz8jkDR7UA6D2eC8U4dsHgdTPmqaRYz8IjGjLOcH1jX1pB0SyAHUIJjl24K1zRir
 gTa4zIQm5w45UNYq3hGZqti1aoq0LUd7NAp5h+FQa0ErQ4B+Pn5SKKL+Xl+xgga3bPPr
 Vkp+10au+5USjn4foWaHAYETXA9y60PxWa7PsXTEtBr9RcHf470PDc97ZZGGFrrh2BKr
 fYtD0u9n8XJe6grNK5CQmy3S8PBSEBxFDnnMl8erehwfHP20IHz6D7RE0RFe9Wp0bTsx
 ByQLHvmQTB5fqzIALQRrobxDIynF0FipT0AtxkuYLGoRbOnPt4UiwMyg/UM0A4ykoM5M dQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2sdm5tsars-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 13 May 2019 09:11:01 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 37CF734;
        Mon, 13 May 2019 07:11:00 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 153CB13AC;
        Mon, 13 May 2019 07:11:00 +0000 (GMT)
Received: from SFHDAG3NODE2.st.com (10.75.127.8) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 13 May
 2019 09:10:59 +0200
Received: from SFHDAG3NODE2.st.com ([fe80::b82f:1ce:8854:5b96]) by
 SFHDAG3NODE2.st.com ([fe80::b82f:1ce:8854:5b96%20]) with mapi id
 15.00.1347.000; Mon, 13 May 2019 09:10:59 +0200
From:   Amelie DELAUNAY <amelie.delaunay@st.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] mfd: stmfx: Fix macro definition spelling
Thread-Topic: [PATCH] mfd: stmfx: Fix macro definition spelling
Thread-Index: AQHVB5gud9k1UvxEHEasdnpmS8J2KqZohVCA
Date:   Mon, 13 May 2019 07:10:59 +0000
Message-ID: <954f759a-4e13-ef95-d461-03cdb385e0a3@st.com>
References: <20190511012301.2661-1-natechancellor@gmail.com>
In-Reply-To: <20190511012301.2661-1-natechancellor@gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0B9C8FAB4FD1041A984A48DD3EB2CCC@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-13_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8xMS8xOSAzOjIzIEFNLCBOYXRoYW4gQ2hhbmNlbGxvciB3cm90ZToNCj4gQ2xhbmcgd2Fy
bnM6DQo+IA0KPiBJbiBmaWxlIGluY2x1ZGVkIGZyb20gZHJpdmVycy9tZmQvc3RtZnguYzoxMzoN
Cj4gaW5jbHVkZS9saW51eC9tZmQvc3RtZnguaDo3Ojk6IHdhcm5pbmc6ICdNRkRfU1RNRlhfSCcg
aXMgdXNlZCBhcyBhDQo+IGhlYWRlciBndWFyZCBoZXJlLCBmb2xsb3dlZCBieSAjZGVmaW5lIG9m
IGEgZGlmZmVyZW50IG1hY3JvDQo+IFstV2hlYWRlci1ndWFyZF0NCj4gDQo+IEZpeGVzOiAwNjI1
MmFkZTkxNTYgKCJtZmQ6IEFkZCBTVCBNdWx0aS1GdW5jdGlvbiBlWHBhbmRlciAoU1RNRlgpIGNv
cmUgZHJpdmVyIikNCj4gTGluazogaHR0cHM6Ly9naXRodWIuY29tL0NsYW5nQnVpbHRMaW51eC9s
aW51eC9pc3N1ZXMvNDc1DQo+IFNpZ25lZC1vZmYtYnk6IE5hdGhhbiBDaGFuY2VsbG9yIDxuYXRl
Y2hhbmNlbGxvckBnbWFpbC5jb20+DQoNClJldmlld2VkLWJ5OiBBbWVsaWUgRGVsYXVuYXkgPGFt
ZWxpZS5kZWxhdW5heUBzdC5jb20+DQoNCj4gLS0tDQo+ICAgaW5jbHVkZS9saW51eC9tZmQvc3Rt
ZnguaCB8IDIgKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21mZC9zdG1meC5oIGIvaW5j
bHVkZS9saW51eC9tZmQvc3RtZnguaA0KPiBpbmRleCBkODkwNTk1Yjg5YjYuLjNjNjc5ODM2Nzhl
YyAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9tZmQvc3RtZnguaA0KPiArKysgYi9pbmNs
dWRlL2xpbnV4L21mZC9zdG1meC5oDQo+IEBAIC01LDcgKzUsNyBAQA0KPiAgICAqLw0KPiAgIA0K
PiAgICNpZm5kZWYgTUZEX1NUTUZYX0gNCj4gLSNkZWZpbmUgTUZYX1NUTUZYX0gNCj4gKyNkZWZp
bmUgTUZEX1NUTUZYX0gNCj4gICANCj4gICAjaW5jbHVkZSA8bGludXgvcmVnbWFwLmg+DQo+ICAg
DQo+IA==
