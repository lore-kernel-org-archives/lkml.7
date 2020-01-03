Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB32C32771
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 05:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9251521734
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 05:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Z7WfxnE+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgACFLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 00:11:00 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:16821 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725890AbgACFLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 00:11:00 -0500
X-UUID: b10824ba0c544a298214a4e99af02c74-20200103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=IHfE2/cUwA9PEC02rixYfsxdmjk+Xm9SLy2M7/wL2z0=;
        b=Z7WfxnE+YxE6LB7PW91yJjGguTTAGOos6PiG5zbFZRTqRQFkmM6HJaTF457q9ralc55VE8LEFrcwCiMhGiVwWa1XjmVDRsCJeTG/Oz4+zJHgIR0IpESylKEd0uUcHoRRdiJaWaDOzl5xQMGOnP+irxWGHNrHWT2zW4VsUglw9sk=;
X-UUID: b10824ba0c544a298214a4e99af02c74-20200103
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 312619134; Fri, 03 Jan 2020 13:10:39 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 3 Jan 2020 13:10:07 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 3 Jan 2020 13:11:06 +0800
Message-ID: <1578028238.31107.2.camel@mtksdaap41>
Subject: Re: [RESEND PATCH v6 01/17] dt-bindings: mediatek: add
 rdma_fifo_size description for mt8183 display
From:   CK Hu <ck.hu@mediatek.com>
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Fri, 3 Jan 2020 13:10:38 +0800
In-Reply-To: <1578021148-32413-2-git-send-email-yongqiang.niu@mediatek.com>
References: <1578021148-32413-1-git-send-email-yongqiang.niu@mediatek.com>
         <1578021148-32413-2-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: CA0325267D1E118D9AC11A3B80C3B2A10A2F0AF8FD38E2509178C262CC5F8E2C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFlvbmdxaWFuZzoNCg0KT24gRnJpLCAyMDIwLTAxLTAzIGF0IDExOjEyICswODAwLCBZb25n
cWlhbmcgTml1IHdyb3RlOg0KPiBVcGRhdGUgZGV2aWNlIHRyZWUgYmluZGluZyBkb2N1bWVudGlv
biBmb3IgcmRtYV9maWZvX3NpemUNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFlvbmdxaWFuZyBOaXUg
PHlvbmdxaWFuZy5uaXVAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIC4uLi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZGlzcC50eHQgIHwgMTMgKysrKysrKysr
KysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1n
aXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9t
ZWRpYXRlayxkaXNwLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNw
bGF5L21lZGlhdGVrL21lZGlhdGVrLGRpc3AudHh0DQo+IGluZGV4IDY4MTUwMmUuLjM0YmVmNDQg
MTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5
L21lZGlhdGVrL21lZGlhdGVrLGRpc3AudHh0DQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRpc3AudHh0DQo+IEBAIC03
MCw2ICs3MCwxMCBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzIChETUEgZnVuY3Rpb24gYmxvY2tzKToN
Cj4gICAgYXJndW1lbnQsIHNlZSBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW9t
bXUvbWVkaWF0ZWssaW9tbXUudHh0DQo+ICAgIGZvciBkZXRhaWxzLg0KPiAgDQo+ICtSZXF1aXJl
ZCBwcm9wZXJ0aWVzIChETUEgZnVuY3Rpb24gYmxvY2tzKToNCj4gKy0gbWVkaWF0ZWsscmRtYV9m
aWZvX3NpemU6IHJkbWEgZmlmbyBzaXplIG1heSBiZSBkaWZmZXJlbnQgZXZlbiBpbiBzYW1lIFNP
QywgYWRkIHRoaXMNCj4gKyAgcHJvcGVydHkgdG8gdGhlIGNvcnJlc3BvbmRpbmcgcmRtYQ0KDQpJ
IHRoaW5rICJtZWRpYXRlayxyZG1hX2ZpZm9fc2l6ZSIgaXMgbm90IGEgJ3JlcXVpcmVkJyBwcm9w
ZXJ0eS4gSW4NCm10ODE3My5kdHNpIFsxXSwgdGhlcmUgaXMgbm8gbWVkaWF0ZWsscmRtYV9maWZv
X3NpemUgaW4gcmRtYTAsIHJkbWExLA0KYW5kIHJkbWEyLiBTbyBJIHRoaW5rIHlvdSBzaG91bGQg
bW92ZSB0aGlzIHRvICdvcHRpb25hbCcgcHJvcGVydHkuDQoNClsxXQ0KaHR0cHM6Ly9naXQua2Vy
bmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUv
YXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxNzMuZHRzaT9oPXY1LjUtcmM0DQoNClJl
Z2FyZHMsDQpDSw0KDQo+ICsNCj4gIEV4YW1wbGVzOg0KPiAgDQo+ICBtbXN5czogY2xvY2stY29u
dHJvbGxlckAxNDAwMDAwMCB7DQo+IEBAIC0yMTEsMyArMjE1LDEyIEBAIG9kQDE0MDIzMDAwIHsN
Cj4gIAlwb3dlci1kb21haW5zID0gPCZzY3BzeXMgTVQ4MTczX1BPV0VSX0RPTUFJTl9NTT47DQo+
ICAJY2xvY2tzID0gPCZtbXN5cyBDTEtfTU1fRElTUF9PRD47DQo+ICB9Ow0KPiArDQo+ICtyZG1h
MTogcmRtYUAxNDAwYzAwMCB7DQo+ICsJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtZGlz
cC1yZG1hIjsNCj4gKwlyZWcgPSA8MCAweDE0MDBjMDAwIDAgMHgxMDAwPjsNCj4gKwlpbnRlcnJ1
cHRzID0gPEdJQ19TUEkgMjI5IElSUV9UWVBFX0xFVkVMX0xPVz47DQo+ICsJcG93ZXItZG9tYWlu
cyA9IDwmc2Nwc3lzIE1UODE4M19QT1dFUl9ET01BSU5fRElTUD47DQo+ICsJY2xvY2tzID0gPCZt
bXN5cyBDTEtfTU1fRElTUF9SRE1BMT47DQo+ICsJbWVkaWF0ZWsscmRtYV9maWZvX3NpemUgPSA8
MjA0OD47DQo+ICt9Ow0KPiBcIE5vIG5ld2xpbmUgYXQgZW5kIG9mIGZpbGUNCg0K

