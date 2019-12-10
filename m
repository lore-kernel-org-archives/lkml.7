Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963EAC2BD09
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D0AD20726
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DW8tM8/K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfLJCEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 21:04:37 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:4075 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726538AbfLJCEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 21:04:37 -0500
X-UUID: daa344a5669b406182fe414abafd401d-20191210
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=IgQuYhZqNMmjibztfb1saVE2u9WvD1IS81QOavynYoU=;
        b=DW8tM8/Ka3LOpURBGBoTo0BCjYP9AoFYe4okNaeyvDfYnVuIRIyblE1pW80yFo5NO5pIHo3y31TkJdOrrClvLPqexadzDtDBGXDatBbI7eDVPVVxI7KRzfD4+9NHIAEvfJdeT3MDVUcd0GSuGGAlk2ToXJBfVGv1qLbEWpFoBPA=;
X-UUID: daa344a5669b406182fe414abafd401d-20191210
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1576203821; Tue, 10 Dec 2019 10:04:31 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 10 Dec 2019 10:04:06 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 10 Dec 2019 10:04:11 +0800
Message-ID: <1575943469.16676.0.camel@mtksdaap41>
Subject: Re: [PATCH v2 03/14] mailbox: cmdq: support mt6779 gce platform
 definition
From:   CK Hu <ck.hu@mediatek.com>
To:     Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 10 Dec 2019 10:04:29 +0800
In-Reply-To: <1574819937-6246-5-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1574819937-6246-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1574819937-6246-5-git-send-email-dennis-yc.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERlbm5pczoNCg0KT24gV2VkLCAyMDE5LTExLTI3IGF0IDA5OjU4ICswODAwLCBEZW5uaXMg
WUMgSHNpZWggd3JvdGU6DQo+IEFkZCBnY2UgdjQgaGFyZHdhcmUgc3VwcG9ydCB3aXRoIGRpZmZl
cmVudCB0aHJlYWQgbnVtYmVyIGFuZCBzaGlmdC4NCj4gDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8
Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IFNpZ25lZC1vZmYtYnk6IERlbm5pcyBZQyBIc2llaCA8
ZGVubmlzLXljLmhzaWVoQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL21haWxib3gv
bXRrLWNtZHEtbWFpbGJveC5jIHwgMiArKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94
LmMgYi9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+IGluZGV4IGQ1NTM2NTYz
ZmNlMS4uZmQ1MTliNmY1MThiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21haWxib3gvbXRrLWNt
ZHEtbWFpbGJveC5jDQo+ICsrKyBiL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMN
Cj4gQEAgLTU3MiwxMCArNTcyLDEyIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZGV2X3BtX29wcyBj
bWRxX3BtX29wcyA9IHsNCj4gIA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBnY2VfcGxhdCBnY2Vf
cGxhdF92MiA9IHsudGhyZWFkX25yID0gMTYsIC5zaGlmdCA9IDB9Ow0KPiAgc3RhdGljIGNvbnN0
IHN0cnVjdCBnY2VfcGxhdCBnY2VfcGxhdF92MyA9IHsudGhyZWFkX25yID0gMjQsIC5zaGlmdCA9
IDB9Ow0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBnY2VfcGxhdCBnY2VfcGxhdF92NCA9IHsudGhy
ZWFkX25yID0gMjQsIC5zaGlmdCA9IDN9Ow0KPiAgDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9m
X2RldmljZV9pZCBjbWRxX29mX2lkc1tdID0gew0KPiAgCXsuY29tcGF0aWJsZSA9ICJtZWRpYXRl
ayxtdDgxNzMtZ2NlIiwgLmRhdGEgPSAodm9pZCAqKSZnY2VfcGxhdF92Mn0sDQo+ICAJey5jb21w
YXRpYmxlID0gIm1lZGlhdGVrLG10ODE4My1nY2UiLCAuZGF0YSA9ICh2b2lkICopJmdjZV9wbGF0
X3YzfSwNCj4gKwl7LmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ2Nzc5LWdjZSIsIC5kYXRhID0g
KHZvaWQgKikmZ2NlX3BsYXRfdjR9LA0KPiAgCXt9DQo+ICB9Ow0KPiAgDQoNCg==

