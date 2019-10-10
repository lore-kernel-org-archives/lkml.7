Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7F0ECE58C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 02:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B34820B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 02:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732698AbfJJCws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 22:52:48 -0400
Received: from m17617.mail.qiye.163.com ([59.111.176.17]:39410 "EHLO
        m17617.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731589AbfJJCws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 22:52:48 -0400
Received: from P80254710 (unknown [121.12.147.249])
        by m17617.mail.qiye.163.com (Hmail) with ESMTPA id 3A9C7261AAB;
        Thu, 10 Oct 2019 10:52:45 +0800 (CST)
Date:   Thu, 10 Oct 2019 10:52:49 +0800
From:   "richard.peng@oppo.com" <richard.peng@oppo.com>
To:     pbonzini <pbonzini@redhat.com>, rkrcmar <rkrcmar@redhat.com>
Cc:     kvm <kvm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] kvm/x86 : Replace BUG_ON(1) with BUG()
X-Priority: 3
X-GUID: DC6DBE28-1918-4988-81E0-F1DEDA6BAD10
X-Has-Attach: no
X-Mailer: Foxmail 7.2.10.151[cn]
Mime-Version: 1.0
Message-ID: <201910101052488242114@oppo.com>
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVk9VTE5NS0tKT0xJT0xISk9ZV1koWU
        FJSUtLSjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MSI6Tgw4QzlNFUw9AywJGh0a
        NhxPFEtVSlVKTkxLTUxOQk1OTE5JVTMWGhIXVQkSGBMaCR9VCx4VHDsUCwsUVRgUFkVZV1kSC1lB
        WUpJSlVKSVVKT0xVSU9CWVdZCAFZQUpNSk03Bg++
X-HM-Tid: 0a6db3953e9b9375kuws3a9c7261aab
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U2lnbmVkLW9mZi1ieTogUGVuZyBIYW8gPHJpY2hhcmQucGVuZ0BvcHBvLmNvbT4KLS0tCsKgYXJj
aC94ODYva3ZtL3ZteC9uZXN0ZWQuYyB8IDMgKy0tCsKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS92bXgvbmVz
dGVkLmMgYi9hcmNoL3g4Ni9rdm0vdm14L25lc3RlZC5jCmluZGV4IGU3NmViNGYuLmQwZTZjNDAg
MTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2t2bS92bXgvbmVzdGVkLmMKKysrIGIvYXJjaC94ODYva3Zt
L3ZteC9uZXN0ZWQuYwpAQCAtNDk0NSw4ICs0OTQ1LDcgQEAgc3RhdGljIGludCBoYW5kbGVfaW52
ZXB0KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkKwqAJICovCsKgCQlicmVhazsKwqAJZGVmYXVsdDoK
LQkJQlVHX09OKDEpOwotCQlicmVhazsKKwkJQlVHKCk7CsKgCX0KwqAKwqAJcmV0dXJuIG5lc3Rl
ZF92bXhfc3VjY2VlZCh2Y3B1KTsKLS3CoAoyLjcuNA==

