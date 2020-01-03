Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A507C32771
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 03:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A07222C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 03:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Bg0fLoRJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbgACDMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 22:12:50 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:29166 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727222AbgACDMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 22:12:44 -0500
X-UUID: 1a6e1acff30b4141b08286de433530a9-20200103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Il1d/CuA3QdNQqOpUCl8h23dQ/u6yF7EK0/ELQERR1M=;
        b=Bg0fLoRJBMKBLtdur7J5Oq89uGLvUCrvqs4EJgfjhQPqvdOx/7skNllASshTqmLmVCW13XRik5bNSXx81XXqx+yDF1vv/rUmmCNUe9KqvDqgbKbHY1kskeon9vwGg3yHpGW/E2NBW81K3CN2OqKqpSyK9Hww8f8ocQTdjXXQ8ks=;
X-UUID: 1a6e1acff30b4141b08286de433530a9-20200103
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1675487694; Fri, 03 Jan 2020 11:12:38 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 3 Jan 2020 11:12:06 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 3 Jan 2020 11:13:04 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [RESEND PATCH v6 01/17] dt-bindings: mediatek: add rdma_fifo_size description for mt8183 display
Date:   Fri, 3 Jan 2020 11:12:12 +0800
Message-ID: <1578021148-32413-2-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1578021148-32413-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1578021148-32413-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXBkYXRlIGRldmljZSB0cmVlIGJpbmRpbmcgZG9jdW1lbnRpb24gZm9yIHJkbWFfZmlmb19zaXpl
DQoNClNpZ25lZC1vZmYtYnk6IFlvbmdxaWFuZyBOaXUgPHlvbmdxaWFuZy5uaXVAbWVkaWF0ZWsu
Y29tPg0KLS0tDQogLi4uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRp
YXRlayxkaXNwLnR4dCAgfCAxMyArKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDEzIGlu
c2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRpc3AudHh0IGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZGlzcC50eHQNCmlu
ZGV4IDY4MTUwMmUuLjM0YmVmNDQgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkaXNwLnR4dA0KKysrIGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWss
ZGlzcC50eHQNCkBAIC03MCw2ICs3MCwxMCBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzIChETUEgZnVu
Y3Rpb24gYmxvY2tzKToNCiAgIGFyZ3VtZW50LCBzZWUgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2lvbW11L21lZGlhdGVrLGlvbW11LnR4dA0KICAgZm9yIGRldGFpbHMuDQogDQor
UmVxdWlyZWQgcHJvcGVydGllcyAoRE1BIGZ1bmN0aW9uIGJsb2Nrcyk6DQorLSBtZWRpYXRlayxy
ZG1hX2ZpZm9fc2l6ZTogcmRtYSBmaWZvIHNpemUgbWF5IGJlIGRpZmZlcmVudCBldmVuIGluIHNh
bWUgU09DLCBhZGQgdGhpcw0KKyAgcHJvcGVydHkgdG8gdGhlIGNvcnJlc3BvbmRpbmcgcmRtYQ0K
Kw0KIEV4YW1wbGVzOg0KIA0KIG1tc3lzOiBjbG9jay1jb250cm9sbGVyQDE0MDAwMDAwIHsNCkBA
IC0yMTEsMyArMjE1LDEyIEBAIG9kQDE0MDIzMDAwIHsNCiAJcG93ZXItZG9tYWlucyA9IDwmc2Nw
c3lzIE1UODE3M19QT1dFUl9ET01BSU5fTU0+Ow0KIAljbG9ja3MgPSA8Jm1tc3lzIENMS19NTV9E
SVNQX09EPjsNCiB9Ow0KKw0KK3JkbWExOiByZG1hQDE0MDBjMDAwIHsNCisJY29tcGF0aWJsZSA9
ICJtZWRpYXRlayxtdDgxODMtZGlzcC1yZG1hIjsNCisJcmVnID0gPDAgMHgxNDAwYzAwMCAwIDB4
MTAwMD47DQorCWludGVycnVwdHMgPSA8R0lDX1NQSSAyMjkgSVJRX1RZUEVfTEVWRUxfTE9XPjsN
CisJcG93ZXItZG9tYWlucyA9IDwmc2Nwc3lzIE1UODE4M19QT1dFUl9ET01BSU5fRElTUD47DQor
CWNsb2NrcyA9IDwmbW1zeXMgQ0xLX01NX0RJU1BfUkRNQTE+Ow0KKwltZWRpYXRlayxyZG1hX2Zp
Zm9fc2l6ZSA9IDwyMDQ4PjsNCit9Ow0KXCBObyBuZXdsaW5lIGF0IGVuZCBvZiBmaWxlDQotLSAN
CjEuOC4xLjEuZGlydHkNCg==

