Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE84C00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 06:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6321B2075D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 06:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cmiWMPmr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgAHGlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 01:41:40 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:12583 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726492AbgAHGlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 01:41:39 -0500
X-UUID: d48d1627e97748339e8ae3cd6ced0515-20200108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=kUH+CKXvuuCJ+JNqIK5cYBkD6I+QkoxV5z2ZPjtbIdw=;
        b=cmiWMPmrq5YXnnn05av+eeh40o0vf2kJ7ru64ZAIHHoi48SnWqNjxjezWh9LOhyZSrwvK89hdIry4+HY6Y5RL5cTYANUi01ueaogtuvVN0Qh3Kjp/2sT2bgfxulCtzg7ISH+PYRorwJ+DyhEc8bvKnI6niJU2hH3Bb9ajNg9YL0=;
X-UUID: d48d1627e97748339e8ae3cd6ced0515-20200108
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ming-fan.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1494828545; Wed, 08 Jan 2020 14:41:33 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 8 Jan 2020 14:41:05 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 8 Jan 2020 14:39:59 +0800
From:   Ming-Fan Chen <ming-fan.chen@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Yong Wu <yong.wu@mediatek.com>, Evan Green <evgreen@chromium.org>,
        Joerg Roedel <jroedel@suse.de>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Subject: memory: mtk-smi: Add bandwidth initial golden setting for MT6779
Date:   Wed, 8 Jan 2020 14:41:27 +0800
Message-ID: <1578465691-30692-1-git-send-email-ming-fan.chen@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBhZGQgZGVzY3JpcHRpb24sIGJhc2ljIG5vZGVzLCBjb25maWdfcG9ydCBhbmQN
CmJhbmR3aWR0aCBpbml0aWFsIGdvbGRlbiBzZXR0aW5nIGZvciBNVDY3NzkgU01JIGJvdGggc21p
LWxhcmIgYW5kIHNtaS1jb21tb24uDQpUaGUgc2V0dGluZyBtYWtlIGJldHRlciBwZXJmb3JtYW5j
ZSBvZiBtZW1vcnkgY29udHJvbCBmb3IgbXVsdGltZWRpYSBtb2R1bGVzLg0KDQpjaGFuZ2Vsb2cg
c2luY2UgdjI6DQpBZGQgR0FMUyBmb3IgbXQ2Nzc5IGluIHNtaS1jb21tb24udHh0DQpTcGxpdCBi
YXNpYyBub2RlcyBhbmQgY29uZmlnX3BvcnQgc3VwcG9ydCBmcm9tIGluaXRpYWwgZ29sZGVuIHNl
dHRpbmcgcGF0Y2gNCkRlZmluZSBsb2NhbCB2YXJpYWJsZSBmcm9tIGxvbmcgdG8gc2hvcnQNCk1l
cmdlIHdyaXRlbF9yZWxheGVkIGludG8gb25lIGxpbmUNClJlbW92ZSBTTUlfTEFSQl9TV19GTEFH
IGluIHNtaS1sYXJiDQoNCg0KTWluZy1GYW4gQ2hlbiAoMyk6DQogIGR0LWJpbmRpbmdzOiBtZWRp
YXRlazogQWRkIGJpbmRpbmcgZm9yIE1UNjc3OSBTTUkNCiAgbWVtb3J5OiBtdGstc21pOiBBZGQg
YmFzaWMgc3VwcG9ydCBmb3IgTVQ2Nzc5DQogIG1lbW9yeTogbXRrLXNtaTogQWRkIGJhbmR3aWR0
aCBpbml0aWFsIGdvbGRlbiBzZXR0aW5nDQoNCiAuLi4vbWVtb3J5LWNvbnRyb2xsZXJzL21lZGlh
dGVrLHNtaS1jb21tb24udHh0ICAgICB8ICAgIDUgKy0NCiAuLi4vbWVtb3J5LWNvbnRyb2xsZXJz
L21lZGlhdGVrLHNtaS1sYXJiLnR4dCAgICAgICB8ICAgIDMgKy0NCiBkcml2ZXJzL21lbW9yeS9t
dGstc21pLmMgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxNDAgKysrKysrKysrKysrKysr
KysrKy0NCiAzIGZpbGVzIGNoYW5nZWQsIDE0NCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygt
KQ==

