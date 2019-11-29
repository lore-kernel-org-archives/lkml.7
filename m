Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A1DC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 15:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB192075C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 15:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Cf6qElNM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfK2PjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 10:39:09 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:59895 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726608AbfK2PjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 10:39:09 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xATFWBEm024655;
        Fri, 29 Nov 2019 16:38:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=WpDppVTo4X+IA2H8dlko1cYJzeCUSxf2WGULwPYCFJE=;
 b=Cf6qElNMza2MD0gPmhRxjC+qkJ3tY3h19xBhuCbztvZiUNt5KjTw38GwtUOoAjtVhiXm
 KFWC3LbQFhnpHiqG4M8hkj9x8bMSUB/ImlDUQER8aVLP+7EZY7eu1xQOq7zf2YsxdhHG
 dZWBhhCDwFpj7FrNQQhjNC2d/0jBAcC1/Rca740kC5n8o50ng9h3c6cuGE/hYa94/xb/
 tTWFsYwwiv5YD2ssyBcvqYIj6eDx1xBI6R2XSRi1bYFPjidgmnkxLflun3Wq0f79BCG5
 yb59QqhTw1+9vwJxTGU5iOLClZCDy26Kyw39r0b6fzdl8r+wxiKj30ZQHHhswhUUjFVV wQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2whcxjg81u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Nov 2019 16:38:49 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BE48D100034;
        Fri, 29 Nov 2019 16:38:47 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node1.st.com [10.75.127.13])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B1A3C2C4FAE;
        Fri, 29 Nov 2019 16:38:47 +0100 (CET)
Received: from SFHDAG5NODE3.st.com (10.75.127.15) by SFHDAG5NODE1.st.com
 (10.75.127.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 29 Nov
 2019 16:38:47 +0100
Received: from SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47]) by
 SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47%20]) with mapi id
 15.00.1473.003; Fri, 29 Nov 2019 16:38:47 +0100
From:   Fabien DESSENNE <fabien.dessenne@st.com>
To:     Randy Dunlap <rdunlap@infradead.org>, Jessica Yu <jeyu@kernel.org>,
        "Alexey Gladkov" <gladkov.alexey@gmail.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] moduleparam: fix kerneldoc
Thread-Topic: [PATCH] moduleparam: fix kerneldoc
Thread-Index: AQHVpg0LuqxE/+Nvb0G1uKkDxQefmKeg0J+AgAForwA=
Date:   Fri, 29 Nov 2019 15:38:47 +0000
Message-ID: <f9b0d788-deb4-9114-f074-2e11d44be147@st.com>
References: <1574960280-28770-1-git-send-email-fabien.dessenne@st.com>
 <bc38fbde-fa80-43f2-abf2-6629c346d8e3@infradead.org>
In-Reply-To: <bc38fbde-fa80-43f2-abf2-6629c346d8e3@infradead.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FAAFCD84DCC2D4449971FED7D39F4DC4@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-29_04:2019-11-29,2019-11-29 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUmFuZHkNCg0KDQpPbiAyOC8xMS8yMDE5IDc6MDcgUE0sIFJhbmR5IER1bmxhcCB3cm90ZToN
Cj4gT24gMTEvMjgvMTkgODo1OCBBTSwgRmFiaWVuIERlc3Nlbm5lIHdyb3RlOg0KPj4gRG9jdW1l
bnQgbWlzc2luZyBAYXJncyBpbiB4eHhfcGFyYW1fY2IoKS4NCj4+IFR5cG86IHVzZSAndmFsdWUn
IGluc3RlYWQgb2YgJ2x2YWx1ZScuDQo+IEkgdGhpbmsgdGhhdCBpdCdzIG5vdCBhIHR5cG8uLi4N
Cj4NCj4gV2lraXBlZGlhIHNheXMgZm9yIGx2YWx1ZToNCj4gSW4gY29tcHV0ZXIgc2NpZW5jZSwg
YSB2YWx1ZSB0aGF0IHBvaW50cyB0byBhIHN0b3JhZ2UgbG9jYXRpb24sIHBvdGVudGlhbGx5IGFs
bG93aW5nIG5ldyB2YWx1ZXMgdG8gYmUgYXNzaWduZWQgKHNvIG5hbWVkIGJlY2F1c2UgaXQgYXBw
ZWFycyBvbiB0aGUgbGVmdCBzaWRlIG9mIGEgdmFyaWFibGUgYXNzaWdubWVudCkNCg0KDQpZb3Ug
YXJlIGFic29sdXRlbHkgcmlnaHQhIEkgYW0gYWJvdXQgdG8gc2VuZCBhIHYyLg0KDQpCUg0KDQpG
YWJpZW4NCg0KDQo+DQo+PiBTaWduZWQtb2ZmLWJ5OiBGYWJpZW4gRGVzc2VubmUgPGZhYmllbi5k
ZXNzZW5uZUBzdC5jb20+DQo+PiAtLS0NCj4+ICAgaW5jbHVkZS9saW51eC9tb2R1bGVwYXJhbS5o
IHwgNiArKysrLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tb2R1bGVwYXJhbS5o
IGIvaW5jbHVkZS9saW51eC9tb2R1bGVwYXJhbS5oDQo+PiBpbmRleCBlNWMzZTIzLi45NDRjNTY5
IDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9saW51eC9tb2R1bGVwYXJhbS5oDQo+PiArKysgYi9p
bmNsdWRlL2xpbnV4L21vZHVsZXBhcmFtLmgNCj4+IEBAIC0xMzUsNyArMTM1LDcgQEAgc3RydWN0
IGtwYXJhbV9hcnJheQ0KPj4gICAvKioNCj4+ICAgICogbW9kdWxlX3BhcmFtX25hbWVkIC0gdHlw
ZXNhZmUgaGVscGVyIGZvciBhIHJlbmFtZWQgbW9kdWxlL2NtZGxpbmUgcGFyYW1ldGVyDQo+PiAg
ICAqIEBuYW1lOiBhIHZhbGlkIEMgaWRlbnRpZmllciB3aGljaCBpcyB0aGUgcGFyYW1ldGVyIG5h
bWUuDQo+PiAtICogQHZhbHVlOiB0aGUgYWN0dWFsIGx2YWx1ZSB0byBhbHRlci4NCj4+ICsgKiBA
dmFsdWU6IHRoZSBhY3R1YWwgdmFsdWUgdG8gYWx0ZXIuDQo+PiAgICAqIEB0eXBlOiB0aGUgdHlw
ZSBvZiB0aGUgcGFyYW1ldGVyDQo+PiAgICAqIEBwZXJtOiB2aXNpYmlsaXR5IGluIHN5c2ZzLg0K
Pj4gICAgKg0KPj4gQEAgLTE2MCw2ICsxNjAsNyBAQCBzdHJ1Y3Qga3BhcmFtX2FycmF5DQo+PiAg
ICAqIG1vZHVsZV9wYXJhbV9jYiAtIGdlbmVyYWwgY2FsbGJhY2sgZm9yIGEgbW9kdWxlL2NtZGxp
bmUgcGFyYW1ldGVyDQo+PiAgICAqIEBuYW1lOiBhIHZhbGlkIEMgaWRlbnRpZmllciB3aGljaCBp
cyB0aGUgcGFyYW1ldGVyIG5hbWUuDQo+PiAgICAqIEBvcHM6IHRoZSBzZXQgJiBnZXQgb3BlcmF0
aW9ucyBmb3IgdGhpcyBwYXJhbWV0ZXIuDQo+PiArICogQGFyZ3M6IGFyZ3MgZm9yIEBvcHMNCj4+
ICAgICogQHBlcm06IHZpc2liaWxpdHkgaW4gc3lzZnMuDQo+PiAgICAqDQo+PiAgICAqIFRoZSBv
cHMgY2FuIGhhdmUgTlVMTCBzZXQgb3IgZ2V0IGZ1bmN0aW9ucy4NCj4+IEBAIC0xNzYsNiArMTc3
LDcgQEAgc3RydWN0IGtwYXJhbV9hcnJheQ0KPj4gICAgKiAgICAgICAgICAgICAgICAgICAgdG8g
YmUgZXZhbHVhdGVkIGJlZm9yZSBjZXJ0YWluIGluaXRjYWxsIGxldmVsDQo+PiAgICAqIEBuYW1l
OiBhIHZhbGlkIEMgaWRlbnRpZmllciB3aGljaCBpcyB0aGUgcGFyYW1ldGVyIG5hbWUuDQo+PiAg
ICAqIEBvcHM6IHRoZSBzZXQgJiBnZXQgb3BlcmF0aW9ucyBmb3IgdGhpcyBwYXJhbWV0ZXIuDQo+
PiArICogQGFyZ3M6IGFyZ3MgZm9yIEBvcHMNCj4+ICAgICogQHBlcm06IHZpc2liaWxpdHkgaW4g
c3lzZnMuDQo+PiAgICAqDQo+PiAgICAqIFRoZSBvcHMgY2FuIGhhdmUgTlVMTCBzZXQgb3IgZ2V0
IGZ1bmN0aW9ucy4NCj4+IEBAIC00NTcsNyArNDU5LDcgQEAgZW51bSBod3BhcmFtX3R5cGUgew0K
Pj4gICAvKioNCj4+ICAgICogbW9kdWxlX3BhcmFtX2h3X25hbWVkIC0gQSBwYXJhbWV0ZXIgcmVw
cmVzZW50aW5nIGEgaHcgcGFyYW1ldGVycw0KPj4gICAgKiBAbmFtZTogYSB2YWxpZCBDIGlkZW50
aWZpZXIgd2hpY2ggaXMgdGhlIHBhcmFtZXRlciBuYW1lLg0KPj4gLSAqIEB2YWx1ZTogdGhlIGFj
dHVhbCBsdmFsdWUgdG8gYWx0ZXIuDQo+PiArICogQHZhbHVlOiB0aGUgYWN0dWFsIHZhbHVlIHRv
IGFsdGVyLg0KPj4gICAgKiBAdHlwZTogdGhlIHR5cGUgb2YgdGhlIHBhcmFtZXRlcg0KPj4gICAg
KiBAaHd0eXBlOiB3aGF0IHRoZSB2YWx1ZSByZXByZXNlbnRzIChlbnVtIGh3cGFyYW1fdHlwZSkN
Cj4+ICAgICogQHBlcm06IHZpc2liaWxpdHkgaW4gc3lzZnMuDQo+Pg0KPg==
