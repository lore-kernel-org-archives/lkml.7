Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9A3C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5CE5218B8
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfHSPYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 11:24:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:35524 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726211AbfHSPYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:24:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 79C7BAD43;
        Mon, 19 Aug 2019 15:24:38 +0000 (UTC)
Message-ID: <1566228274.5663.29.camel@suse.com>
Subject: Re: KASAN: use-after-free Read in iowarrior_disconnect
From:   Oliver Neukum <oneukum@suse.com>
To:     syzbot <syzbot+cfe6d93e0abab9a0de05@syzkaller.appspotmail.com>,
        keescook@chromium.org, gustavo@embeddedor.com,
        andreyknvl@google.com, syzkaller-bugs@googlegroups.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Date:   Mon, 19 Aug 2019 17:24:34 +0200
In-Reply-To: <00000000000090564a0590796d2f@google.com>
References: <00000000000090564a0590796d2f@google.com>
Content-Type: multipart/mixed; boundary="=-uR6+AWK0TsMm13oftsMA"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uR6+AWK0TsMm13oftsMA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Am Montag, den 19.08.2019, 07:48 -0700 schrieb syzbot:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    d0847550 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=139be302600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=dbc9c80cc095da19
> dashboard link: https://syzkaller.appspot.com/bug?extid=cfe6d93e0abab9a0de05
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12fe6b02600000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1548189c600000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+cfe6d93e0abab9a0de05@syzkaller.appspotmail.com
> 

#syz test: https://github.com/google/kasan.git d0847550


--=-uR6+AWK0TsMm13oftsMA
Content-Disposition: attachment;
	filename="0001-Revert-usb-iowarrior-fix-deadlock-on-disconnect.patch"
Content-Transfer-Encoding: base64
Content-Type: text/x-patch;
	name="0001-Revert-usb-iowarrior-fix-deadlock-on-disconnect.patch";
	charset="UTF-8"

RnJvbSA0M2M0MjcwYTQyNDA1MmRjYjE2OGEwZmVhNWE5YWQ4OTc3OGVhZGM3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBPbGl2ZXIgTmV1a3VtIDxvbmV1a3VtQHN1c2UuY29tPgpEYXRl
OiBNb24sIDE5IEF1ZyAyMDE5IDE3OjIyOjUzICswMjAwClN1YmplY3Q6IFtQQVRDSF0gUmV2ZXJ0
ICJ1c2I6IGlvd2FycmlvcjogZml4IGRlYWRsb2NrIG9uIGRpc2Nvbm5lY3QiCgpUaGlzIHJldmVy
dHMgY29tbWl0IGFhNDBjZmI0ZDJmMTM0MzIyYTc4MmIxOGE2ODdkMDQzMDBmNTBmNjAuCi0tLQog
ZHJpdmVycy91c2IvbWlzYy9pb3dhcnJpb3IuYyB8IDcgKysrLS0tLQogMSBmaWxlIGNoYW5nZWQs
IDMgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3Vz
Yi9taXNjL2lvd2Fycmlvci5jIGIvZHJpdmVycy91c2IvbWlzYy9pb3dhcnJpb3IuYwppbmRleCBm
NWJlZDlmMjllNTYuLmJhMDVkZDgwYTAyMCAxMDA2NDQKLS0tIGEvZHJpdmVycy91c2IvbWlzYy9p
b3dhcnJpb3IuYworKysgYi9kcml2ZXJzL3VzYi9taXNjL2lvd2Fycmlvci5jCkBAIC04NjYsMjAg
Kzg2NiwxOSBAQCBzdGF0aWMgdm9pZCBpb3dhcnJpb3JfZGlzY29ubmVjdChzdHJ1Y3QgdXNiX2lu
dGVyZmFjZSAqaW50ZXJmYWNlKQogCWRldiA9IHVzYl9nZXRfaW50ZmRhdGEoaW50ZXJmYWNlKTsK
IAltdXRleF9sb2NrKCZpb3dhcnJpb3Jfb3Blbl9kaXNjX2xvY2spOwogCXVzYl9zZXRfaW50ZmRh
dGEoaW50ZXJmYWNlLCBOVUxMKTsKLQkvKiBwcmV2ZW50IGRldmljZSByZWFkLCB3cml0ZSBhbmQg
aW9jdGwgKi8KLQlkZXYtPnByZXNlbnQgPSAwOwogCiAJbWlub3IgPSBkZXYtPm1pbm9yOwotCW11
dGV4X3VubG9jaygmaW93YXJyaW9yX29wZW5fZGlzY19sb2NrKTsKLQkvKiBnaXZlIGJhY2sgb3Vy
IG1pbm9yIC0gdGhpcyB3aWxsIGNhbGwgY2xvc2UoKSBsb2NrcyBuZWVkIHRvIGJlIGRyb3BwZWQg
YXQgdGhpcyBwb2ludCovCiAKKwkvKiBnaXZlIGJhY2sgb3VyIG1pbm9yICovCiAJdXNiX2RlcmVn
aXN0ZXJfZGV2KGludGVyZmFjZSwgJmlvd2Fycmlvcl9jbGFzcyk7CiAKIAltdXRleF9sb2NrKCZk
ZXYtPm11dGV4KTsKIAogCS8qIHByZXZlbnQgZGV2aWNlIHJlYWQsIHdyaXRlIGFuZCBpb2N0bCAq
LworCWRldi0+cHJlc2VudCA9IDA7CiAKIAltdXRleF91bmxvY2soJmRldi0+bXV0ZXgpOworCW11
dGV4X3VubG9jaygmaW93YXJyaW9yX29wZW5fZGlzY19sb2NrKTsKIAogCWlmIChkZXYtPm9wZW5l
ZCkgewogCQkvKiBUaGVyZSBpcyBhIHByb2Nlc3MgdGhhdCBob2xkcyBhIGZpbGVkZXNjcmlwdG9y
IHRvIHRoZSBkZXZpY2UgLAotLSAKMi4xNi40Cgo=


--=-uR6+AWK0TsMm13oftsMA--

