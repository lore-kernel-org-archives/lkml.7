Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3216EC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 12:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C2820879
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 12:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbfEQMNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 08:13:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:56442 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728683AbfEQMNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 08:13:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 188B2AECB;
        Fri, 17 May 2019 12:13:44 +0000 (UTC)
Date:   Fri, 17 May 2019 14:13:42 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     ltp@lists.linux.it, linux-kernel@vger.kernel.org,
        libc-alpha@sourceware.org
Cc:     lwn@lwn.net, akpm@linux-foundation.org,
        torvalds@linux-foundation.org
Subject: [ANNOUNCE] The Linux Test Project has been released for May 2019
Message-ID: <20190517121342.GA32601@rei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good news everyone,

the Linux Test Project test suite stable release for *May 2019* has been
released.

Since the last release 293 patches by 49 authors were merged.

NOTABLE CHANGES
===============

* New tests
  - ioctl_ns{01-07}: Tests for NS_GET_* ioctls
  - clock_adjtim{01,02}: New tests
  - userfaultfd01: New test
  - ioctl08: Test for FIDEDUPERANGE on Btrfs
  - sigpending02: New test for sigpending/rt_sigpending
  - pivot_root01: New test
  - tgkill{01-03}: New tests
  - set_mempolicy{01-04}: New tests
  - rt_tgsigqueueinfo01: New test
  - binfmt_misc02.sh: New functionality test
  - pwritev2{01-02}: New tests
  - rt_sigpending02: New test
  - fanotify12: New test for FAN_OPEN_EXEC event mask
  - clock_gettime{01,02}: New tests
  - fdatasync03: New test
  - fsync04: New test
  - sync03: New test
  - syncfs01: New test
  - setrlimit06: Add new test for RLIMIT_CPU
  - statx07: Add test for AT_STATX_DONT_SYNC and AT_STATX_FORCE_SYNC
  - clock_settime{01,02}: New tests

* New regression tests
  - af_alg06: malformed authenc key 8f9c46934848
  - af_alg05: skcipher_walk error bug 8088d3dd4d7c
  - af_alg04: vmac race conditions bb2964810233
  - af_alg03: rfc7539 hash alg validation e57121d08c38
  - af_alg02: salsa20 empty message bug ecaaab564978 aka CVE-2017-17805
  - af_alg01: hmac nesting bug af3ff8045bbf aka CVE-2017-17806
  - binfmt_misc01.sh: 5cc41e099504 ("fs/binfmt_misc.c: do not allow offset overflow)

* Increased coverage
  - fanotify01: add FAN_REPORT_FID test cases
  - fanotify10: increase test coverage to support FAN_OPEN_EXEC mask
  - fanotify03: add FAN_OPEN_EXEC_PERM

* New test variants API
  - The LTP test library gained support for test variants, with that we can
    test family of similar syscalls (i.e. different select syscalls) in a
    single test.

  - stime: Test 3 variants
  - sigpending: Test 3 variants
  - select04: Test 4 variants

* Various fixes for Android Bionic libc (both build and runtime) and musl libc
  are included in this release

* Additional 22 tests were converted to the new test library


NOTABLE CHANGES IN NETWORK TESTS
================================
brought to you by Peter Vorel

* New testcases
  - ipsec: test also randomized message length
  - features: new checksum testcases
  - virt: add mode l3s in ipvlan test
  - netstress: support SO_REUSEPORT, MSG_ZEROCOPY

* Various tests converted into new API
  - (arping01, broken_ip, clockdiff01, ip_tests.sh, ping0{1|0}, tracepath, traceroute)

* Various small fixes and enhancements, most notable ones:
  - dhcp: correct prefix for expected IPv6 address)
  - lower down packet size to minimum, which still be high enough to require
    fragmentation. This is critical for performance tests, which compare
    virtual devices with the real ones.
  - netstress: various fixes to avoid false-positives
  - dhcp: AppArmor and SELinux fixes, fix paths for non-RHEL distros


DOWNLOAD AND LINKS
==================

The latest version of the test-suite contains 3000+ tests for the Linux
and can be downloaded at:

https://github.com/linux-test-project/ltp/releases/tag/20190517

The project pages as well as GIT repository are hosted on GitHub:

https://github.com/linux-test-project/ltp
http://linux-test-project.github.io/

If you ever wondered how to write a LTP testcase, don't miss our developer
documentation at:

https://github.com/linux-test-project/ltp/wiki/C-Test-Case-Tutorial
https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines
https://github.com/linux-test-project/ltp/wiki/BuildSystem

Patches, new tests, bugs, comments or questions should go to to our mailing
list at ltp@lists.linux.it.


CREDITS
=======

Many thanks to the people contributing to this release:

git shortlog -s -e -n 20190115..

    40  Petr Vorel <pvorel@suse.cz>
    39  Enji Cooper <yaneurabeya@gmail.com>
    28  Cyril Hrubis <chrubis@suse.cz>
    17  Alexey Kodanev <alexey.kodanev@oracle.com>
    15  Petr Vorel <petr.vorel@gmail.com>
    15  Xiao Yang <yangx.jy@cn.fujitsu.com>
    14  Rafael David Tinoco <rafael.tinoco@linaro.org>
    12  Matthias Maennich <maennich@google.com>
    11  Sumit Garg <sumit.garg@linaro.org>
     9  Eric Biggers <ebiggers@google.com>
     7  Jan Stancek <jstancek@redhat.com>
     7  Jinhui huang <huangjh.jy@cn.fujitsu.com>
     7  Li Wang <liwang@redhat.com>
     7  Steve Muckle <smuckle@google.com>
     6  Jia Zhang <zhang.jia@linux.alibaba.com>
     6  Yang Xu <xuyang2018.jy@cn.fujitsu.com>
     5  Matthew Bobrowski <mbobrowski@mbobrowski.org>
     4  Shile Zhang <shile.zhang@linux.alibaba.com>
     3  Christian Amann <camann@suse.com>
     3  Cristian Marussi <cristian.marussi@arm.com>
     3  Greg Hackmann <ghackmann@google.com>
     3  Sandeep Patil <sspatil@android.com>
     2  Federico Bonfiglio <fedebonfi95@gmail.com>
     2  Jason Xing <kerneljasonxing@linux.alibaba.com>
     2  Michael Holzheu <holzheu@linux.vnet.ibm.com>
     2  Paul Lawrence <paullawrence@google.com>
     2  Zhengwang Ruan <ruanzw@xiaopeng.com>
     1  Alistair Strachan <astrachan@google.com>
     1  Amir Goldstein <mbobrowski@mbobrowski.org>
     1  Balamuruhan S <bala24@linux.vnet.ibm.com>
     1  Daniel Diaz <daniel.diaz@linaro.org>
     1  Daniel Mentz <danielmentz@google.com>
     1  Elif Aslan <elas@linux.vnet.ibm.com>
     1  Esteban Flores <esflores@microsoft.com>
     1  Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
     1  He Zhe <zhe.he@windriver.com>
     1  Jan Baier <jbaier@suse.cz>
     1  Michael Holzheu <holzheu@linux.ibm.com>
     1  Pengfei Xu <pengfei.xu@intel.com>
     1  Ramon Pantin <pantin@google.com>
     1  Richard Palethorpe <rpalethorpe@suse.com>
     1  Roman Kalashnikov <lunix0x@gmail.com>
     1  Sandeep Patil <sspatil@google.com>
     1  Saravana Kannan <saravanak@google.com>
     1  Tommi Rantala <tommi.t.rantala@nokia.com>
     1  Vaishnavi <vaishnavi.d@zilogic.com>
     1  Xiao Liang <xiliang@redhat.com>
     1  Yixin Zhang <yixin.zhang@intel.com>
     1  supersojo <suyanjun218@163.com>

And also thanks to patch reviewers:

git log 20190115.. | grep -Ei '(reviewed|acked)-by:' | sed 's/.*by: //' | sort | uniq -c | sort -n -r

     73 Cyril Hrubis <chrubis@suse.cz>
     20 Petr Vorel <pvorel@suse.cz>
     20 Jan Stancek <jstancek@redhat.com>
     11 Xiao Yang <yangx.jy@cn.fujitsu.com>
     11 Alexey Kodanev <alexey.kodanev@oracle.com>
      9 Steve Muckle <smuckle@google.com>
      7 Li Wang <liwang@redhat.com>
      7 Amir Goldstein <amir73il@gmail.com>
      5 Mimi Zohar <zohar@linux.ibm.com>
      5 Enji Cooper <yaneurabeya@gmail.com>
      3 Sandeep Patil <sspatil@android.com>
      2 Sumit Garg <sumit.garg@linaro.org>
      1 Xiong Zhou <xzhou@redhat.com>
      1 Sandeep Patil <sspatil@google.com>
      1 Michael Holzheu <holzheu@linux.ibm.com>
      1 Hendrik Brueckner <brueckner@linux.ibm.com>
      1 Eric Biggers <ebiggers@google.com>
      1 Enji Cooper <yaneurabeya@gmail.com
      1 Cyril Hrubis <metan@ucw.cz>
      1 Cristian Marussi <cristian.marussi@arm.com>
      1 Alessio Balsini <balsini@google.com>

-- 
Cyril Hrubis
chrubis@suse.cz
