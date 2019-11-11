Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E49C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 02:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E86462067B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 02:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GX52fptd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfKKCaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 21:30:46 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:40626 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726742AbfKKCao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 21:30:44 -0500
X-UUID: 0a285333107b476f8449e6e533de2766-20191111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=acEmGwvUjZOpmJa59Ln0aY1tOabs5B1U4izgcr2S2/4=;
        b=GX52fptdC2by0mjmY64HLCuYWezz68+Ao7X2IYxAN41Fdu4EsrpdIMwC4U/ka53tsnGNEGJJ/jaBDrG+7nugDg3QanMDtHoWvu9ABOsuBOmkacTOrIx+OK+c2IRTGFARoxEoExHpGdmKEpYCz3dAhwPLa9DyxNz7v9vkbN64L6Y=;
X-UUID: 0a285333107b476f8449e6e533de2766-20191111
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <eason.yen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 212577947; Mon, 11 Nov 2019 10:30:39 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 11 Nov 2019 10:30:38 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 11 Nov 2019 10:30:36 +0800
From:   Eason Yen <eason.yen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, Eason Yen <eason.yen@mediatek.com>
Subject: [PATCH v2 1/1] soc: mediatek: add SMC fid table for SIP interface
Date:   Mon, 11 Nov 2019 10:30:02 +0800
Message-ID: <1573439402-16249-2-git-send-email-eason.yen@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1573439402-16249-1-git-send-email-eason.yen@mediatek.com>
References: <1573439402-16249-1-git-send-email-eason.yen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MS4gQWRkIGEgaGVhZGVyIGZpbGUgdG8gcHJvdmlkZSBTSVAgaW50ZXJmYWNlIHRvIEFURg0KZm9y
IGNsaWVudHMsIHBsZWFzZSBkZWZpbmUgTVRLX1NJUF9YWFggIHdpdGggc3BlY2lmaWMgSUQNCg0K
Mi4gQWRkIEFVRElPIFNNQyBmaWQNCm10ayBzaXAgY2FsbCBleGFtcGxlOg0KYXJtX3NtY2NjX3Nt
YyhNVEtfU0lQX0FVRElPX0NPTlRST0wsDQogICAgICAgICAgICAgIE1US19BVURJT19TTUNfT1Bf
RFJBTV9SRVFVRVNULA0KICAgICAgICAgICAgICAwLCAwLCAwLCAwLCAwLCAwLCAmcmVzKQ0KDQpT
aWduZWQtb2ZmLWJ5OiBFYXNvbiBZZW4gPGVhc29uLnllbkBtZWRpYXRlay5jb20+DQotLS0NCiBp
bmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGtfc2lwX3N2Yy5oIHwgICAyOCArKysrKysrKysr
KysrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKykNCiBj
cmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrX3NpcF9zdmMu
aA0KDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrX3NpcF9zdmMu
aCBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210a19zaXBfc3ZjLmgNCm5ldyBmaWxlIG1v
ZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwLi4wMGVlMGY0DQotLS0gL2Rldi9udWxsDQorKysgYi9p
bmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGtfc2lwX3N2Yy5oDQpAQCAtMCwwICsxLDI4IEBA
DQorLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAgKi8NCisvKg0KKyAqIENvcHly
aWdodCAoYykgMjAxOSBNZWRpYVRlayBJbmMuDQorICovDQorDQorI2lmbmRlZiBfX01US19TSVBf
U1ZDX0hfXw0KKyNkZWZpbmUgX19NVEtfU0lQX1NWQ19IX18NCisNCisjaW5jbHVkZSA8bGludXgv
a2VybmVsLmg+DQorDQorLyogRXJyb3IgQ29kZSAqLw0KKyNkZWZpbmUgU0lQX1NWQ19FX1NVQ0NF
U1MgICAgICAgICAgICAgICAwDQorI2RlZmluZSBTSVBfU1ZDX0VfTk9UX1NVUFBPUlRFRCAgICAg
ICAgIC0xDQorI2RlZmluZSBTSVBfU1ZDX0VfSU5WQUxJRF9QQVJBTVMgICAgICAgIC0yDQorI2Rl
ZmluZSBTSVBfU1ZDX0VfSU5WQUxJRF9SYW5nZSAgICAgICAgIC0zDQorI2RlZmluZSBTSVBfU1ZD
X0VfUEVSTUlTU0lPTl9ERU5ZICAgICAgIC00DQorDQorI2lmZGVmIENPTkZJR19BUk02NA0KKyNk
ZWZpbmUgTVRLX1NJUF9TTUNfQUFSQ0hfQklUCQkJMHg0MDAwMDAwMA0KKyNlbHNlDQorI2RlZmlu
ZSBNVEtfU0lQX1NNQ19BQVJDSF9CSVQJCQkweDAwMDAwMDAwDQorI2VuZGlmDQorDQorLyogQVVE
SU8gcmVsYXRlZCBTTUMgY2FsbCAqLw0KKyNkZWZpbmUgTVRLX1NJUF9BVURJT19DT05UUk9MIFwN
CisJKDB4ODIwMDA1MTcgfCBNVEtfU0lQX1NNQ19BQVJDSF9CSVQpDQorI2VuZGlmDQorLyogX19N
VEtfU0lQX1NWQ19IX18gKi8NCi0tIA0KMS43LjkuNQ0K

