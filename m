Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35710C2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 04:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080A52464E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 04:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Y52jFYLB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfLFEFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 23:05:36 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:25490 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726076AbfLFEFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 23:05:35 -0500
X-UUID: c433c899c35b4210b759f1b5b6c57ec3-20191206
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=CV7DAlbfexttU47r175IIVk9wg60txROOSVKG7NLYFA=;
        b=Y52jFYLB+9X280FVFRBpAuANp9f36YN5zyXlYCynNuptFZ/OLgJ0CBIPuaSgIw4z+zOjd4mZdyc0Q82fbWyAxSjE0+byY/oGMHC71qShnz8zmbqKpS4CvR/HORqdk+fIYJDPJiIoWVLfyFnldB0JaU+HQeqitXNKmAOtho/mQXc=;
X-UUID: c433c899c35b4210b759f1b5b6c57ec3-20191206
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1395859010; Fri, 06 Dec 2019 12:05:30 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 6 Dec 2019 12:05:19 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 6 Dec 2019 12:05:09 +0800
Message-ID: <1575605122.6151.2.camel@mtksdaap41>
Subject: Re: [PATCH v2 05/14] arm64: dts: add gce node for mt6779
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 6 Dec 2019 12:05:22 +0800
In-Reply-To: <1574819937-6246-7-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1574819937-6246-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1574819937-6246-7-git-send-email-dennis-yc.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTExLTI3IGF0IDA5OjU4ICswODAwLCBEZW5uaXMgWUMgSHNpZWggd3JvdGU6
DQo+IGFkZCBnY2UgZGV2aWNlIG5vZGUgZm9yIG10Njc3OQ0KPiANCj4gU2lnbmVkLW9mZi1ieTog
RGVubmlzIFlDIEhzaWVoIDxkZW5uaXMteWMuaHNpZWhAbWVkaWF0ZWsuY29tPg0KDQpSZXZpZXdl
ZC1ieTogQmliYnkgSHNpZWggPGJpYmJ5LmhzaWVoQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBh
cmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210Njc3OS5kdHNpIHwgMTAgKysrKysrKysrKw0K
PiAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9h
cmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210Njc3OS5kdHNpIGIvYXJjaC9hcm02NC9ib290
L2R0cy9tZWRpYXRlay9tdDY3NzkuZHRzaQ0KPiBpbmRleCBkYWEyNWI3NTc4OGYuLjEwZDU5Mzg1
ZjRhMSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDY3Nzku
ZHRzaQ0KPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210Njc3OS5kdHNpDQo+
IEBAIC04LDYgKzgsNyBAQA0KPiAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2Nsb2NrL210Njc3OS1j
bGsuaD4NCj4gICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9pcnEu
aD4NCj4gICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2lj
Lmg+DQo+ICsjaW5jbHVkZSA8ZHQtYmluZGluZ3MvZ2NlL210Njc3OS1nY2UuaD4NCj4gIA0KPiAg
LyB7DQo+ICAJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDY3NzkiOw0KPiBAQCAtMTU5LDYgKzE2
MCwxNSBAQA0KPiAgCQkJI2Nsb2NrLWNlbGxzID0gPDE+Ow0KPiAgCQl9Ow0KPiAgDQo+ICsJCWdj
ZTogbWFpbGJveEAxMDIyODAwMCB7DQo+ICsJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10Njc3
OS1nY2UiOw0KPiArCQkJcmVnID0gPDAgMHgxMDIyODAwMCAwIDB4NDAwMD47DQo+ICsJCQlpbnRl
cnJ1cHRzID0gPEdJQ19TUEkgMTg1IElSUV9UWVBFX0xFVkVMX0xPVz47DQo+ICsJCQkjbWJveC1j
ZWxscyA9IDwzPjsNCj4gKwkJCWNsb2NrcyA9IDwmaW5mcmFjZmdfYW8gQ0xLX0lORlJBX0dDRT47
DQo+ICsJCQljbG9jay1uYW1lcyA9ICJnY2UiOw0KPiArCQl9Ow0KPiArDQo+ICAJCXVhcnQwOiBz
ZXJpYWxAMTEwMDIwMDAgew0KPiAgCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDY3NzktdWFy
dCIsDQo+ICAJCQkJICAgICAibWVkaWF0ZWssbXQ2NTc3LXVhcnQiOw0KDQo=

