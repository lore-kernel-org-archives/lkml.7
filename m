Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEB4C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 281F7215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731766AbfI3On1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 10:43:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:48436 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730809AbfI3On1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 10:43:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9E6D4AE2A;
        Mon, 30 Sep 2019 14:43:24 +0000 (UTC)
Message-ID: <1569853679.2639.4.camel@suse.com>
Subject: Re: WARNING in _chaoskey_fill/usb_submit_urb
From:   Oliver Neukum <oneukum@suse.com>
To:     syzbot <syzbot+f5349b421c6213d34ce2@syzkaller.appspotmail.com>,
        gustavo@embeddedor.com, andreyknvl@google.com,
        syzkaller-bugs@googlegroups.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Date:   Mon, 30 Sep 2019 16:27:59 +0200
In-Reply-To: <000000000000488dd305933945d2@google.com>
References: <000000000000488dd305933945d2@google.com>
Content-Type: multipart/mixed; boundary="=-pDbKljJr9HUl0bviT/pC"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pDbKljJr9HUl0bviT/pC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Am Montag, den 23.09.2019, 07:31 -0700 schrieb syzbot:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    e0bd8d79 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=1452c6a1600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8847e5384a16f66a
> dashboard link: https://syzkaller.appspot.com/bug?extid=f5349b421c6213d34ce2
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16342d45600000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=166769b1600000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+f5349b421c6213d34ce2@syzkaller.appspotmail.com

#syz test: https://github.com/google/kasan.git e0bd8d79

--=-pDbKljJr9HUl0bviT/pC
Content-Disposition: attachment; filename="0001-USB-chaoskey-fix-error-case-of-a-timeout.patch"
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name="0001-USB-chaoskey-fix-error-case-of-a-timeout.patch";
	charset="UTF-8"

RnJvbSBiODBiMzlhMjU2NWE4MGYxNmNlMDA3OTgyYmFiZTc1M2UyMjVlYTgzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBPbGl2ZXIgTmV1a3VtIDxvbmV1a3VtQHN1c2UuY29tPgpEYXRl
OiBNb24sIDMwIFNlcCAyMDE5IDE1OjE5OjEzICswMjAwClN1YmplY3Q6IFtQQVRDSF0gVVNCOiBj
aGFvc2tleTogZml4IGVycm9yIGNhc2Ugb2YgYSB0aW1lb3V0CgpJbiBjYXNlIG9mIGEgdGltZW91
dCBjb21tdW5pY2F0aW9uIHdpdGggdGhlIGRldmljZSBuZWVkcyB0byBiZSBlbmRlZApmcm9tIHRo
ZSBob3N0IHNpZGUsIGxlc3Qgd2Ugb3ZlcndyaXRlIGFuIGFjdGl2ZSBVUkIKClNpZ25lZC1vZmYt
Ynk6IE9saXZlciBOZXVrdW0gPG9uZXVrdW1Ac3VzZS5kZT4KLS0tCiBkcml2ZXJzL3VzYi9taXNj
L2NoYW9za2V5LmMgfCAxNyArKysrKysrKysrKysrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDE0IGlu
c2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvbWlz
Yy9jaGFvc2tleS5jIGIvZHJpdmVycy91c2IvbWlzYy9jaGFvc2tleS5jCmluZGV4IGNmNTgyOGNl
OTI3YS4uM2NiN2UxYjdkNDU0IDEwMDY0NAotLS0gYS9kcml2ZXJzL3VzYi9taXNjL2NoYW9za2V5
LmMKKysrIGIvZHJpdmVycy91c2IvbWlzYy9jaGFvc2tleS5jCkBAIC0zODMsMTMgKzM4MywxNyBA
QCBzdGF0aWMgaW50IF9jaGFvc2tleV9maWxsKHN0cnVjdCBjaGFvc2tleSAqZGV2KQogCQkhZGV2
LT5yZWFkaW5nLAogCQkoc3RhcnRlZCA/IE5BS19USU1FT1VUIDogQUxFQV9GSVJTVF9USU1FT1VU
KSApOwogCi0JaWYgKHJlc3VsdCA8IDApCisJaWYgKHJlc3VsdCA8IDApIHsKKwkJdXNiX2tpbGxf
dXJiKGRldi0+dXJiKTsKIAkJZ290byBvdXQ7CisJfQogCi0JaWYgKHJlc3VsdCA9PSAwKQorCWlm
IChyZXN1bHQgPT0gMCkgewogCQlyZXN1bHQgPSAtRVRJTUVET1VUOwotCWVsc2UKKwkJdXNiX2tp
bGxfdXJiKGRldi0+dXJiKTsKKwl9IGVsc2UgewogCQlyZXN1bHQgPSBkZXYtPnZhbGlkOworCX0K
IG91dDoKIAkvKiBMZXQgdGhlIGRldmljZSBnbyBiYWNrIHRvIHNsZWVwIGV2ZW50dWFsbHkgKi8K
IAl1c2JfYXV0b3BtX3B1dF9pbnRlcmZhY2UoZGV2LT5pbnRlcmZhY2UpOwpAQCAtNTI1LDcgKzUy
OSwxNCBAQCBzdGF0aWMgaW50IGNoYW9za2V5X3N1c3BlbmQoc3RydWN0IHVzYl9pbnRlcmZhY2Ug
KmludGVyZmFjZSwKIAogc3RhdGljIGludCBjaGFvc2tleV9yZXN1bWUoc3RydWN0IHVzYl9pbnRl
cmZhY2UgKmludGVyZmFjZSkKIHsKKwlzdHJ1Y3QgY2hhb3NrZXkgKmRldjsKKwlzdHJ1Y3QgdXNi
X2RldmljZSAqdWRldiA9IGludGVyZmFjZV90b191c2JkZXYoaW50ZXJmYWNlKTsKKwogCXVzYl9k
YmcoaW50ZXJmYWNlLCAicmVzdW1lIik7CisJZGV2ID0gdXNiX2dldF9pbnRmZGF0YShpbnRlcmZh
Y2UpOworCWlmIChsZTE2X3RvX2NwdSh1ZGV2LT5kZXNjcmlwdG9yLmlkVmVuZG9yKSA9PSBBTEVB
X1ZFTkRPUl9JRCkKKwkJZGV2LT5yZWFkc19zdGFydGVkID0gZmFsc2U7CisKIAlyZXR1cm4gMDsK
IH0KICNlbHNlCi0tIAoyLjE2LjQKCg==


--=-pDbKljJr9HUl0bviT/pC--

