Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FBBC3A5A2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 00:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF9521897
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 00:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbfIDAyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 20:54:17 -0400
Received: from mga18.intel.com ([134.134.136.126]:21990 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727065AbfIDAyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 20:54:16 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2019 17:54:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,465,1559545200"; 
   d="full'?scan'208";a="184944301"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.6]) ([10.239.13.6])
  by orsmga003.jf.intel.com with ESMTP; 03 Sep 2019 17:54:14 -0700
Subject: Re: [btrfs] 3ae92b3782: xfstests.generic.269.fail
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     David Sterba <dsterba@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@01.org
References: <20190903080633.GA15734@shao2-debian>
 <20190903132531.ojllcte3au7ipggd@MacBook-Pro-91.local>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <d288921c-af80-0623-60eb-ff8c24d92985@intel.com>
Date:   Wed, 4 Sep 2019 08:54:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190903132531.ojllcte3au7ipggd@MacBook-Pro-91.local>
Content-Type: multipart/mixed;
 boundary="------------0800048C90D680896B146C81"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0800048C90D680896B146C81
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/3/19 9:25 PM, Josef Bacik wrote:
> On Tue, Sep 03, 2019 at 04:06:33PM +0800, kernel test robot wrote:
>> FYI, we noticed the following commit (built with gcc-7):
>>
>> commit: 3ae92b3782182d282a92573abe95c96d34ca6e73 ("btrfs: change the minimum global reserve size")
>> https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git master
>>
>> in testcase: xfstests
>> with following parameters:
>>
>> 	disk: 4HDD
>> 	fs: btrfs
>> 	test: generic-group13
>>
>> test-description: xfstests is a regression test suite for xfs and other files ystems.
>> test-url: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
>>
>>
>> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
>>
>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>>
>>
> It would help if you could capture generic/269.full, but this is likely a
> problem with fsck that I fixed a few weeks ago where we're seeing nbytes of an
> inode is wrong, but there's an orphan item so it doesn't matter.  This patch
> just made it more likely for us to have a still being iput'ed inode after a
> transaction commit.  Thanks,
>
> Josef

Hi Josef,

I enclose the generic/269.full file for your reference.

Best Regards,
Rong Chen

--------------0800048C90D680896B146C81
Content-Type: text/plain; charset=UTF-8;
 name="269.full"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="269.full"

YnRyZnMtcHJvZ3MgdjQuNy4zClNlZSBodHRwOi8vYnRyZnMud2lraS5rZXJuZWwub3JnIGZv
ciBtb3JlIGluZm9ybWF0aW9uLgoKTGFiZWw6ICAgICAgICAgICAgICAobnVsbCkKVVVJRDog
ICAgICAgICAgICAgICAKTm9kZSBzaXplOiAgICAgICAgICAxNjM4NApTZWN0b3Igc2l6ZTog
ICAgICAgIDQwOTYKRmlsZXN5c3RlbSBzaXplOiAgICA1MTIuMDBNaUIKQmxvY2sgZ3JvdXAg
cHJvZmlsZXM6CiAgRGF0YTogICAgICAgICAgICAgc2luZ2xlICAgICAgICAgICAgOC4wME1p
QgogIE1ldGFkYXRhOiAgICAgICAgIERVUCAgICAgICAgICAgICAgMzIuMDBNaUIKICBTeXN0
ZW06ICAgICAgICAgICBEVVAgICAgICAgICAgICAgICA4LjAwTWlCClNTRCBkZXRlY3RlZDog
ICAgICAgbm8KSW5jb21wYXQgZmVhdHVyZXM6ICBleHRyZWYsIHNraW5ueS1tZXRhZGF0YQpO
dW1iZXIgb2YgZGV2aWNlczogIDEKRGV2aWNlczoKICAgSUQgICAgICAgIFNJWkUgIFBBVEgK
ICAgIDEgICA1MTIuMDBNaUIgIC9kZXYvdmRiCgpmc3N0cmVzcyAtcDEyOCAtbjk5OTk5OTk5
OSAtZiBzZXRhdHRyPTEgLWZmc3luYz0wIC1mc3luYz0wIC1mZmRhdGFzeW5jPTAgLWQgL2Zz
L3NjcmF0Y2gvZnNzdHJlc3MuMjg1NApkZDogZXJyb3Igd3JpdGluZyAnL2ZzL3NjcmF0Y2gv
U1BBQ0VfQ09OU1VNRVInOiBObyBzcGFjZSBsZWZ0IG9uIGRldmljZQozNCswIHJlY29yZHMg
aW4KMzMrMCByZWNvcmRzIG91dApkZDogZmFpbGVkIHRvIG9wZW4gJy9mcy9zY3JhdGNoL1NQ
QUNFX0NPTlNVTUVSJzogTm8gc3BhY2UgbGVmdCBvbiBkZXZpY2UKZGQ6IGZhaWxlZCB0byBv
cGVuICcvZnMvc2NyYXRjaC9TUEFDRV9DT05TVU1FUic6IE5vIHNwYWNlIGxlZnQgb24gZGV2
aWNlCmRkOiBmYWlsZWQgdG8gb3BlbiAnL2ZzL3NjcmF0Y2gvU1BBQ0VfQ09OU1VNRVInOiBO
byBzcGFjZSBsZWZ0IG9uIGRldmljZQpkZDogZmFpbGVkIHRvIG9wZW4gJy9mcy9zY3JhdGNo
L1NQQUNFX0NPTlNVTUVSJzogTm8gc3BhY2UgbGVmdCBvbiBkZXZpY2UKZGQ6IGZhaWxlZCB0
byBvcGVuICcvZnMvc2NyYXRjaC9TUEFDRV9DT05TVU1FUic6IE5vIHNwYWNlIGxlZnQgb24g
ZGV2aWNlCmRkOiBmYWlsZWQgdG8gb3BlbiAnL2ZzL3NjcmF0Y2gvU1BBQ0VfQ09OU1VNRVIn
OiBObyBzcGFjZSBsZWZ0IG9uIGRldmljZQpkZDogZmFpbGVkIHRvIG9wZW4gJy9mcy9zY3Jh
dGNoL1NQQUNFX0NPTlNVTUVSJzogTm8gc3BhY2UgbGVmdCBvbiBkZXZpY2UKZGQ6IGZhaWxl
ZCB0byBvcGVuICcvZnMvc2NyYXRjaC9TUEFDRV9DT05TVU1FUic6IE5vIHNwYWNlIGxlZnQg
b24gZGV2aWNlCmRkOiBmYWlsZWQgdG8gb3BlbiAnL2ZzL3NjcmF0Y2gvU1BBQ0VfQ09OU1VN
RVInOiBObyBzcGFjZSBsZWZ0IG9uIGRldmljZQpLaWxsaW5nIGZzc3RyZXNzIHByb2Nlc3Mu
Li4KX2NoZWNrX2J0cmZzX2ZpbGVzeXN0ZW06IGZpbGVzeXN0ZW0gb24gL2Rldi92ZGIgaXMg
aW5jb25zaXN0ZW50CioqKiBmc2NrLmJ0cmZzIG91dHB1dCAqKioKY2hlY2tpbmcgZXh0ZW50
cwpjaGVja2luZyBmcmVlIHNwYWNlIGNhY2hlCmNoZWNraW5nIGZzIHJvb3RzCnJvb3QgNSBp
bm9kZSAxNTUxIGVycm9ycyA0MDAsIG5ieXRlcyB3cm9uZwpDaGVja2luZyBmaWxlc3lzdGVt
IG9uIC9kZXYvdmRiClVVSUQ6IGY1ZWU4MTI5LWI0MzQtNDIxNy1hOGZiLWJhZTJiZjRjMDA2
Mgpmb3VuZCA0NjE2MjczOTIgYnl0ZXMgdXNlZCBlcnIgaXMgMQp0b3RhbCBjc3VtIGJ5dGVz
OiAyNjczNDgKdG90YWwgdHJlZSBieXRlczogOTcxNTcxMgp0b3RhbCBmcyB0cmVlIGJ5dGVz
OiA3NjAyMTc2CnRvdGFsIGV4dGVudCB0cmVlIGJ5dGVzOiAxNTQwMDk2CmJ0cmVlIHNwYWNl
IHdhc3RlIGJ5dGVzOiAxNzEyNTcwCmZpbGUgZGF0YSBibG9ja3MgYWxsb2NhdGVkOiAxMDEy
ODkxNjQ4CiByZWZlcmVuY2VkIDM5OTEwNjA0OAoqKiogZW5kIGZzY2suYnRyZnMgb3V0cHV0
CioqKiBtb3VudCBvdXRwdXQgKioqCnJvb3RmcyBvbiAvIHR5cGUgcm9vdGZzIChydykKc3lz
ZnMgb24gL3N5cyB0eXBlIHN5c2ZzIChydyxub3N1aWQsbm9kZXYsbm9leGVjLHJlbGF0aW1l
KQpwcm9jIG9uIC9wcm9jIHR5cGUgcHJvYyAocncsbm9zdWlkLG5vZGV2LG5vZXhlYyxyZWxh
dGltZSkKZGV2dG1wZnMgb24gL2RldiB0eXBlIGRldnRtcGZzIChydyxub3N1aWQsc2l6ZT0x
NzI5Mzcyayxucl9pbm9kZXM9NDMyMzQzLG1vZGU9NzU1KQpzZWN1cml0eWZzIG9uIC9zeXMv
a2VybmVsL3NlY3VyaXR5IHR5cGUgc2VjdXJpdHlmcyAocncsbm9zdWlkLG5vZGV2LG5vZXhl
YyxyZWxhdGltZSkKc2VsaW51eGZzIG9uIC9zeXMvZnMvc2VsaW51eCB0eXBlIHNlbGludXhm
cyAocncscmVsYXRpbWUpCnRtcGZzIG9uIC9kZXYvc2htIHR5cGUgdG1wZnMgKHJ3LG5vc3Vp
ZCxub2RldikKZGV2cHRzIG9uIC9kZXYvcHRzIHR5cGUgZGV2cHRzIChydyxub3N1aWQsbm9l
eGVjLHJlbGF0aW1lLGdpZD01LG1vZGU9NjIwLHB0bXhtb2RlPTAwMCkKdG1wZnMgb24gL3J1
biB0eXBlIHRtcGZzIChydyxub3N1aWQsbm9kZXYsbW9kZT03NTUpCnRtcGZzIG9uIC9ydW4v
bG9jayB0eXBlIHRtcGZzIChydyxub3N1aWQsbm9kZXYsbm9leGVjLHJlbGF0aW1lLHNpemU9
NTEyMGspCnRtcGZzIG9uIC9zeXMvZnMvY2dyb3VwIHR5cGUgdG1wZnMgKHJvLG5vc3VpZCxu
b2Rldixub2V4ZWMsbW9kZT03NTUpCmNncm91cCBvbiAvc3lzL2ZzL2Nncm91cC9zeXN0ZW1k
IHR5cGUgY2dyb3VwIChydyxub3N1aWQsbm9kZXYsbm9leGVjLHJlbGF0aW1lLHhhdHRyLHJl
bGVhc2VfYWdlbnQ9L2xpYi9zeXN0ZW1kL3N5c3RlbWQtY2dyb3Vwcy1hZ2VudCxuYW1lPXN5
c3RlbWQpCnBzdG9yZSBvbiAvc3lzL2ZzL3BzdG9yZSB0eXBlIHBzdG9yZSAocncsbm9zdWlk
LG5vZGV2LG5vZXhlYyxyZWxhdGltZSkKY2dyb3VwIG9uIC9zeXMvZnMvY2dyb3VwL2h1Z2V0
bGIgdHlwZSBjZ3JvdXAgKHJ3LG5vc3VpZCxub2Rldixub2V4ZWMscmVsYXRpbWUsaHVnZXRs
YikKY2dyb3VwIG9uIC9zeXMvZnMvY2dyb3VwL2NwdXNldCB0eXBlIGNncm91cCAocncsbm9z
dWlkLG5vZGV2LG5vZXhlYyxyZWxhdGltZSxjcHVzZXQpCmNncm91cCBvbiAvc3lzL2ZzL2Nn
cm91cC9waWRzIHR5cGUgY2dyb3VwIChydyxub3N1aWQsbm9kZXYsbm9leGVjLHJlbGF0aW1l
LHBpZHMpCmNncm91cCBvbiAvc3lzL2ZzL2Nncm91cC9jcHUsY3B1YWNjdCB0eXBlIGNncm91
cCAocncsbm9zdWlkLG5vZGV2LG5vZXhlYyxyZWxhdGltZSxjcHUsY3B1YWNjdCkKY2dyb3Vw
IG9uIC9zeXMvZnMvY2dyb3VwL21lbW9yeSB0eXBlIGNncm91cCAocncsbm9zdWlkLG5vZGV2
LG5vZXhlYyxyZWxhdGltZSxtZW1vcnkpCmNncm91cCBvbiAvc3lzL2ZzL2Nncm91cC9ibGtp
byB0eXBlIGNncm91cCAocncsbm9zdWlkLG5vZGV2LG5vZXhlYyxyZWxhdGltZSxibGtpbykK
Y2dyb3VwIG9uIC9zeXMvZnMvY2dyb3VwL25ldF9jbHMgdHlwZSBjZ3JvdXAgKHJ3LG5vc3Vp
ZCxub2Rldixub2V4ZWMscmVsYXRpbWUsbmV0X2NscykKY2dyb3VwIG9uIC9zeXMvZnMvY2dy
b3VwL2RldmljZXMgdHlwZSBjZ3JvdXAgKHJ3LG5vc3VpZCxub2Rldixub2V4ZWMscmVsYXRp
bWUsZGV2aWNlcykKY2dyb3VwIG9uIC9zeXMvZnMvY2dyb3VwL2ZyZWV6ZXIgdHlwZSBjZ3Jv
dXAgKHJ3LG5vc3VpZCxub2Rldixub2V4ZWMscmVsYXRpbWUsZnJlZXplcikKY2dyb3VwIG9u
IC9zeXMvZnMvY2dyb3VwL3BlcmZfZXZlbnQgdHlwZSBjZ3JvdXAgKHJ3LG5vc3VpZCxub2Rl
dixub2V4ZWMscmVsYXRpbWUscGVyZl9ldmVudCkKY2dyb3VwIG9uIC9zeXMvZnMvY2dyb3Vw
L3JkbWEgdHlwZSBjZ3JvdXAgKHJ3LG5vc3VpZCxub2Rldixub2V4ZWMscmVsYXRpbWUscmRt
YSkKc3lzdGVtZC0xIG9uIC9wcm9jL3N5cy9mcy9iaW5mbXRfbWlzYyB0eXBlIGF1dG9mcyAo
cncscmVsYXRpbWUsZmQ9MzAscGdycD0xLHRpbWVvdXQ9MCxtaW5wcm90bz01LG1heHByb3Rv
PTUsZGlyZWN0LHBpcGVfaW5vPTM4Mjg5KQpodWdldGxiZnMgb24gL2Rldi9odWdlcGFnZXMg
dHlwZSBodWdldGxiZnMgKHJ3LHJlbGF0aW1lLHBhZ2VzaXplPTJNKQpkZWJ1Z2ZzIG9uIC9z
eXMva2VybmVsL2RlYnVnIHR5cGUgZGVidWdmcyAocncscmVsYXRpbWUpCnN1bnJwYyBvbiAv
cnVuL3JwY19waXBlZnMgdHlwZSBycGNfcGlwZWZzIChydyxyZWxhdGltZSkKbXF1ZXVlIG9u
IC9kZXYvbXF1ZXVlIHR5cGUgbXF1ZXVlIChydyxyZWxhdGltZSkKY29uZmlnZnMgb24gL3N5
cy9rZXJuZWwvY29uZmlnIHR5cGUgY29uZmlnZnMgKHJ3LHJlbGF0aW1lKQp0bXAgb24gL3Rt
cCB0eXBlIHRtcGZzIChydyxyZWxhdGltZSkKaW5uOi9yZXN1bHQgb24gL2lubi9yZXN1bHQg
dHlwZSBuZnMgKHJ3LHJlbGF0aW1lLHZlcnM9Myxyc2l6ZT0xMDQ4NTc2LHdzaXplPTEwNDg1
NzYsbmFtbGVuPTI1NSxoYXJkLHByb3RvPXRjcCx0aW1lbz02MDAscmV0cmFucz0yLHNlYz1z
eXMsbW91bnRhZGRyPTE5Mi4xNjguMS4xLG1vdW50dmVycz0zLG1vdW50cG9ydD02MDYzMSxt
b3VudHByb3RvPXVkcCxsb2NhbF9sb2NrPW5vbmUsYWRkcj0xOTIuMTY4LjEuMSkKKioqIGVu
ZCBtb3VudCBvdXRwdXQK
--------------0800048C90D680896B146C81--
