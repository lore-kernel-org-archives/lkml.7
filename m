Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A57C388F3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 13:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADFF821920
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 13:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731403AbfI3Nun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 09:50:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:36232 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729738AbfI3Nun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 09:50:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7AF41AF7E;
        Mon, 30 Sep 2019 13:50:41 +0000 (UTC)
Message-ID: <1569850516.2639.2.camel@suse.com>
Subject: Re: WARNING in _chaoskey_fill/usb_submit_urb
From:   Oliver Neukum <oneukum@suse.com>
To:     syzbot <syzbot+f5349b421c6213d34ce2@syzkaller.appspotmail.com>,
        gustavo@embeddedor.com, andreyknvl@google.com,
        syzkaller-bugs@googlegroups.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Date:   Mon, 30 Sep 2019 15:35:16 +0200
In-Reply-To: <000000000000488dd305933945d2@google.com>
References: <000000000000488dd305933945d2@google.com>
Content-Type: multipart/mixed; boundary="=-Va0/YDZugknsz+OWYo1m"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Va0/YDZugknsz+OWYo1m
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
--=-Va0/YDZugknsz+OWYo1m
Content-Disposition: attachment; filename="0001-USB-chaoskey-fix-error-case-of-a-timeout.patch"
Content-Type: text/x-patch; name="0001-USB-chaoskey-fix-error-case-of-a-timeout.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSAyN2IwMDg1NzY4YjU1ZjJlZDhmYWY0ZjEyNTQwMjNhMDNkYzNlYjI0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBPbGl2ZXIgTmV1a3VtIDxvbmV1a3VtQHN1c2UuY29tPgpEYXRl
OiBNb24sIDMwIFNlcCAyMDE5IDE1OjE5OjEzICswMjAwClN1YmplY3Q6IFtQQVRDSF0gVVNCOiBj
aGFvc2tleTogZml4IGVycm9yIGNhc2Ugb2YgYSB0aW1lb3V0CgpJbiBjYXNlIG9mIGEgdGltZW91
dCBjb21tdW5pY2F0aW9uIHdpdGggdGhlIGRldmljZSBuZWVkcyB0byBiZSBlbmRlZApmcm9tIHRo
ZSBob3N0IHNpZGUsIGxlc3Qgd2Ugb3ZlcndyaXRlIGFuIGFjdGl2ZSBVUkIKClNpZ25lZC1vZmYt
Ynk6IE9saXZlciBOZXVrdW0gPG9uZXVrdW1Ac3VzZS5kZT4KLS0tCiBkcml2ZXJzL3VzYi9taXNj
L2NoYW9za2V5LmMgfCAyICsrCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy91c2IvbWlzYy9jaGFvc2tleS5jIGIvZHJpdmVycy91c2IvbWlzYy9j
aGFvc2tleS5jCmluZGV4IGNmNTgyOGNlOTI3YS4uODUwZjQ2Y2JhY2UyIDEwMDY0NAotLS0gYS9k
cml2ZXJzL3VzYi9taXNjL2NoYW9za2V5LmMKKysrIGIvZHJpdmVycy91c2IvbWlzYy9jaGFvc2tl
eS5jCkBAIC0zOTEsNiArMzkxLDggQEAgc3RhdGljIGludCBfY2hhb3NrZXlfZmlsbChzdHJ1Y3Qg
Y2hhb3NrZXkgKmRldikKIAllbHNlCiAJCXJlc3VsdCA9IGRldi0+dmFsaWQ7CiBvdXQ6CisJLyog
aW4gY2FzZSBvZiBhIHRpbWVvdXQgKi8KKwl1c2Jfa2lsbF91cmIoZGV2LT51cmIpOyAKIAkvKiBM
ZXQgdGhlIGRldmljZSBnbyBiYWNrIHRvIHNsZWVwIGV2ZW50dWFsbHkgKi8KIAl1c2JfYXV0b3Bt
X3B1dF9pbnRlcmZhY2UoZGV2LT5pbnRlcmZhY2UpOwogCi0tIAoyLjE2LjQKCg==


--=-Va0/YDZugknsz+OWYo1m--

