Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F024C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 11:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E30B217D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 11:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbfIBL3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 07:29:33 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40348 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729623AbfIBL3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 07:29:33 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DFE6814970A7908E63D2;
        Mon,  2 Sep 2019 19:29:30 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Mon, 2 Sep 2019
 19:29:29 +0800
To:     <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <trivial@kernel.org>
From:   yeyunfeng <yeyunfeng@huawei.com>
Subject: [PATCH] genirq: modify the comment for irq_desc
Message-ID: <f31aba98-5abe-6719-1490-cb249cfe0f08@huawei.com>
Date:   Mon, 2 Sep 2019 19:25:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="------------B441A4B57DACF129E25BE043"
Content-Language: en-US
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------B441A4B57DACF129E25BE043
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit


--------------B441A4B57DACF129E25BE043
Content-Type: text/plain; charset="UTF-8";
	name="0001-genirq-modify-the-comment-for-irq_desc.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="0001-genirq-modify-the-comment-for-irq_desc.patch"

RnJvbSA2OWY1MDhlMjdmOGViNDEyMTVjNzgyNTA5NzY2ZmJmOTVmNWMyYTA1IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBZdW5GZW5nIFllIDx5ZXl1bmZlbmdAaHVhd2VpLmNv
bT4KRGF0ZTogTW9uLCAyIFNlcCAyMDE5IDE1OjE5OjU3ICswODAwClN1YmplY3Q6IFtQQVRD
SF0gZ2VuaXJxOiBtb2RpZnkgdGhlIGNvbW1lbnQgZm9yIGlycV9kZXNjCgpjb21taXQgMGM2
ZjhhOGI5MTdhICgiZ2VuaXJxOiBSZW1vdmUgY29tcGF0IGNvZGUiKSBkZWxldGVkIHRoZSBA
c3RhdHVzCm1lbWJlciBvZiBpcnFfZGVzYywgYnV0IGZvcmdvdCB0byB1cGRhdGUgdGhlIGNv
bW1lbnQuIAoKU2lnbmVkLW9mZi1ieTogWXVuRmVuZyBZZSA8eWV5dW5mZW5nQGh1YXdlaS5j
b20+Ci0tLQogaW5jbHVkZS9saW51eC9pcnFkZXNjLmggfCAyICstCiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L2lycWRlc2MuaCBiL2luY2x1ZGUvbGludXgvaXJxZGVzYy5oCmluZGV4IGQ2ZTJh
YjUuLjhmMjgyMGMgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvaXJxZGVzYy5oCisrKyBi
L2luY2x1ZGUvbGludXgvaXJxZGVzYy5oCkBAIC0yNCw3ICsyNCw3IEBACiAgKiBAaGFuZGxl
X2lycToJCWhpZ2hsZXZlbCBpcnEtZXZlbnRzIGhhbmRsZXIKICAqIEBwcmVmbG93X2hhbmRs
ZXI6CWhhbmRsZXIgY2FsbGVkIGJlZm9yZSB0aGUgZmxvdyBoYW5kbGVyIChjdXJyZW50bHkg
dXNlZCBieSBzcGFyYykKICAqIEBhY3Rpb246CQl0aGUgaXJxIGFjdGlvbiBjaGFpbgotICog
QHN0YXR1czoJCXN0YXR1cyBpbmZvcm1hdGlvbgorICogQHN0YXR1c191c2VfYWNjZXNzb3Jz
OiBzdGF0dXMgaW5mb3JtYXRpb24KICAqIEBjb3JlX2ludGVybmFsX3N0YXRlX19kb19ub3Rf
bWVzc193aXRoX2l0OiBjb3JlIGludGVybmFsIHN0YXR1cyBpbmZvcm1hdGlvbgogICogQGRl
cHRoOgkJZGlzYWJsZS1kZXB0aCwgZm9yIG5lc3RlZCBpcnFfZGlzYWJsZSgpIGNhbGxzCiAg
KiBAd2FrZV9kZXB0aDoJCWVuYWJsZSBkZXB0aCwgZm9yIG11bHRpcGxlIGlycV9zZXRfaXJx
X3dha2UoKSBjYWxsZXJzCi0tIAoxLjguMy4xCgo=
--------------B441A4B57DACF129E25BE043--
