Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5386C2D0D2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 03:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E51A20733
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 03:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfLWDm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 22:42:27 -0500
Received: from mx24.baidu.com ([111.206.215.185]:33166 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726539AbfLWDm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 22:42:26 -0500
X-Greylist: delayed 927 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Dec 2019 22:42:25 EST
Received: from BC-Mail-Ex19.internal.baidu.com (unknown [172.31.51.13])
        by Forcepoint Email with ESMTPS id 3E3F2743DD336EB3B57F;
        Mon, 23 Dec 2019 11:26:53 +0800 (CST)
Received: from BJHW-Mail-Ex02.internal.baidu.com (10.127.64.12) by
 BC-Mail-Ex19.internal.baidu.com (172.31.51.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Mon, 23 Dec 2019 11:26:53 +0800
Received: from BC-Mail-Ex03.internal.baidu.com (172.31.51.43) by
 BJHW-Mail-Ex02.internal.baidu.com (10.127.64.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Mon, 23 Dec 2019 11:26:52 +0800
Received: from BC-Mail-Ex03.internal.baidu.com ([100.100.100.102]) by
 BC-Mail-Ex03.internal.baidu.com ([100.100.100.102]) with mapi id
 15.01.1531.010; Mon, 23 Dec 2019 11:26:52 +0800
From:   "Jim,Yan" <jimyan@baidu.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIGlvbW11L3Z0LWQ6IERvbid0IHJlamVjdCBudm1l?=
 =?utf-8?Q?_host_due_to_scope_mismatch?=
Thread-Topic: [PATCH] iommu/vt-d: Don't reject nvme host due to scope mismatch
Thread-Index: AQHVtwQzqYN7wsrm/0GpGcDkRO8H3qfCOiCAgATKDsA=
Date:   Mon, 23 Dec 2019 03:26:52 +0000
Message-ID: <7a3ec348f7c24785931b8bd00c58fffb@baidu.com>
References: <1576825674-18022-1-git-send-email-jimyan@baidu.com>
 <20191220092327.do34gtk3lcafzr6q@cantor>
In-Reply-To: <20191220092327.do34gtk3lcafzr6q@cantor>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.200.92]
x-baidu-bdmsfe-datecheck: 1_BJHW-Mail-Ex02_2019-12-23 11:26:52:994
x-baidu-bdmsfe-viruscheck: BJHW-Mail-Ex02_GRAY_Inside_WithoutAtta_2019-12-23
 11:26:52:978
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Baidu-BdMsfe-DateCheck: 1_BC-Mail-Ex19_2019-12-23 11:26:53:196
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+5Y+R5Lu25Lq6OiBKZXJyeSBTbml0c2VsYWFyIFtt
YWlsdG86anNuaXRzZWxAcmVkaGF0LmNvbV0gDQo+5Y+R6YCB5pe26Ze0OiAyMDE55bm0MTLmnIgy
MOaXpSAxNzoyMw0KPuaUtuS7tuS6ujogSmltLFlhbiA8amlteWFuQGJhaWR1LmNvbT4NCj7mioTp
gIE6IGpvcm9AOGJ5dGVzLm9yZzsgaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj7kuLvpopg6IFJlOiBbUEFUQ0hdIGlvbW11L3Z0
LWQ6IERvbid0IHJlamVjdCBudm1lIGhvc3QgZHVlIHRvIHNjb3BlIG1pc21hdGNoDQo+DQo+IE9u
IEZyaSBEZWMgMjAgMTksIGppbXlhbiB3cm90ZToNCj4gPk9uIGEgc3lzdGVtIHdpdGggYW4gSW50
ZWwgUENJZSBwb3J0IGNvbmZpZ3VyZWQgYXMgYSBudm1lIGhvc3QgZGV2aWNlLCANCj4gPmlvbW11
IGluaXRpYWxpemF0aW9uIGZhaWxzIHdpdGgNCj4gPg0KPiA+ICAgIERNQVI6IERldmljZSBzY29w
ZSB0eXBlIGRvZXMgbm90IG1hdGNoIGZvciAwMDAwOjgwOjAwLjANCj4gPg0KPiA+VGhpcyBpcyBi
ZWNhdXNlIHRoZSBETUFSIHRhYmxlIHJlcG9ydHMgdGhpcyBkZXZpY2UgYXMgaGF2aW5nIHNjb3Bl
IDINCj4gPihBQ1BJX0RNQVJfU0NPUEVfVFlQRV9CUklER0UpOg0KPiA+DQo+DQo+IElzbid0IHRo
YXQgYSBwcm9ibGVtIHRvIGJlIGZpeGVkIGluIHRoZSBETUFSIHRhYmxlIHRoZW4/DQo+DQo+ID5i
dXQgdGhlIGRldmljZSBoYXMgYSB0eXBlIDAgUENJIGhlYWRlcjoNCj4gPjgwOjAwLjAgQ2xhc3Mg
MDYwMDogRGV2aWNlIDgwODY6MjAyMCAocmV2IDA2KQ0KPiA+MDA6IDg2IDgwIDIwIDIwIDQ3IDA1
IDEwIDAwIDA2IDAwIDAwIDA2IDEwIDAwIDAwIDAwDQo+ID4xMDogMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDANCj4gPjIwOiAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCA4NiA4MCAwMCAwMA0KPiA+MzA6IDAwIDAwIDAwIDAwIDkwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAxIDAwIDAwDQo+ID4NCj4gPlZULWQgd29ya3MgcGVyZmVjdGx5
IG9uIHRoaXMgc3lzdGVtLCBzbyB0aGVyZSdzIG5vIHJlYXNvbiB0byBiYWlsIG91dCANCj4gPm9u
IGluaXRpYWxpemF0aW9uIGR1ZSB0byB0aGlzIGFwcGFyZW50IHNjb3BlIG1pc21hdGNoLiBBZGQg
dGhlIGNsYXNzDQo+ID4weDYwMCAoIlBDSV9DTEFTU19CUklER0VfSE9TVCIpIGFzIGEgaGV1cmlz
dGljIGZvciBhbGxvd2luZyBETUFSIA0KPiA+aW5pdGlhbGl6YXRpb24gZm9yIG5vbi1icmlkZ2Ug
UENJIGRldmljZXMgbGlzdGVkIHdpdGggc2NvcGUgYnJpZGdlLg0KPiA+DQo+ID5TaWduZWQtb2Zm
LWJ5OiBqaW15YW4gPGppbXlhbkBiYWlkdS5jb20+DQo+ID4tLS0NCj4gPiBkcml2ZXJzL2lvbW11
L2RtYXIuYyB8IDEgKw0KPiA+IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+DQo+
ID5kaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9kbWFyLmMgYi9kcml2ZXJzL2lvbW11L2RtYXIu
YyBpbmRleCANCj4gPmVlY2Q2YTQyMTY2Ny4uOWZhZjJmMGUwMjM3IDEwMDY0NA0KPiA+LS0tIGEv
ZHJpdmVycy9pb21tdS9kbWFyLmMNCj4gPisrKyBiL2RyaXZlcnMvaW9tbXUvZG1hci5jDQo+ID5A
QCAtMjQ0LDYgKzI0NCw3IEBAIGludCBkbWFyX2luc2VydF9kZXZfc2NvcGUoc3RydWN0IGRtYXJf
cGNpX25vdGlmeV9pbmZvICppbmZvLA0KPiA+IAkJICAgICBpbmZvLT5kZXYtPmhkcl90eXBlICE9
IFBDSV9IRUFERVJfVFlQRV9OT1JNQUwpIHx8DQo+ID4gCQkgICAgKHNjb3BlLT5lbnRyeV90eXBl
ID09IEFDUElfRE1BUl9TQ09QRV9UWVBFX0JSSURHRSAmJg0KPiA+IAkJICAgICAoaW5mby0+ZGV2
LT5oZHJfdHlwZSA9PSBQQ0lfSEVBREVSX1RZUEVfTk9STUFMICYmDQo+ID4rCQkJICBpbmZvLT5k
ZXYtPmNsYXNzID4+IDggIT0gUENJX0NMQVNTX0JSSURHRV9IT1NUICYmDQo+ID4gCQkgICAgICBp
bmZvLT5kZXYtPmNsYXNzID4+IDggIT0gUENJX0NMQVNTX0JSSURHRV9PVEhFUikpKSB7DQo+ID4g
CQkJcHJfd2FybigiRGV2aWNlIHNjb3BlIHR5cGUgZG9lcyBub3QgbWF0Y2ggZm9yICVzXG4iLA0K
PiA+IAkJCQlwY2lfbmFtZShpbmZvLT5kZXYpKTsNCj4gPi0tDQo+ID4yLjExLjANCj4gPg0KPiA+
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gPmlvbW11
IG1haWxpbmcgbGlzdA0KPiA+aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcNCj4gPmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11DQo+
ID4NCkFjdHVhbGx5IHRoaXMgcGF0Y2ggaXMgc2ltaWxhciB0byB0aGUgY29tbWl0OiBmZmIyZDFl
Yjg4YzMoImlvbW11L3Z0LWQ6IERvbid0IHJlamVjdCBOVEIgZGV2aWNlcyBkdWUgdG8gc2NvcGUg
bWlzbWF0Y2giKS4gQmVzaWRlcywgbW9kaWZ5aW5nIERNQVIgdGFibGUgbmVlZCBPRU0gdXBkYXRl
IEJJT1MuIEl0IGlzIGhhcmQgdG8gaW1wbGVtZW50Lg0KDQpKaW0NCg==
