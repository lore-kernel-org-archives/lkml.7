Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBBAC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 07:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B03A820830
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 07:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731353AbfCAHOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 02:14:45 -0500
Received: from mx.socionext.com ([202.248.49.38]:3461 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbfCAHOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 02:14:44 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 01 Mar 2019 16:14:43 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 124A21800E1;
        Fri,  1 Mar 2019 16:14:43 +0900 (JST)
Received: from 10.213.24.1 (10.213.24.1) by m-FILTER with ESMTP; Fri, 1 Mar 2019 16:14:43 +0900
Received: from SOC-EX01V.e01.socionext.com (10.213.24.21) by
 SOC-EX01V.e01.socionext.com (10.213.24.21) with Microsoft SMTP Server (TLS)
 id 15.0.995.29; Fri, 1 Mar 2019 16:14:42 +0900
Received: from SOC-EX01V.e01.socionext.com ([10.213.24.21]) by
 SOC-EX01V.e01.socionext.com ([10.213.24.21]) with mapi id 15.00.0995.028;
 Fri, 1 Mar 2019 16:14:42 +0900
From:   <yamada.masahiro@socionext.com>
To:     <kacper@kolodziej.it>, <michal.lkml@markovi.net>
CC:     <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] kbuild: [bin]deb-pkg: add DPKG_FLAGS variable
Thread-Topic: [PATCH] kbuild: [bin]deb-pkg: add DPKG_FLAGS variable
Thread-Index: AQHUvU+HoJmTT8El8Um4OmE/yzQLqKX2ghIA
Date:   Fri, 1 Mar 2019 07:14:41 +0000
Message-ID: <87d286c0f28945728dd67b0ddf17375e@SOC-EX01V.e01.socionext.com>
References: <20190205123752.25432-1-kacper@kolodziej.it>
In-Reply-To: <20190205123752.25432-1-kacper@kolodziej.it>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: POLICY190117
x-originating-ip: [10.213.24.1]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2FjcGVyIEtvxYJvZHpp
ZWogW21haWx0bzprYWNwZXJAa29sb2R6aWVqLml0XQ0KPiBTZW50OiBUdWVzZGF5LCBGZWJydWFy
eSAwNSwgMjAxOSA5OjM4IFBNDQo+IFRvOiBZYW1hZGEsIE1hc2FoaXJvL+WxseeUsCDnnJ/lvJgg
PHlhbWFkYS5tYXNhaGlyb0Bzb2Npb25leHQuY29tPjsNCj4gbWljaGFsLmxrbWxAbWFya292aS5u
ZXQNCj4gQ2M6IGxpbnV4LWtidWlsZEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7DQo+IGthY3BlckBrb2xvZHppZWouaXQNCj4gU3ViamVjdDogW1BBVENIXSBr
YnVpbGQ6IFtiaW5dZGViLXBrZzogYWRkIERQS0dfRkxBR1MgdmFyaWFibGUNCj4gDQo+IERQS0df
RkxBR1MgdmFyaWFibGUgbGV0cyB1c2VyIHRvIGFkZCBtb3JlIGZsYWdzIHRvIGRwa2ctYnVpbGRw
YWNrYWdlDQo+IGNvbW1hbmQgaW4gZGViLXBrZyBhbmQgYmluZGViLXBrZy4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IEthY3BlciBLb8WCb2R6aWVqIDxrYWNwZXJAa29sb2R6aWVqLml0Pg0KPiAtLS0N
Cg0KQXBwbGllZCB0byBsaW51eC1rYnVpbGQuDQpUaGFua3MuDQoNCg0KDQo+ICBzY3JpcHRzL3Bh
Y2thZ2UvTWFrZWZpbGUgfCA0ICsrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvc2NyaXB0cy9wYWNrYWdlL01h
a2VmaWxlIGIvc2NyaXB0cy9wYWNrYWdlL01ha2VmaWxlDQo+IGluZGV4IDQ1M2ZlY2VlNjJmMC4u
Njk2M2VhY2IzMjNjIDEwMDY0NA0KPiAtLS0gYS9zY3JpcHRzL3BhY2thZ2UvTWFrZWZpbGUNCj4g
KysrIGIvc2NyaXB0cy9wYWNrYWdlL01ha2VmaWxlDQo+IEBAIC03MiwxMSArNzIsMTEgQEAgZGVi
LXBrZzogRk9SQ0UNCj4gIAkkKGNhbGwgY21kLHNyY190YXIsJChLREVCX1NPVVJDRU5BTUUpKQ0K
PiAgCW9yaWd2ZXJzaW9uPSQkKGRwa2ctcGFyc2VjaGFuZ2Vsb2cgLVNWZXJzaW9uIHxzZWQNCj4g
J3MvLVteLV0qJCQvLycpO1wNCj4gIAkJbXYNCj4gJChLREVCX1NPVVJDRU5BTUUpLnRhci5neiAu
Li8kKEtERUJfU09VUkNFTkFNRSlfJCR7b3JpZ3ZlcnNpb259Lm9yaWcudA0KPiBhci5neg0KPiAt
CStkcGtnLWJ1aWxkcGFja2FnZSAtciQoS0JVSUxEX1BLR19ST09UQ01EKSAtYSQkKGNhdCBkZWJp
YW4vYXJjaCkNCj4gLWkuZ2l0IC11cyAtdWMNCj4gKwkrZHBrZy1idWlsZHBhY2thZ2UgLXIkKEtC
VUlMRF9QS0dfUk9PVENNRCkgLWEkJChjYXQgZGViaWFuL2FyY2gpDQo+ICQoRFBLR19GTEFHUykg
LWkuZ2l0IC11cyAtdWMNCj4gDQo+ICBiaW5kZWItcGtnOiBGT1JDRQ0KPiAgCSQoQ09ORklHX1NI
RUxMKSAkKHNyY3RyZWUpL3NjcmlwdHMvcGFja2FnZS9ta2RlYmlhbg0KPiAtCStkcGtnLWJ1aWxk
cGFja2FnZSAtciQoS0JVSUxEX1BLR19ST09UQ01EKSAtYSQkKGNhdCBkZWJpYW4vYXJjaCkNCj4g
LWIgLW5jIC11Yw0KPiArCStkcGtnLWJ1aWxkcGFja2FnZSAtciQoS0JVSUxEX1BLR19ST09UQ01E
KSAtYSQkKGNhdCBkZWJpYW4vYXJjaCkNCj4gJChEUEtHX0ZMQUdTKSAtYiAtbmMgLXVjDQo+IA0K
PiAgaW50ZGViLXBrZzogRk9SQ0UNCj4gIAkrJChDT05GSUdfU0hFTEwpICQoc3JjdHJlZSkvc2Ny
aXB0cy9wYWNrYWdlL2J1aWxkZGViDQo+IC0tDQo+IDIuMjAuMQ0KDQo=
