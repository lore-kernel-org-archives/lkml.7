Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0659FC33CA2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 10:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0FD220692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 10:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="jG8/vhWu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgAHKxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 05:53:55 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:58560 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726486AbgAHKxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 05:53:54 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 008AprGZ021882;
        Wed, 8 Jan 2020 11:53:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=kQyAI2kGrjAzX+brnj8/2WmK945o0OHDaqbW0tiyk38=;
 b=jG8/vhWu3vI0zQ2/6ljT7lMhTFQRzNNPYHZwHdGzs2Eo5g5lMGGov6ZwJLOfIyariESU
 hORNi1P+EC95M145rQh2UHaCPIW1iML0ztzP/eRKwOfKkQcPFMF3iAmm/sYqpbStnBX5
 JTpBv3ah3Ev23TSN0/BN4mu6MtU5Z2E4xiQyj5Hb7YDoJByEqsx2/bRhCxV6cVnt3kGq
 jU3R9MWJ5k0qEPhPhLFmHAl6xDJ/s8Lv+wuqSgNmjlN3nwh9BxptLWYUotCw2kvfunL/
 UWuuUjEJvEW2qyQ1UKuwKedwt2QO8K/FBEQYCgeVk3ozvCXiWpHXIXqPpJ4pM2QFGXGP DA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xakm5keud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jan 2020 11:53:32 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 32C4E100039;
        Wed,  8 Jan 2020 11:53:28 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1F5312AC7B9;
        Wed,  8 Jan 2020 11:53:28 +0100 (CET)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 8 Jan
 2020 11:53:27 +0100
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1473.003; Wed, 8 Jan 2020 11:53:27 +0100
From:   Patrice CHOTARD <patrice.chotard@st.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 0/2] ARM: dts: stih410-b2260: Fix ethernet PHY DT node
Thread-Topic: [PATCH 0/2] ARM: dts: stih410-b2260: Fix ethernet PHY DT node
Thread-Index: AQHVxVdeIJqDyaWz6EKL4LSB10p6hafgiEOA
Date:   Wed, 8 Jan 2020 10:53:27 +0000
Message-ID: <ac361e0a-e5c8-ba7c-0d31-1f47a6ba4fab@st.com>
References: <20200107123828.6586-1-patrice.chotard@st.com>
In-Reply-To: <20200107123828.6586-1-patrice.chotard@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FA654F671C57D4EA886F312BBD6A0E0@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-08_03:2020-01-08,2020-01-08 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkNCg0KVGhpcyBzZXJpZXMgaXMgYWJhbmRvbm5lZDoNCg0KwqDCoCAtIFBhdGNoIDEgaXMgbm8g
bW9yZSBuZWVkZWQgZHVlIHRvIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9s
aW51eC1hcm0ta2VybmVsL2xpc3QvP3Nlcmllcz0yMjQ2MzcNCg0KwqDCoCAtIFBhdGNoIDIgd2ls
bCBiZSByZXNlbmQgYWxvbmUNCg0KVGhhbmtzDQoNClBhdHJpY2UNCg0KDQpPbiAxLzcvMjAgMToz
OCBQTSwgcGF0cmljZS5jaG90YXJkQHN0LmNvbSB3cm90ZToNCj4gRnJvbTogUGF0cmljZSBDaG90
YXJkIDxwYXRyaWNlLmNob3RhcmRAc3QuY29tPg0KPg0KPiBUaGlzIHNlcmllcyBpcyBmaXhpbmcg
YSBrZXJuZWwgT29wcyBhbmQgaXMgcmVtb3ZpbmcgZGVwcmVjYXRlZCBQSFkgcHJvcGVydGllczog
DQo+DQo+ICAtIFNpbmNlIGNvbW1pdCAnZDNlMDE0ZWM3ZDVlICgibmV0OiBzdG1tYWM6IHBsYXRm
b3JtOiBGaXggTURJTyBpbml0IGZvciANCj4gICAgcGxhdGZvcm1zIHdpdGhvdXQgUEhZIiknLCBh
IGtlcm5lbCBPb3BzIG9jY3VycyBhbmQgZXRoZXJuZXQgaXMgbm8gbW9yZQ0KPiAgICBmdW5jdGlv
bmFsLg0KPg0KPiAgLSBTb21lIGRlcHJlY2F0ZWQgU3lub3BzeXMgcGh5IHByb3BlcnRpZXMgd2Fz
IGFsd2F5cyBwcmVzZW50IGluIERULCANCj4gICAgcmVtb3ZlIHRoZW0uDQo+DQo+IFBhdHJpY2Ug
Q2hvdGFyZCAoMik6DQo+ICAgQVJNOiBkdHM6IHN0aWg0MTAtYjIyNjA6IEZpeCBldGhlcm5ldCBw
aHkgRFQgbm9kZQ0KPiAgIEFSTTogZHRzOiBzdGloNDEwLWIyMjYwOiBSZW1vdmUgZGVwcmVjYXRl
ZCBzbnBzIFBIWSBwcm9wZXJ0aWVzDQo+DQo+ICBhcmNoL2FybS9ib290L2R0cy9zdGloNDEwLWIy
MjYwLmR0cyB8IDEzICsrKysrKysrKystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPg==
