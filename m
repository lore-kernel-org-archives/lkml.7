Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLACK,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA08C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E45A20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfCDIth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:49:37 -0500
Received: from mga06.intel.com ([134.134.136.31]:21954 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbfCDItg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:49:36 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2019 00:49:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,439,1544515200"; 
   d="xz'?scan'208";a="148355895"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.107])
  by fmsmga002.fm.intel.com with ESMTP; 04 Mar 2019 00:49:19 -0800
Date:   Mon, 4 Mar 2019 16:49:34 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Peter Oskolkov <posk@google.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Tom Herbert <tom@herbertland.com>,
        Eric Dumazet <edumazet@google.com>,
        Florian Westphal <fw@strlen.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@01.org
Subject: [LKP] [net]  997dd96471: kernel_selftests.net.ip_defrag.sh.fail
Message-ID: <20190304084934.GD25100@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Lb0e7rgc7IsuDeGj"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Lb0e7rgc7IsuDeGj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

FYI, we noticed the following commit (built with gcc-7):

commit: 997dd96471641e147cb2c33ad54284000d0f5e35 ("net: IP6 defrag: use rbt=
rees in nf_conntrack_reasm.c")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

in testcase: kernel_selftests
with following parameters:

	group: kselftests-02

test-description: The kernel contains a set of "self tests" under the tools=
/testing/selftests/ directory. These are intended to be small unit tests to=
 exercise individual code paths in the kernel.
test-url: https://www.kernel.org/doc/Documentation/kselftest.txt


on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m =
4G

caused below changes (please refer to attached dmesg/kmsg for entire log/ba=
cktrace):




KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-7=
=2E2-997dd96471641e147cb2c33ad54284000d0f5e35
2019-03-02 12:11:59 ln -sf /usr/bin/clang-7 /usr/bin/clang
2019-03-02 12:11:59 ln -sf /usr/bin/llc-7 /usr/bin/llc
media_tests test: not in Makefile
2019-03-02 12:11:59 make TARGETS=3Dmedia_tests
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9=
6471641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/media_tests'
gcc -I../ -I../../../../usr/include/    media_device_test.c  -o /usr/src/pe=
rf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f5e35/tools=
/testing/selftests/media_tests/media_device_test
gcc -I../ -I../../../../usr/include/    media_device_open.c  -o /usr/src/pe=
rf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f5e35/tools=
/testing/selftests/media_tests/media_device_open
gcc -I../ -I../../../../usr/include/    video_device_test.c  -o /usr/src/pe=
rf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f5e35/tools=
/testing/selftests/media_tests/video_device_test
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96=
471641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/media_tests'
ignored_by_lkp media_tests test

2019-03-02 12:11:59 make run_tests -C membarrier
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647=
1641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/membarrier'
gcc -g -I../../../../usr/include/    membarrier_test.c  -o /usr/src/perf_se=
lftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f5e35/tools/test=
ing/selftests/membarrier/membarrier_test
TAP version 13
selftests: membarrier: membarrier_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1 sys_membarrier available
ok 2 sys membarrier invalid command test: command =3D -1, flags =3D 0, errn=
o =3D 22. Failed as expected
ok 3 sys membarrier MEMBARRIER_CMD_QUERY invalid flags test: flags =3D 1, e=
rrno =3D 22. Failed as expected
ok 4 sys membarrier MEMBARRIER_CMD_GLOBAL test: flags =3D 0
ok 5 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED not registered failure=
 test: flags =3D 0, errno =3D 1
ok 6 sys membarrier MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED test: flags =
=3D 0
ok 7 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED test: flags =3D 0
ok 8 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE not register=
ed failure test: flags =3D 0, errno =3D 1
ok 9 sys membarrier MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE tes=
t: flags =3D 0
ok 10 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE test: flags=
 =3D 0
ok 11 sys membarrier MEMBARRIER_CMD_GLOBAL_EXPEDITED test: flags =3D 0
ok 12 sys membarrier MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED test: flags =
=3D 0
ok 13 sys membarrier MEMBARRIER_CMD_GLOBAL_EXPEDITED test: flags =3D 0
Pass 13 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..13
ok 1..1 selftests: membarrier: membarrier_test [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471=
641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/membarrier'

2019-03-02 12:11:59 make run_tests -C memfd
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647=
1641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/memfd'
gcc -D_FILE_OFFSET_BITS=3D64 -I../../../../include/uapi/ -I../../../../incl=
ude/ -I../../../../usr/include/   -c -o common.o common.c
gcc -D_FILE_OFFSET_BITS=3D64 -I../../../../include/uapi/ -I../../../../incl=
ude/ -I../../../../usr/include/    memfd_test.c common.o  -o /usr/src/perf_=
selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f5e35/tools/te=
sting/selftests/memfd/memfd_test
memfd_test.c: In function =E2=80=98mfd_assert_get_seals=E2=80=99:
memfd_test.c:74:6: warning: implicit declaration of function =E2=80=98fcntl=
=E2=80=99 [-Wimplicit-function-declaration]
  r =3D fcntl(fd, F_GET_SEALS);
      ^~~~~
memfd_test.c: In function =E2=80=98mfd_assert_open=E2=80=99:
memfd_test.c:197:6: warning: implicit declaration of function =E2=80=98open=
=E2=80=99 [-Wimplicit-function-declaration]
  r =3D open(buf, flags, mode);
      ^~~~
memfd_test.c: In function =E2=80=98mfd_assert_write=E2=80=99:
memfd_test.c:328:6: warning: implicit declaration of function =E2=80=98fall=
ocate=E2=80=99 [-Wimplicit-function-declaration]
  r =3D fallocate(fd,
      ^~~~~~~~~
gcc -D_FILE_OFFSET_BITS=3D64 -I../../../../include/uapi/ -I../../../../incl=
ude/ -I../../../../usr/include/    fuse_mnt.c -lfuse -pthread -o /usr/src/p=
erf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f5e35/tool=
s/testing/selftests/memfd/fuse_mnt
gcc -D_FILE_OFFSET_BITS=3D64 -I../../../../include/uapi/ -I../../../../incl=
ude/ -I../../../../usr/include/    fuse_test.c common.o  -o /usr/src/perf_s=
elftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f5e35/tools/tes=
ting/selftests/memfd/fuse_test
fuse_test.c: In function =E2=80=98mfd_assert_get_seals=E2=80=99:
fuse_test.c:67:6: warning: implicit declaration of function =E2=80=98fcntl=
=E2=80=99 [-Wimplicit-function-declaration]
  r =3D fcntl(fd, F_GET_SEALS);
      ^~~~~
fuse_test.c: In function =E2=80=98main=E2=80=99:
fuse_test.c:261:7: warning: implicit declaration of function =E2=80=98open=
=E2=80=99 [-Wimplicit-function-declaration]
  fd =3D open(argv[1], O_RDONLY | O_CLOEXEC);
       ^~~~
TAP version 13
selftests: memfd: memfd_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
memfd: CREATE
memfd: BASIC
memfd: SEAL-WRITE
memfd: SEAL-SHRINK
memfd: SEAL-GROW
memfd: SEAL-RESIZE
memfd: SHARE-DUP=20
memfd: SHARE-MMAP=20
memfd: SHARE-OPEN=20
memfd: SHARE-FORK=20
memfd: SHARE-DUP (shared file-table)
memfd: SHARE-MMAP (shared file-table)
memfd: SHARE-OPEN (shared file-table)
memfd: SHARE-FORK (shared file-table)
memfd: DONE
ok 1..1 selftests: memfd: memfd_test [PASS]
selftests: memfd: run_fuse_test.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
opening: ./mnt/memfd
fuse: DONE
ok 1..2 selftests: memfd: run_fuse_test.sh [PASS]
selftests: memfd: run_hugetlbfs_test.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
memfd-hugetlb: CREATE
memfd-hugetlb: BASIC
memfd-hugetlb: SEAL-WRITE
memfd-hugetlb: SEAL-SHRINK
memfd-hugetlb: SEAL-GROW
memfd-hugetlb: SEAL-RESIZE
memfd-hugetlb: SHARE-DUP=20
memfd-hugetlb: SHARE-MMAP=20
memfd-hugetlb: SHARE-OPEN=20
memfd-hugetlb: SHARE-FORK=20
memfd-hugetlb: SHARE-DUP (shared file-table)
memfd-hugetlb: SHARE-MMAP (shared file-table)
memfd-hugetlb: SHARE-OPEN (shared file-table)
memfd-hugetlb: SHARE-FORK (shared file-table)
memfd: DONE
opening: ./mnt/memfd
fuse: DONE
ok 1..3 selftests: memfd: run_hugetlbfs_test.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471=
641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/memfd'

2019-03-02 12:12:03 make run_tests -C memory-hotplug
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647=
1641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/memory-hotplug'
TAP version 13
selftests: memory-hotplug: mem-on-off-test.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Test scope: 2% hotplug memory
	 online all hot-pluggable memory in offline state:
		 SKIPPED - no hot-pluggable memory in offline state
	 offline 2% hot-pluggable memory in online state
	 trying to offline 1 out of 14 memory block(s):
online->offline memory1
	 online all hot-pluggable memory in offline state:
offline->online memory1
	 Test with memory notifier error injection
ok 1..1 selftests: memory-hotplug: mem-on-off-test.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471=
641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/memory-hotplug'

2019-03-02 12:12:04 make run_tests -C mount
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647=
1641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/mount'
gcc -Wall -O2    unprivileged-remount-test.c  -o /usr/src/perf_selftests-x8=
6_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f5e35/tools/testing/selfte=
sts/mount/unprivileged-remount-test
TAP version 13
selftests: mount: run_tests.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..1 selftests: mount: run_tests.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471=
641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/mount'

2019-03-02 12:12:04 make run_tests -C mqueue
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647=
1641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/mqueue'
gcc -O2    mq_open_tests.c -lrt -lpthread -lpopt -o /usr/src/perf_selftests=
-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f5e35/tools/testing/sel=
ftests/mqueue/mq_open_tests
gcc -O2    mq_perf_tests.c -lrt -lpthread -lpopt -o /usr/src/perf_selftests=
-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f5e35/tools/testing/sel=
ftests/mqueue/mq_perf_tests
TAP version 13
selftests: mqueue: mq_open_tests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Using Default queue path - /test1

Initial system state:
	Using queue path:		/test1
	RLIMIT_MSGQUEUE(soft):		819200
	RLIMIT_MSGQUEUE(hard):		819200
	Maximum Message Size:		8192
	Maximum Queue Size:		10
	Default Message Size:		8192
	Default Queue Size:		10

Adjusted system state for testing:
	RLIMIT_MSGQUEUE(soft):		819200
	RLIMIT_MSGQUEUE(hard):		819200
	Maximum Message Size:		8192
	Maximum Queue Size:		10
	Default Message Size:		8192
	Default Queue Size:		10


Test series 1, behavior when no attr struct passed to mq_open:
Kernel supports setting defaults separately from maximums:		PASS
Given sane values, mq_open without an attr struct succeeds:		PASS
Kernel properly honors default setting knobs:				PASS
Kernel properly limits default values to lesser of default/max:		PASS
Kernel properly fails to create queue when defaults would
exceed rlimit:								PASS


Test series 2, behavior when attr struct is passed to mq_open:
Queue open in excess of rlimit max when euid =3D 0 failed:		PASS
Queue open with mq_maxmsg > limit when euid =3D 0 succeeded:		PASS
Queue open with mq_msgsize > limit when euid =3D 0 succeeded:		PASS
Queue open with total size > 2GB when euid =3D 0 failed:			PASS
Queue open in excess of rlimit max when euid =3D 99 failed:		PASS
Queue open with mq_maxmsg > limit when euid =3D 99 failed:		PASS
Queue open with mq_msgsize > limit when euid =3D 99 failed:		PASS
Queue open with total size > 2GB when euid =3D 99 failed:			PASS
ok 1..1 selftests: mqueue: mq_open_tests [PASS]
selftests: mqueue: mq_perf_tests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Initial system state:
	Using queue path:			/mq_perf_tests
	RLIMIT_MSGQUEUE(soft):			819200
	RLIMIT_MSGQUEUE(hard):			819200
	Maximum Message Size:			8192
	Maximum Queue Size:			10
	Nice value:				0

Adjusted system state for testing:
	RLIMIT_MSGQUEUE(soft):			(unlimited)
	RLIMIT_MSGQUEUE(hard):			(unlimited)
	Maximum Message Size:			16777216
	Maximum Queue Size:			65530
	Nice value:				-20
	Continuous mode:			(disabled)
	CPUs to pin:				1

	Queue /mq_perf_tests created:
		mq_flags:			O_NONBLOCK
		mq_maxmsg:			65530
		mq_msgsize:			16
		mq_curmsgs:			0

	Started mqueue performance test thread on CPU 1
		Max priorities:			32768
		Clock resolution:		1 nsec

	Test #1: Time send/recv message, queue empty
		(10000000 iterations)
		Send msg:			20.531927949s total time
						2053 nsec/msg
		Recv msg:			20.894450141s total time
						2089 nsec/msg

	Test #2a: Time send/recv message, queue full, constant prio
:
		(100000 iterations)
		Filling queue...done.		0.74747194s
		Testing...done.
		Send msg:			0.206763286s total time
						2067 nsec/msg
		Recv msg:			0.206895782s total time
						2068 nsec/msg
		Draining queue...done.		0.61191700s

	Test #2b: Time send/recv message, queue full, increasing prio
:
		(100000 iterations)
		Filling queue...done.		0.81945153s
		Testing...done.
		Send msg:			0.237830829s total time
						2378 nsec/msg
		Recv msg:			0.225050307s total time
						2250 nsec/msg
		Draining queue...done.		0.67745149s

	Test #2c: Time send/recv message, queue full, decreasing prio
:
		(100000 iterations)
		Filling queue...done.		0.80681722s
		Testing...done.
		Send msg:			0.225532888s total time
						2255 nsec/msg
		Recv msg:			0.217816083s total time
						2178 nsec/msg
		Draining queue...done.		0.65945561s

	Test #2d: Time send/recv message, queue full, random prio
:
		(100000 iterations)
		Filling queue...done.		0.87979278s
		Testing...done.
		Send msg:			0.230904730s total time
						2309 nsec/msg
		Recv msg:			0.215631604s total time
						2156 nsec/msg
		Draining queue...done.		0.72214322s
ok 1..2 selftests: mqueue: mq_perf_tests [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471=
641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/mqueue'

2019-03-02 12:13:04 make run_tests -C net
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647=
1641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/net'
make ARCH=3Dx86 -C ../../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9=
6471641e147cb2c33ad54284000d0f5e35'
  HOSTCC  scripts/basic/fixdep
  WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
  WRAP    arch/x86/include/generated/uapi/asm/poll.h
  SYSTBL  arch/x86/include/generated/asm/syscalls_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_64.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_x32.h
  HOSTCC  arch/x86/tools/relocs_32.o
  HOSTCC  arch/x86/tools/relocs_64.o
  HOSTCC  arch/x86/tools/relocs_common.o
  HOSTLD  arch/x86/tools/relocs
  UPD     include/generated/uapi/linux/version.h
  HOSTCC  scripts/unifdef
  INSTALL usr/include/asm-generic/ (37 files)
  INSTALL usr/include/drm/ (26 files)
  INSTALL usr/include/linux/ (503 files)
  INSTALL usr/include/linux/android/ (2 files)
  INSTALL usr/include/linux/byteorder/ (2 files)
  INSTALL usr/include/linux/caif/ (2 files)
  INSTALL usr/include/linux/can/ (6 files)
  INSTALL usr/include/linux/cifs/ (1 file)
  INSTALL usr/include/linux/dvb/ (8 files)
  INSTALL usr/include/linux/genwqe/ (1 file)
  INSTALL usr/include/linux/hdlc/ (1 file)
  INSTALL usr/include/linux/hsi/ (2 files)
  INSTALL usr/include/linux/iio/ (2 files)
  INSTALL usr/include/linux/isdn/ (1 file)
  INSTALL usr/include/linux/mmc/ (1 file)
  INSTALL usr/include/linux/netfilter/ (88 files)
  INSTALL usr/include/linux/netfilter/ipset/ (4 files)
  INSTALL usr/include/linux/netfilter_arp/ (2 files)
  INSTALL usr/include/linux/netfilter_bridge/ (17 files)
  INSTALL usr/include/linux/netfilter_ipv4/ (9 files)
  INSTALL usr/include/linux/netfilter_ipv6/ (13 files)
  INSTALL usr/include/linux/nfsd/ (5 files)
  INSTALL usr/include/linux/raid/ (2 files)
  INSTALL usr/include/linux/sched/ (1 file)
  INSTALL usr/include/linux/spi/ (1 file)
  INSTALL usr/include/linux/sunrpc/ (1 file)
  INSTALL usr/include/linux/tc_act/ (15 files)
  INSTALL usr/include/linux/tc_ematch/ (5 files)
  INSTALL usr/include/linux/usb/ (13 files)
  INSTALL usr/include/linux/wimax/ (1 file)
  INSTALL usr/include/misc/ (2 files)
  INSTALL usr/include/mtd/ (5 files)
  INSTALL usr/include/rdma/ (25 files)
  INSTALL usr/include/rdma/hfi/ (2 files)
  INSTALL usr/include/scsi/ (5 files)
  INSTALL usr/include/scsi/fc/ (4 files)
  INSTALL usr/include/sound/ (16 files)
  INSTALL usr/include/video/ (3 files)
  INSTALL usr/include/xen/ (4 files)
  INSTALL usr/include/asm/ (62 files)
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96=
471641e147cb2c33ad54284000d0f5e35'
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseport=
_bpf.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33a=
d54284000d0f5e35/tools/testing/selftests/net/reuseport_bpf
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseport=
_bpf_cpu.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2=
c33ad54284000d0f5e35/tools/testing/selftests/net/reuseport_bpf_cpu
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/  -lnuma  reu=
seport_bpf_numa.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641=
e147cb2c33ad54284000d0f5e35/tools/testing/selftests/net/reuseport_bpf_numa
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseport=
_dualstack.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147c=
b2c33ad54284000d0f5e35/tools/testing/selftests/net/reuseport_dualstack
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseaddr=
_conflict.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb=
2c33ad54284000d0f5e35/tools/testing/selftests/net/reuseaddr_conflict
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    tls.c  -o=
 /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d=
0f5e35/tools/testing/selftests/net/tls
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    socket.c =
 -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad542840=
00d0f5e35/tools/testing/selftests/net/socket
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    psock_fan=
out.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad=
54284000d0f5e35/tools/testing/selftests/net/psock_fanout
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    psock_tpa=
cket.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33a=
d54284000d0f5e35/tools/testing/selftests/net/psock_tpacket
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    msg_zeroc=
opy.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad=
54284000d0f5e35/tools/testing/selftests/net/msg_zerocopy
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseport=
_addr_any.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb=
2c33ad54284000d0f5e35/tools/testing/selftests/net/reuseport_addr_any
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/  -lpthread  =
tcp_mmap.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2=
c33ad54284000d0f5e35/tools/testing/selftests/net/tcp_mmap
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/  -lpthread  =
tcp_inq.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c=
33ad54284000d0f5e35/tools/testing/selftests/net/tcp_inq
tcp_inq.c: In function =E2=80=98main=E2=80=99:
tcp_inq.c:178:4: warning: dereferencing type-punned pointer will break stri=
ct-aliasing rules [-Wstrict-aliasing]
    inq =3D *((int *) CMSG_DATA(cm));
    ^~~
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    psock_snd=
=2Ec  -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad5=
4284000d0f5e35/tools/testing/selftests/net/psock_snd
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    txring_ov=
erwrite.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c=
33ad54284000d0f5e35/tools/testing/selftests/net/txring_overwrite
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    udpgso.c =
 -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad542840=
00d0f5e35/tools/testing/selftests/net/udpgso
udpgso.c: In function =E2=80=98send_one=E2=80=99:
udpgso.c:484:3: warning: dereferencing type-punned pointer will break stric=
t-aliasing rules [-Wstrict-aliasing]
   *((uint16_t *) CMSG_DATA(cm)) =3D gso_len;
   ^
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    udpgso_be=
nch_tx.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c3=
3ad54284000d0f5e35/tools/testing/selftests/net/udpgso_bench_tx
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    udpgso_be=
nch_rx.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c3=
3ad54284000d0f5e35/tools/testing/selftests/net/udpgso_bench_rx
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    ip_defrag=
=2Ec  -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad5=
4284000d0f5e35/tools/testing/selftests/net/ip_defrag
TAP version 13
selftests: net: reuseport_bpf
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
---- IPv4 UDP ----
Testing EBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing EBPF mod 20...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 10: 10
Socket 11: 11
Socket 12: 12
Socket 13: 13
Socket 14: 14
Socket 15: 15
Socket 16: 16
Socket 17: 17
Socket 18: 18
Socket 19: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 10: 30
Socket 11: 31
Socket 12: 32
Socket 13: 33
Socket 14: 34
Socket 15: 35
Socket 16: 36
Socket 17: 37
Socket 18: 38
Socket 19: 39
Reprograming, testing mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 0: 30
Socket 1: 31
Socket 2: 32
Socket 3: 33
Socket 4: 34
Socket 5: 35
Socket 6: 36
Socket 7: 37
Socket 8: 38
Socket 9: 39
Testing CBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing CBPF mod 20...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 10: 10
Socket 11: 11
Socket 12: 12
Socket 13: 13
Socket 14: 14
Socket 15: 15
Socket 16: 16
Socket 17: 17
Socket 18: 18
Socket 19: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 10: 30
Socket 11: 31
Socket 12: 32
Socket 13: 33
Socket 14: 34
Socket 15: 35
Socket 16: 36
Socket 17: 37
Socket 18: 38
Socket 19: 39
Reprograming, testing mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 0: 30
Socket 1: 31
Socket 2: 32
Socket 3: 33
Socket 4: 34
Socket 5: 35
Socket 6: 36
Socket 7: 37
Socket 8: 38
Socket 9: 39
Testing too many filters...
Testing filters on non-SO_REUSEPORT socket...
---- IPv6 UDP ----
Testing EBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing EBPF mod 20...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 10: 10
Socket 11: 11
Socket 12: 12
Socket 13: 13
Socket 14: 14
Socket 15: 15
Socket 16: 16
Socket 17: 17
Socket 18: 18
Socket 19: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 10: 30
Socket 11: 31
Socket 12: 32
Socket 13: 33
Socket 14: 34
Socket 15: 35
Socket 16: 36
Socket 17: 37
Socket 18: 38
Socket 19: 39
Reprograming, testing mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 0: 30
Socket 1: 31
Socket 2: 32
Socket 3: 33
Socket 4: 34
Socket 5: 35
Socket 6: 36
Socket 7: 37
Socket 8: 38
Socket 9: 39
Testing CBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing CBPF mod 20...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 10: 10
Socket 11: 11
Socket 12: 12
Socket 13: 13
Socket 14: 14
Socket 15: 15
Socket 16: 16
Socket 17: 17
Socket 18: 18
Socket 19: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 10: 30
Socket 11: 31
Socket 12: 32
Socket 13: 33
Socket 14: 34
Socket 15: 35
Socket 16: 36
Socket 17: 37
Socket 18: 38
Socket 19: 39
Reprograming, testing mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 0: 30
Socket 1: 31
Socket 2: 32
Socket 3: 33
Socket 4: 34
Socket 5: 35
Socket 6: 36
Socket 7: 37
Socket 8: 38
Socket 9: 39
Testing too many filters...
Testing filters on non-SO_REUSEPORT socket...
---- IPv6 UDP w/ mapped IPv4 ----
Testing EBPF mod 20...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 10: 10
Socket 11: 11
Socket 12: 12
Socket 13: 13
Socket 14: 14
Socket 15: 15
Socket 16: 16
Socket 17: 17
Socket 18: 18
Socket 19: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 10: 30
Socket 11: 31
Socket 12: 32
Socket 13: 33
Socket 14: 34
Socket 15: 35
Socket 16: 36
Socket 17: 37
Socket 18: 38
Socket 19: 39
Reprograming, testing mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 0: 30
Socket 1: 31
Socket 2: 32
Socket 3: 33
Socket 4: 34
Socket 5: 35
Socket 6: 36
Socket 7: 37
Socket 8: 38
Socket 9: 39
Testing EBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing CBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing CBPF mod 20...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 10: 10
Socket 11: 11
Socket 12: 12
Socket 13: 13
Socket 14: 14
Socket 15: 15
Socket 16: 16
Socket 17: 17
Socket 18: 18
Socket 19: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 10: 30
Socket 11: 31
Socket 12: 32
Socket 13: 33
Socket 14: 34
Socket 15: 35
Socket 16: 36
Socket 17: 37
Socket 18: 38
Socket 19: 39
Reprograming, testing mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 0: 30
Socket 1: 31
Socket 2: 32
Socket 3: 33
Socket 4: 34
Socket 5: 35
Socket 6: 36
Socket 7: 37
Socket 8: 38
Socket 9: 39
---- IPv4 TCP ----
Testing EBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing CBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing too many filters...
Testing filters on non-SO_REUSEPORT socket...
---- IPv6 TCP ----
Testing EBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing CBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing too many filters...
Testing filters on non-SO_REUSEPORT socket...
---- IPv6 TCP w/ mapped IPv4 ----
Testing EBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing CBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing filter add without bind...
SUCCESS
ok 1..1 selftests: net: reuseport_bpf [PASS]
selftests: net: reuseport_bpf_cpu
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
---- IPv4 UDP ----
send cpu 0, receive socket 0
send cpu 1, receive socket 1
send cpu 1, receive socket 1
send cpu 0, receive socket 0
send cpu 0, receive socket 0
send cpu 1, receive socket 1
---- IPv6 UDP ----
send cpu 0, receive socket 0
send cpu 1, receive socket 1
send cpu 1, receive socket 1
send cpu 0, receive socket 0
send cpu 0, receive socket 0
send cpu 1, receive socket 1
---- IPv4 TCP ----
send cpu 0, receive socket 0
send cpu 1, receive socket 1
send cpu 1, receive socket 1
send cpu 0, receive socket 0
send cpu 0, receive socket 0
send cpu 1, receive socket 1
---- IPv6 TCP ----
send cpu 0, receive socket 0
send cpu 1, receive socket 1
send cpu 1, receive socket 1
send cpu 0, receive socket 0
send cpu 0, receive socket 0
send cpu 1, receive socket 1
SUCCESS
ok 1..2 selftests: net: reuseport_bpf_cpu [PASS]
selftests: net: reuseport_bpf_numa
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
---- IPv4 UDP ----
send node 0, receive socket 0
send node 0, receive socket 0
---- IPv6 UDP ----
send node 0, receive socket 0
send node 0, receive socket 0
---- IPv4 TCP ----
send node 0, receive socket 0
send node 0, receive socket 0
---- IPv6 TCP ----
send node 0, receive socket 0
send node 0, receive socket 0
SUCCESS
ok 1..3 selftests: net: reuseport_bpf_numa [PASS]
selftests: net: reuseport_dualstack
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
---- UDP IPv4 created before IPv6 ----
---- UDP IPv6 created before IPv4 ----
---- UDP IPv4 created before IPv6 (large) ----
---- UDP IPv6 created before IPv4 (large) ----
---- TCP IPv4 created before IPv6 ----
---- TCP IPv6 created before IPv4 ----
SUCCESS
ok 1..4 selftests: net: reuseport_dualstack [PASS]
selftests: net: reuseaddr_conflict
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Opening 127.0.0.1:9999
Opening INADDR_ANY:9999
bind: Address already in use
Opening in6addr_any:9999
Opening INADDR_ANY:9999
bind: Address already in use
Opening INADDR_ANY:9999 after closing ipv6 socket
bind: Address already in use
Successok 1..5 selftests: net: reuseaddr_conflict [PASS]
selftests: net: tls
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] Running 29 tests from 2 test cases.
[ RUN      ] tls.sendfile
[       OK ] tls.sendfile
[ RUN      ] tls.send_then_sendfile
[       OK ] tls.send_then_sendfile
[ RUN      ] tls.recv_max
[       OK ] tls.recv_max
[ RUN      ] tls.recv_small
[       OK ] tls.recv_small
[ RUN      ] tls.msg_more
[       OK ] tls.msg_more
[ RUN      ] tls.sendmsg_single
[       OK ] tls.sendmsg_single
[ RUN      ] tls.sendmsg_large
[       OK ] tls.sendmsg_large
[ RUN      ] tls.sendmsg_multiple
[       OK ] tls.sendmsg_multiple
[ RUN      ] tls.sendmsg_multiple_stress
[       OK ] tls.sendmsg_multiple_stress
[ RUN      ] tls.splice_from_pipe
[       OK ] tls.splice_from_pipe
[ RUN      ] tls.splice_from_pipe2
[       OK ] tls.splice_from_pipe2
[ RUN      ] tls.send_and_splice
[       OK ] tls.send_and_splice
[ RUN      ] tls.splice_to_pipe
[       OK ] tls.splice_to_pipe
[ RUN      ] tls.recvmsg_single
[       OK ] tls.recvmsg_single
[ RUN      ] tls.recvmsg_single_max
[       OK ] tls.recvmsg_single_max
[ RUN      ] tls.recvmsg_multiple
[       OK ] tls.recvmsg_multiple
[ RUN      ] tls.single_send_multiple_recv
[       OK ] tls.single_send_multiple_recv
[ RUN      ] tls.multiple_send_single_recv
[       OK ] tls.multiple_send_single_recv
[ RUN      ] tls.recv_partial
[       OK ] tls.recv_partial
[ RUN      ] tls.recv_nonblock
[       OK ] tls.recv_nonblock
[ RUN      ] tls.recv_peek
[       OK ] tls.recv_peek
[ RUN      ] tls.recv_peek_multiple
[       OK ] tls.recv_peek_multiple
[ RUN      ] tls.recv_peek_multiple_records
[       OK ] tls.recv_peek_multiple_records
[ RUN      ] tls.recv_peek_large_buf_mult_recs
[       OK ] tls.recv_peek_large_buf_mult_recs
[ RUN      ] tls.pollin
[       OK ] tls.pollin
[ RUN      ] tls.poll_wait
[       OK ] tls.poll_wait
[ RUN      ] tls.blocking
[       OK ] tls.blocking
[ RUN      ] tls.nonblocking
[       OK ] tls.nonblocking
[ RUN      ] tls.control_msg
[       OK ] tls.control_msg
[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] 29 / 29 tests passed.
[  PASSED  ]
ok 1..6 selftests: net: tls [PASS]
selftests: net: run_netsocktests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--------------------
running socket test
--------------------
[PASS]
ok 1..7 selftests: net: run_netsocktests [PASS]
selftests: net: run_afpackettests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--------------------
running psock_fanout test
--------------------
test: control single socket
test: control multiple sockets
test: unique ids

test: datapath 0x0 ports 8000,8002
info: count=3D0,0, expect=3D0,0
info: count=3D0,20, expect=3D15,5
warning: incorrect queue lengths
info: count=3D0,20, expect=3D20,5
warning: incorrect queue lengths
info: trying alternate ports (20)

test: datapath 0x0 ports 8000,8003
info: count=3D0,0, expect=3D0,0
info: count=3D0,20, expect=3D15,5
warning: incorrect queue lengths
info: count=3D0,20, expect=3D20,5
warning: incorrect queue lengths
info: trying alternate ports (19)

test: datapath 0x0 ports 8000,8004
info: count=3D0,0, expect=3D0,0
info: count=3D5,15, expect=3D15,5
info: count=3D5,20, expect=3D20,5

test: datapath 0x1000 ports 8000,8004
info: count=3D0,0, expect=3D0,0
info: count=3D5,15, expect=3D15,5
info: count=3D15,20, expect=3D20,15

test: datapath 0x1 ports 8000,8004
info: count=3D0,0, expect=3D0,0
info: count=3D10,10, expect=3D10,10
info: count=3D17,18, expect=3D18,17

test: datapath 0x3 ports 8000,8004
info: count=3D0,0, expect=3D0,0
info: count=3D15,5, expect=3D15,5
info: count=3D20,15, expect=3D20,15

test: datapath 0x6 ports 8000,8004
info: count=3D0,0, expect=3D0,0
info: count=3D5,15, expect=3D15,5
info: count=3D20,15, expect=3D15,20

test: datapath 0x7 ports 8000,8004
info: count=3D0,0, expect=3D0,0
info: count=3D5,15, expect=3D15,5
info: count=3D20,15, expect=3D15,20

test: datapath 0x2 ports 8000,8004
info: count=3D0,0, expect=3D0,0
info: count=3D20,0, expect=3D20,0
info: count=3D20,0, expect=3D20,0

test: datapath 0x2 ports 8000,8004
info: count=3D0,0, expect=3D0,0
info: count=3D0,20, expect=3D0,20
info: count=3D0,20, expect=3D0,20

test: datapath 0x2000 ports 8000,8004
info: count=3D0,0, expect=3D0,0
info: count=3D20,20, expect=3D20,20
info: count=3D20,20, expect=3D20,20
OK. All tests passed
[PASS]
--------------------
running psock_tpacket test
--------------------
test: TPACKET_V1 with PACKET_RX_RING .................... 100 pkts (14200 b=
ytes)
test: TPACKET_V1 with PACKET_TX_RING .................... 100 pkts (14200 b=
ytes)
test: TPACKET_V2 with PACKET_RX_RING .................... 100 pkts (14200 b=
ytes)
test: TPACKET_V2 with PACKET_TX_RING .................... 100 pkts (14200 b=
ytes)
test: TPACKET_V3 with PACKET_RX_RING .................... 100 pkts (14200 b=
ytes)
test: TPACKET_V3 with PACKET_TX_RING .................... 100 pkts (14200 b=
ytes)
OK. All tests passed
[PASS]
--------------------
running txring_overwrite test
--------------------
read: a (0x61)
read: b (0x62)
[PASS]
ok 1..8 selftests: net: run_afpackettests [PASS]
selftests: net: test_bpf.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
test_bpf: ok
ok 1..9 selftests: net: test_bpf.sh [PASS]
selftests: net: netdevice.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
SKIP: eth0: interface already up
Cannot get device udp-fragmentation-offload settings: Operation not support=
ed
PASS: eth0: ethtool list features
PASS: eth0: ethtool dump
PASS: eth0: ethtool stats
SKIP: eth0: interface kept up
ok 1..10 selftests: net: netdevice.sh [PASS]
selftests: net: rtnetlink.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
PASS: policy routing
PASS: route get
PASS: tc htb hierarchy
PASS: gre tunnel endpoint
PASS: gretap
RTNETLINK answers: Operation not supported
Cannot find device "ip6gretap00"
Cannot find device "ip6gretap00"
Cannot find device "ip6gretap00"
RTNETLINK answers: Operation not supported
Cannot find device "ip6gretap00"
FAIL: ip6gretap
PASS: erspan
RTNETLINK answers: Operation not supported
Cannot find device "ip6erspan00"
Cannot find device "ip6erspan00"
Cannot find device "ip6erspan00"
RTNETLINK answers: Operation not supported
Cannot find device "ip6erspan00"
Cannot find device "ip6erspan00"
Cannot find device "ip6erspan00"
RTNETLINK answers: Operation not supported
Cannot find device "ip6erspan00"
FAIL: ip6erspan
PASS: bridge setup
PASS: ipv6 addrlabel
PASS: set ifalias b7e7fa9a-41cd-4559-8440-b352756687db for test-dummy0
PASS: vrf
PASS: vxlan
PASS: fou
PASS: macsec
PASS: ipsec
FAIL: ipsec_offload netdevsim doesn't support IPsec offload
SKIP: fdb get tests: iproute2 too old
SKIP: fdb get tests: iproute2 too old
ok 1..11 selftests: net: rtnetlink.sh [PASS]
selftests: net: xfrm_policy.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
PASS: policy before exception matches
PASS: ping to .254 bypassed ipsec tunnel
PASS: direct policy matches
PASS: policy matches
ok 1..12 selftests: net: xfrm_policy.sh [PASS]
selftests: net: fib_tests.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Single path route test
    Start point
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    Nexthop device deleted
    TEST: IPv4 fibmatch - no route                                      [ O=
K ]
    TEST: IPv6 fibmatch - no route                                      [ O=
K ]

Multipath route test
    Start point
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    One nexthop device deleted
    TEST: IPv4 - multipath route removed on delete                      [ O=
K ]
    TEST: IPv6 - multipath down to single path                          [ O=
K ]
    Second nexthop device deleted
    TEST: IPv6 - no route                                               [ O=
K ]

Single path, admin down
    Start point
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    Route deleted on down
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]

Admin down multipath
    Verify start point
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    One device down, one up
    TEST: IPv4 fibmatch on down device                                  [ O=
K ]
    TEST: IPv6 fibmatch on down device                                  [ O=
K ]
    TEST: IPv4 fibmatch on up device                                    [ O=
K ]
    TEST: IPv6 fibmatch on up device                                    [ O=
K ]
    TEST: IPv4 flags on down device                                     [ O=
K ]
    TEST: IPv6 flags on down device                                     [ O=
K ]
    TEST: IPv4 flags on up device                                       [ O=
K ]
    TEST: IPv6 flags on up device                                       [ O=
K ]
    Other device down and up
    TEST: IPv4 fibmatch on down device                                  [ O=
K ]
    TEST: IPv6 fibmatch on down device                                  [ O=
K ]
    TEST: IPv4 fibmatch on up device                                    [ O=
K ]
    TEST: IPv6 fibmatch on up device                                    [ O=
K ]
    TEST: IPv4 flags on down device                                     [ O=
K ]
    TEST: IPv6 flags on down device                                     [ O=
K ]
    TEST: IPv4 flags on up device                                       [ O=
K ]
    TEST: IPv6 flags on up device                                       [ O=
K ]
    Both devices down
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]

Local carrier tests - single path
    Start point
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    TEST: IPv4 - no linkdown flag                                       [ O=
K ]
    TEST: IPv6 - no linkdown flag                                       [ O=
K ]
    Carrier off on nexthop
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    TEST: IPv4 - linkdown flag set                                      [ O=
K ]
    TEST: IPv6 - linkdown flag set                                      [ O=
K ]
    Route to local address with carrier down
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    TEST: IPv4 linkdown flag set                                        [ O=
K ]
    TEST: IPv6 linkdown flag set                                        [ O=
K ]

Single path route carrier test
    Start point
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    TEST: IPv4 no linkdown flag                                         [ O=
K ]
    TEST: IPv6 no linkdown flag                                         [ O=
K ]
    Carrier down
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    TEST: IPv4 linkdown flag set                                        [ O=
K ]
    TEST: IPv6 linkdown flag set                                        [ O=
K ]
    Second address added with carrier down
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    TEST: IPv4 linkdown flag set                                        [ O=
K ]
    TEST: IPv6 linkdown flag set                                        [ O=
K ]

IPv4 nexthop tests
<<< write me >>>

IPv6 nexthop tests
    TEST: Directly connected nexthop, unicast address                   [ O=
K ]
    TEST: Directly connected nexthop, unicast address with device       [ O=
K ]
    TEST: Gateway is linklocal address                                  [ O=
K ]
    TEST: Gateway is linklocal address, no device                       [ O=
K ]
    TEST: Gateway can not be local unicast address                      [ O=
K ]
    TEST: Gateway can not be local unicast address, with device         [ O=
K ]
    TEST: Gateway can not be a local linklocal address                  [ O=
K ]
    TEST: Gateway can be local address in a VRF                         [ O=
K ]
    TEST: Gateway can be local address in a VRF, with device            [ O=
K ]
    TEST: Gateway can be local linklocal address in a VRF               [ O=
K ]
    TEST: Redirect to VRF lookup                                        [ O=
K ]
    TEST: VRF route, gateway can be local address in default VRF        [ O=
K ]
    TEST: VRF route, gateway can not be a local address                 [ O=
K ]
    TEST: VRF route, gateway can not be a local addr with device        [ O=
K ]

IPv6 route add / append tests
    TEST: Attempt to add duplicate route - gw                           [ O=
K ]
    TEST: Attempt to add duplicate route - dev only                     [ O=
K ]
    TEST: Attempt to add duplicate route - reject route                 [ O=
K ]
    TEST: Append nexthop to existing route - gw                         [ O=
K ]
    TEST: Add multipath route                                           [ O=
K ]
    TEST: Attempt to add duplicate multipath route                      [ O=
K ]
    TEST: Route add with different metrics                              [ O=
K ]
    TEST: Route delete with metric                                      [ O=
K ]

IPv6 route replace tests
    TEST: Single path with single path                                  [ O=
K ]
    TEST: Single path with multipath                                    [ O=
K ]
    TEST: Single path with single path via multipath attribute          [ O=
K ]
    TEST: Invalid nexthop                                               [ O=
K ]
    TEST: Single path - replace of non-existent route                   [ O=
K ]
    TEST: Multipath with multipath                                      [ O=
K ]
    TEST: Multipath with single path                                    [ O=
K ]
    TEST: Multipath with single path via multipath attribute            [ O=
K ]
    TEST: Multipath - invalid first nexthop                             [ O=
K ]
    TEST: Multipath - invalid second nexthop                            [ O=
K ]
    TEST: Multipath - replace of non-existent route                     [ O=
K ]

IPv4 route add / append tests
    TEST: Attempt to add duplicate route - gw                           [ O=
K ]
    TEST: Attempt to add duplicate route - dev only                     [ O=
K ]
    TEST: Attempt to add duplicate route - reject route                 [ O=
K ]
    TEST: Add new nexthop for existing prefix                           [ O=
K ]
    TEST: Append nexthop to existing route - gw                         [ O=
K ]
    TEST: Append nexthop to existing route - dev only                   [ O=
K ]
    TEST: Append nexthop to existing route - reject route               [ O=
K ]
    TEST: Append nexthop to existing reject route - gw                  [ O=
K ]
    TEST: Append nexthop to existing reject route - dev only            [ O=
K ]
    TEST: add multipath route                                           [ O=
K ]
    TEST: Attempt to add duplicate multipath route                      [ O=
K ]
    TEST: Route add with different metrics                              [ O=
K ]
    TEST: Route delete with metric                                      [ O=
K ]

IPv4 route replace tests
    TEST: Single path with single path                                  [ O=
K ]
    TEST: Single path with multipath                                    [ O=
K ]
    TEST: Single path with reject route                                 [ O=
K ]
    TEST: Single path with single path via multipath attribute          [ O=
K ]
    TEST: Invalid nexthop                                               [ O=
K ]
    TEST: Single path - replace of non-existent route                   [ O=
K ]
    TEST: Multipath with multipath                                      [ O=
K ]
    TEST: Multipath with single path                                    [ O=
K ]
    TEST: Multipath with single path via multipath attribute            [ O=
K ]
    TEST: Multipath with reject route                                   [ O=
K ]
    TEST: Multipath - invalid first nexthop                             [ O=
K ]
    TEST: Multipath - invalid second nexthop                            [ O=
K ]
    TEST: Multipath - replace of non-existent route                     [ O=
K ]

IPv6 prefix route tests
    TEST: Default metric                                                [ O=
K ]
    TEST: User specified metric on first device                         [ O=
K ]
    TEST: User specified metric on second device                        [ O=
K ]
    TEST: Delete of address on first device                             [ O=
K ]
    TEST: Modify metric of address                                      [ O=
K ]
Command line is not complete. Try option "help"
    TEST: Prefix route removed on link down                             [ O=
K ]
    TEST: Prefix route with metric on link up                           [ O=
K ]

IPv4 prefix route tests
    TEST: Default metric                                                [ O=
K ]
    TEST: User specified metric on first device                         [ O=
K ]
    TEST: User specified metric on second device                        [ O=
K ]
    TEST: Delete of address on first device                             [ O=
K ]
    TEST: Modify metric of address                                      [ O=
K ]
Command line is not complete. Try option "help"
    TEST: Prefix route removed on link down                             [ O=
K ]
    TEST: Prefix route with metric on link up                           [ O=
K ]

IPv6 routes with metrics
    TEST: Single path route with mtu metric                             [ O=
K ]
    TEST: Multipath route via 2 single routes with mtu metric on first  [ O=
K ]
    TEST: Multipath route via 2 single routes with mtu metric on 2nd    [ O=
K ]
    TEST:     MTU of second leg                                         [ O=
K ]
    TEST: Multipath route with mtu metric                               [ O=
K ]
    TEST: Using route with mtu metric                                   [ O=
K ]
    TEST: Invalid metric (fails metric_convert)                         [ O=
K ]

IPv4 route add / append tests
    TEST: Single path route with mtu metric                             [ O=
K ]
    TEST: Multipath route with mtu metric                               [ O=
K ]
    TEST: Using route with mtu metric                                   [ O=
K ]
    TEST: Invalid metric (fails metric_convert)                         [ O=
K ]

Tests passed: 141
Tests failed:   0
ok 1..13 selftests: net: fib_tests.sh [PASS]
selftests: net: fib-onlink-tests.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

########################################
Configuring interfaces
RTNETLINK answers: File exists
not ok 1..14 selftests: net: fib-onlink-tests.sh [FAIL]
selftests: net: pmtu.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
TEST: ipv4: PMTU exceptions                                         [ OK ]
connect: Cannot assign requested address
connect: Cannot assign requested address
TEST: ipv6: PMTU exceptions                                         [FAIL]
  PMTU exception wasn't created after exceeding MTU
TEST: IPv4 over vxlan4: PMTU exceptions                             [ OK ]
TEST: IPv6 over vxlan4: PMTU exceptions                             [ OK ]
TEST: IPv4 over vxlan6: PMTU exceptions                             [ OK ]
connect: Cannot assign requested address
TEST: IPv6 over vxlan6: PMTU exceptions                             [FAIL]
  PMTU exception wasn't created after exceeding link layer MTU on vxlan int=
erface
RTNETLINK answers: Operation not supported
  geneve4 not supported
TEST: IPv4 over geneve4: PMTU exceptions                            [SKIP]
RTNETLINK answers: Operation not supported
  geneve4 not supported
TEST: IPv6 over geneve4: PMTU exceptions                            [SKIP]
RTNETLINK answers: Operation not supported
  geneve6 not supported
TEST: IPv4 over geneve6: PMTU exceptions                            [SKIP]
RTNETLINK answers: Operation not supported
  geneve6 not supported
TEST: IPv6 over geneve6: PMTU exceptions                            [SKIP]
TEST: IPv4 over fou4: PMTU exceptions                               [ OK ]
TEST: IPv6 over fou4: PMTU exceptions                               [ OK ]
TEST: IPv4 over fou6: PMTU exceptions                               [FAIL]
  found PMTU exception with incorrect MTU 4944, expected 3944, after exceed=
ing link layer MTU on fou interface
TEST: IPv6 over fou6: PMTU exceptions                               [ OK ]
TEST: IPv4 over gue4: PMTU exceptions                               [ OK ]
TEST: IPv6 over gue4: PMTU exceptions                               [ OK ]
TEST: IPv4 over gue6: PMTU exceptions                               [ OK ]
TEST: IPv6 over gue6: PMTU exceptions                               [ OK ]
TEST: vti6: PMTU exceptions                                         [ OK ]
TEST: vti4: PMTU exceptions                                         [ OK ]
TEST: vti4: default MTU assignment                                  [ OK ]
TEST: vti6: default MTU assignment                                  [ OK ]
TEST: vti4: MTU setting on link creation                            [ OK ]
TEST: vti6: MTU setting on link creation                            [ OK ]
TEST: vti6: MTU changes on link changes                             [ OK ]
not ok 1..15 selftests: net: pmtu.sh [FAIL]
selftests: net: udpgso.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ipv4 cmsg
device mtu (orig): 65536
device mtu (test): 1500
ipv4 tx:1 gso:0=20
ipv4 tx:1472 gso:0=20
ipv4 tx:1473 gso:0 (fail)
ipv4 tx:1472 gso:1472 (fail)
ipv4 tx:1473 gso:1472=20
ipv4 tx:2944 gso:1472=20
ipv4 tx:2945 gso:1472=20
ipv4 tx:64768 gso:1472=20
ipv4 tx:65507 gso:1472=20
ipv4 tx:65508 gso:1472 (fail)
ipv4 tx:1 gso:1 (fail)
ipv4 tx:2 gso:1=20
ipv4 tx:5 gso:2=20
ipv4 tx:36 gso:1=20
ipv4 tx:37 gso:1 (fail)
OK
ipv4 setsockopt
device mtu (orig): 65536
device mtu (test): 1500
ipv4 tx:1 gso:0=20
ipv4 tx:1472 gso:0=20
ipv4 tx:1473 gso:0 (fail)
ipv4 tx:1472 gso:1472 (fail)
ipv4 tx:1473 gso:1472=20
ipv4 tx:2944 gso:1472=20
ipv4 tx:2945 gso:1472=20
ipv4 tx:64768 gso:1472=20
ipv4 tx:65507 gso:1472=20
ipv4 tx:65508 gso:1472 (fail)
ipv4 tx:1 gso:1 (fail)
ipv4 tx:2 gso:1=20
ipv4 tx:5 gso:2=20
ipv4 tx:36 gso:1=20
ipv4 tx:37 gso:1 (fail)
OK
ipv6 cmsg
device mtu (orig): 65536
device mtu (test): 1500
ipv6 tx:1 gso:0=20
ipv6 tx:1452 gso:0=20
ipv6 tx:1453 gso:0 (fail)
ipv6 tx:1452 gso:1452 (fail)
ipv6 tx:1453 gso:1452=20
ipv6 tx:2904 gso:1452=20
ipv6 tx:2905 gso:1452=20
ipv6 tx:65340 gso:1452=20
ipv6 tx:65527 gso:1452=20
ipv6 tx:65528 gso:1452 (fail)
ipv6 tx:1 gso:1 (fail)
ipv6 tx:2 gso:1=20
ipv6 tx:5 gso:2=20
ipv6 tx:16 gso:1=20
ipv6 tx:17 gso:1 (fail)
OK
ipv6 setsockopt
device mtu (orig): 65536
device mtu (test): 1500
ipv6 tx:1 gso:0=20
ipv6 tx:1452 gso:0=20
ipv6 tx:1453 gso:0 (fail)
ipv6 tx:1452 gso:1452 (fail)
ipv6 tx:1453 gso:1452=20
ipv6 tx:2904 gso:1452=20
ipv6 tx:2905 gso:1452=20
ipv6 tx:65340 gso:1452=20
ipv6 tx:65527 gso:1452=20
ipv6 tx:65528 gso:1452 (fail)
ipv6 tx:1 gso:1 (fail)
ipv6 tx:2 gso:1=20
ipv6 tx:5 gso:2=20
ipv6 tx:16 gso:1=20
ipv6 tx:17 gso:1 (fail)
OK
ipv4 connected
device mtu (orig): 65536
device mtu (test): 1600
route mtu (test): 1500
path mtu (read):  1500
ipv4 tx:1 gso:0=20
ipv4 tx:1472 gso:0=20
ipv4 tx:1473 gso:0 (fail)
ipv4 tx:1472 gso:1472 (fail)
ipv4 tx:1473 gso:1472=20
ipv4 tx:2944 gso:1472=20
ipv4 tx:2945 gso:1472=20
ipv4 tx:64768 gso:1472=20
ipv4 tx:65507 gso:1472=20
ipv4 tx:65508 gso:1472 (fail)
ipv4 tx:1 gso:1 (fail)
ipv4 tx:2 gso:1=20
ipv4 tx:5 gso:2=20
ipv4 tx:36 gso:1=20
ipv4 tx:37 gso:1 (fail)
OK
ipv4 msg_more
device mtu (orig): 65536
device mtu (test): 1500
ipv4 tx:1 gso:0=20
ipv4 tx:1472 gso:0=20
ipv4 tx:1473 gso:0 (fail)
ipv4 tx:1472 gso:1472 (fail)
ipv4 tx:1473 gso:1472=20
ipv4 tx:2944 gso:1472=20
ipv4 tx:2945 gso:1472=20
ipv4 tx:64768 gso:1472=20
ipv4 tx:65507 gso:1472=20
ipv4 tx:65508 gso:1472 (fail)
ipv4 tx:1 gso:1 (fail)
ipv4 tx:2 gso:1=20
ipv4 tx:5 gso:2=20
ipv4 tx:36 gso:1=20
ipv4 tx:37 gso:1 (fail)
OK
ipv6 msg_more
device mtu (orig): 65536
device mtu (test): 1500
ipv6 tx:1 gso:0=20
ipv6 tx:1452 gso:0=20
ipv6 tx:1453 gso:0 (fail)
ipv6 tx:1452 gso:1452 (fail)
ipv6 tx:1453 gso:1452=20
ipv6 tx:2904 gso:1452=20
ipv6 tx:2905 gso:1452=20
ipv6 tx:65340 gso:1452=20
ipv6 tx:65527 gso:1452=20
ipv6 tx:65528 gso:1452 (fail)
ipv6 tx:1 gso:1 (fail)
ipv6 tx:2 gso:1=20
ipv6 tx:5 gso:2=20
ipv6 tx:16 gso:1=20
ipv6 tx:17 gso:1 (fail)
OK
ok 1..16 selftests: net: udpgso.sh [PASS]
selftests: net: ip_defrag.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ipv4 defrag
seed =3D 1551500132
=2E/ip_defrag: recv: payload_len =3D 34609 max_frag_len =3D 8: Resource tem=
porarily unavailable
not ok 1..17 selftests: net: ip_defrag.sh [FAIL]
selftests: net: udpgso_bench.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ipv4
tcp
=2E/udpgso_bench_tx: connect: Connection refused
tcp zerocopy
tcp tx:   1500 MB/s    25453 calls/s  25453 msg/s
tcp rx:   1504 MB/s    14695 calls/s
tcp tx:   1291 MB/s    21913 calls/s  21913 msg/s
tcp rx:   1305 MB/s    13507 calls/s
tcp tx:   1840 MB/s    31212 calls/s  31212 msg/s
tcp rx:   1956 MB/s    19253 calls/s
udp
udp rx:    213 MB/s   152316 calls/s
udp tx:    308 MB/s   219702 calls/s   5231 msg/s
udp rx:    249 MB/s   177420 calls/s
udp tx:    313 MB/s   223398 calls/s   5319 msg/s
udp rx:    326 MB/s   232591 calls/s
udp tx:    378 MB/s   269766 calls/s   6423 msg/s
udp rx:    233 MB/s   166352 calls/s
udp gso
=2E/udpgso_bench_tx: sendmsg: Connection refused
udp gso zerocopy
udp rx:    331 MB/s   236225 calls/s
udp tx:    640 MB/s    10861 calls/s  10861 msg/s
udp tx:    633 MB/s    10740 calls/s  10740 msg/s
udp rx:    466 MB/s   332430 calls/s
udp tx:    632 MB/s    10722 calls/s  10722 msg/s
udp rx:    399 MB/s   284544 calls/s
ipv6
tcp
=2E/udpgso_bench_tx: connect: Connection refused
tcp zerocopy
tcp tx:   1212 MB/s    20562 calls/s  20562 msg/s
tcp rx:   1214 MB/s    12744 calls/s
tcp tx:   2046 MB/s    34710 calls/s  34710 msg/s
tcp rx:   2058 MB/s    26724 calls/s
tcp tx:   2491 MB/s    42264 calls/s  42264 msg/s
tcp rx:   2479 MB/s    29525 calls/s
udp
udp rx:    265 MB/s   193601 calls/s
udp tx:    297 MB/s   217193 calls/s   5051 msg/s
udp rx:    190 MB/s   139173 calls/s
udp tx:    240 MB/s   175569 calls/s   4083 msg/s
udp rx:    231 MB/s   168705 calls/s
udp tx:    266 MB/s   194661 calls/s   4527 msg/s
udp rx:    241 MB/s   175841 calls/s
udp gso
udp rx:    574 MB/s   419113 calls/s
udp tx:    729 MB/s    12368 calls/s  12368 msg/s
udp rx:    465 MB/s   339457 calls/s
udp tx:    780 MB/s    13230 calls/s  13230 msg/s
udp tx:    849 MB/s    14401 calls/s  14401 msg/s
udp rx:    435 MB/s   317461 calls/s
udp gso zerocopy
udp rx:    587 MB/s   428634 calls/s
udp tx:    639 MB/s    10844 calls/s  10844 msg/s
udp rx:    581 MB/s   424139 calls/s
udp tx:    600 MB/s    10178 calls/s  10178 msg/s
udp tx:    567 MB/s     9630 calls/s   9630 msg/s
udp rx:    507 MB/s   370134 calls/s
ok 1..18 selftests: net: udpgso_bench.sh [PASS]
selftests: net: fib_rule_tests.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

######################################################################
TEST SECTION: IPv4 fib rule
######################################################################

    TEST: rule4 check: oif dummy0                             [ OK ]

    TEST: rule4 del by pref: oif dummy0                       [ OK ]
RTNETLINK answers: No route to host

    TEST: rule4 check: from 192.51.100.3 iif dummy0           [FAIL]

    TEST: rule4 del by pref: from 192.51.100.3 iif dummy0     [ OK ]

    TEST: rule4 check: tos 0x10                               [ OK ]

    TEST: rule4 del by pref: tos 0x10                         [ OK ]

    TEST: rule4 check: fwmark 0x64                            [ OK ]

    TEST: rule4 del by pref: fwmark 0x64                      [ OK ]

    TEST: rule4 check: uidrange 100-100                       [ OK ]

    TEST: rule4 del by pref: uidrange 100-100                 [ OK ]

    TEST: rule4 check: sport 666 dport 777                    [ OK ]

    TEST: rule4 del by pref: sport 666 dport 777              [ OK ]

    TEST: rule4 check: ipproto tcp                            [ OK ]

    TEST: rule4 del by pref: ipproto tcp                      [ OK ]

    TEST: rule4 check: ipproto icmp                           [ OK ]

    TEST: rule4 del by pref: ipproto icmp                     [ OK ]

######################################################################
TEST SECTION: IPv6 fib rule
######################################################################

    TEST: rule6 check: oif dummy0                             [ OK ]

    TEST: rule6 del by pref: oif dummy0                       [ OK ]

    TEST: rule6 check: from 2001:db8:1::3 iif dummy0          [ OK ]

    TEST: rule6 del by pref: from 2001:db8:1::3 iif dummy0    [ OK ]

    TEST: rule6 check: tos 0x10                               [ OK ]

    TEST: rule6 del by pref: tos 0x10                         [ OK ]

    TEST: rule6 check: fwmark 0x64                            [ OK ]

    TEST: rule6 del by pref: fwmark 0x64                      [ OK ]

    TEST: rule6 check: uidrange 100-100                       [ OK ]

    TEST: rule6 del by pref: uidrange 100-100                 [ OK ]

    TEST: rule6 check: sport 666 dport 777                    [ OK ]

    TEST: rule6 del by pref: sport 666 dport 777              [ OK ]

    TEST: rule6 check: ipproto tcp                            [ OK ]

    TEST: rule6 del by pref: ipproto tcp                      [ OK ]

    TEST: rule6 check: ipproto icmp                           [ OK ]

    TEST: rule6 del by pref: ipproto icmp                     [ OK ]
ok 1..19 selftests: net: fib_rule_tests.sh [PASS]
selftests: net: msg_zerocopy.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ipv4 tcp -t 1
=2E/msg_zerocopy: setaffinity 2
=2E/msg_zerocopy: setaffinity 3
not ok 1..20 selftests: net: msg_zerocopy.sh [FAIL]
selftests: net: psock_snd.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
dgram
tx: 128
rx: 142
rx: 100
OK

dgram bind
tx: 128
rx: 142
rx: 100
OK

raw
tx: 142
rx: 142
rx: 100
OK

raw bind
tx: 142
rx: 142
rx: 100
OK

raw qdisc bypass
tx: 142
rx: 142
rx: 100
OK

raw vlan
tx: 146
rx: 100
OK

raw vnet hdr
tx: 152
rx: 142
rx: 100
OK

raw csum_off
tx: 152
rx: 142
rx: 100
OK

raw csum_off with bad offset (fails)
=2E/psock_snd: write: Invalid argument
raw min size
tx: 42
rx: 0
OK

raw mtu size
tx: 1514
rx: 1472
OK

raw mtu size + 1 (fails)
=2E/psock_snd: write: Message too long
raw vlan mtu size + 1 (fails)
=2E/psock_snd: write: Message too long
dgram mtu size
tx: 1500
rx: 1472
OK

dgram mtu size + 1 (fails)
=2E/psock_snd: write: Message too long
raw truncate hlen (fails: does not arrive)
tx: 14
=2E/psock_snd: recv: Resource temporarily unavailable
raw truncate hlen - 1 (fails: EINVAL)
=2E/psock_snd: write: Invalid argument
raw gso min size
tx: 1525
rx: 1473
OK

raw gso min size - 1 (fails)
tx: 1524
=2E/psock_snd: recv: Resource temporarily unavailable
raw gso max size
tx: 65559
rx: 65507
OK

raw gso max size + 1 (fails)
tx: 65560
=2E/psock_snd: recv: Resource temporarily unavailable
OK. All tests passed
ok 1..21 selftests: net: psock_snd.sh [PASS]
selftests: net: udpgro_bench.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Missing xdp_dummy helper. Build bpf selftest first
not ok 1..22 selftests: net: udpgro_bench.sh [FAIL]
selftests: net: udpgro.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Missing xdp_dummy helper. Build bpf selftest first
not ok 1..23 selftests: net: udpgro.sh [FAIL]
selftests: net: test_vxlan_under_vrf.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Checking HV connectivity                                           [ OK ]
Check VM connectivity through VXLAN (underlay in the default VRF)  [ OK ]
Check VM connectivity through VXLAN (underlay in a VRF)            [FAIL]
not ok 1..24 selftests: net: test_vxlan_under_vrf.sh [FAIL]
selftests: net: reuseport_addr_any.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
UDP IPv4 ... pass
UDP IPv6 ... pass
UDP IPv4 mapped to IPv6 ... pass
TCP IPv4 ... pass
TCP IPv6 ... pass
TCP IPv4 mapped to IPv6 ... pass
DCCP IPv4 ... pass
DCCP IPv6 ... pass
DCCP IPv4 mapped to IPv6 ... pass
SUCCESS
ok 1..25 selftests: net: reuseport_addr_any.sh [PASS]
selftests: net: test_vxlan_fdb_changelink.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
expected two remotes after fdb append	[ OK ]
expected two remotes after link set	[ OK ]
ok 1..26 selftests: net: test_vxlan_fdb_changelink.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471=
641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/net'

2019-03-02 12:16:06 make run_tests -C netfilter
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647=
1641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/netfilter'
TAP version 13
selftests: netfilter: nft_trans_stress.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
SKIP: Could not run test without nft tool
not ok 1..1 selftests: netfilter: nft_trans_stress.sh [SKIP]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471=
641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/netfilter'

2019-03-02 12:16:06 make run_tests -C nsfs
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647=
1641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/nsfs'
gcc -Wall -Werror    owner.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-99=
7dd96471641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/nsfs/owner
gcc -Wall -Werror    pidns.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-99=
7dd96471641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/nsfs/pidns
TAP version 13
selftests: nsfs: owner
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..1 selftests: nsfs: owner [PASS]
selftests: nsfs: pidns
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..2 selftests: nsfs: pidns [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471=
641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/nsfs'
ignored_by_lkp powerpc test
prctl test: not in Makefile
2019-03-02 12:16:06 make TARGETS=3Dprctl
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9=
6471641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/prctl'
Makefile:14: warning: overriding recipe for target 'clean'
=2E./lib.mk:137: warning: ignoring old recipe for target 'clean'
gcc     disable-tsc-ctxt-sw-stress-test.c   -o disable-tsc-ctxt-sw-stress-t=
est
gcc     disable-tsc-on-off-stress-test.c   -o disable-tsc-on-off-stress-test
gcc     disable-tsc-test.c   -o disable-tsc-test
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96=
471641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/prctl'

2019-03-02 12:16:07 make run_tests -C prctl
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647=
1641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/prctl'
Makefile:14: warning: overriding recipe for target 'clean'
=2E./lib.mk:137: warning: ignoring old recipe for target 'clean'
TAP version 13
selftests: prctl: disable-tsc-ctxt-sw-stress-test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[No further output means we're allright]
ok 1..1 selftests: prctl: disable-tsc-ctxt-sw-stress-test [PASS]
selftests: prctl: disable-tsc-on-off-stress-test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[No further output means we're allright]
ok 1..2 selftests: prctl: disable-tsc-on-off-stress-test [PASS]
selftests: prctl: disable-tsc-test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
rdtsc() =3D=3D 806481955101
prctl(PR_GET_TSC, &tsc_val); tsc_val =3D=3D PR_TSC_ENABLE
rdtsc() =3D=3D 806482186353
prctl(PR_SET_TSC, PR_TSC_ENABLE)
rdtsc() =3D=3D 806482221903
prctl(PR_SET_TSC, PR_TSC_SIGSEGV)
rdtsc() =3D=3D [ SIG_SEGV ]
prctl(PR_GET_TSC, &tsc_val); tsc_val =3D=3D PR_TSC_SIGSEGV
prctl(PR_SET_TSC, PR_TSC_ENABLE)
rdtsc() =3D=3D 806482358487
ok 1..3 selftests: prctl: disable-tsc-test [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471=
641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/prctl'

2019-03-02 12:16:27 make run_tests -C proc
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647=
1641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/proc'
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    fd-001-lookup.c  -o /us=
r/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f5e=
35/tools/testing/selftests/proc/fd-001-lookup
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    fd-002-posix-eq.c  -o /=
usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f=
5e35/tools/testing/selftests/proc/fd-002-posix-eq
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    fd-003-kthread.c  -o /u=
sr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f5=
e35/tools/testing/selftests/proc/fd-003-kthread
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-loadavg-001.c  -o =
/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0=
f5e35/tools/testing/selftests/proc/proc-loadavg-001
proc-loadavg-001.c:17:0: warning: "_GNU_SOURCE" redefined
 #define _GNU_SOURCE
=20
<command-line>:0:0: note: this is the location of the previous definition
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-self-map-files-001=
=2Ec  -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad5=
4284000d0f5e35/tools/testing/selftests/proc/proc-self-map-files-001
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-self-map-files-002=
=2Ec  -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad5=
4284000d0f5e35/tools/testing/selftests/proc/proc-self-map-files-002
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-self-syscall.c  -o=
 /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d=
0f5e35/tools/testing/selftests/proc/proc-self-syscall
proc-self-syscall.c:16:0: warning: "_GNU_SOURCE" redefined
 #define _GNU_SOURCE
=20
<command-line>:0:0: note: this is the location of the previous definition
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-self-wchan.c  -o /=
usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f=
5e35/tools/testing/selftests/proc/proc-self-wchan
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-uptime-001.c  -o /=
usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f=
5e35/tools/testing/selftests/proc/proc-uptime-001
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-uptime-002.c  -o /=
usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f=
5e35/tools/testing/selftests/proc/proc-uptime-002
proc-uptime-002.c:18:0: warning: "_GNU_SOURCE" redefined
 #define _GNU_SOURCE
=20
<command-line>:0:0: note: this is the location of the previous definition
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    read.c  -o /usr/src/per=
f_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f5e35/tools/=
testing/selftests/proc/read
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    self.c  -o /usr/src/per=
f_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f5e35/tools/=
testing/selftests/proc/self
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    thread-self.c  -o /usr/=
src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f5e35=
/tools/testing/selftests/proc/thread-self
TAP version 13
selftests: proc: fd-001-lookup
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..1 selftests: proc: fd-001-lookup [PASS]
selftests: proc: fd-002-posix-eq
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..2 selftests: proc: fd-002-posix-eq [PASS]
selftests: proc: fd-003-kthread
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..3 selftests: proc: fd-003-kthread [PASS]
selftests: proc: proc-loadavg-001
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..4 selftests: proc: proc-loadavg-001 [PASS]
selftests: proc: proc-self-map-files-001
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..5 selftests: proc: proc-self-map-files-001 [PASS]
selftests: proc: proc-self-map-files-002
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..6 selftests: proc: proc-self-map-files-002 [PASS]
selftests: proc: proc-self-syscall
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..7 selftests: proc: proc-self-syscall [PASS]
selftests: proc: proc-self-wchan
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..8 selftests: proc: proc-self-wchan [PASS]
selftests: proc: proc-uptime-001
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..9 selftests: proc: proc-uptime-001 [PASS]
selftests: proc: proc-uptime-002
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..10 selftests: proc: proc-uptime-002 [PASS]
selftests: proc: read
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..11 selftests: proc: read [PASS]
selftests: proc: self
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..12 selftests: proc: self [PASS]
selftests: proc: thread-self
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..13 selftests: proc: thread-self [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471=
641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/proc'

2019-03-02 12:16:33 make run_tests -C pstore
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647=
1641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/pstore'
TAP version 13
selftests: pstore: pstore_tests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D Pstore unit tests (pstore_tests) =3D=3D=3D
UUID=3D8057524d-7e21-4f7b-9c33-55d90daef23c
Checking pstore backend is registered ... ok
	backend=3Dramoops
	cmdline=3Dip=3D::::vm-snb-4G-1019::dhcp root=3D/dev/ram0 user=3Dlkp job=3D=
/lkp/jobs/scheduled/vm-snb-4G-1019/kernel_selftests-kselftests-02-debian-x8=
6_64-2018-04-03.cgz-997dd9647-20190302-13226-yk1d47-4.yaml ARCH=3Dx86_64 kc=
onfig=3Dx86_64-rhel-7.2 branch=3Dlinux-devel/devel-hourly-2019022709 commit=
=3D997dd96471641e147cb2c33ad54284000d0f5e35 BOOT_IMAGE=3D/pkg/linux/x86_64-=
rhel-7.2/gcc-7/997dd96471641e147cb2c33ad54284000d0f5e35/vmlinuz-5.0.0-rc3-0=
0325-g997dd964 erst_disable max_uptime=3D3600 RESULT_ROOT=3D/result/kernel_=
selftests/kselftests-02/vm-snb-4G/debian-x86_64-2018-04-03.cgz/x86_64-rhel-=
7.2/gcc-7/997dd96471641e147cb2c33ad54284000d0f5e35/4 LKP_SERVER=3Dinn debug=
 apic=3Ddebug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=3D100 net=
=2Eifnames=3D0 printk.devkmsg=3Don panic=3D-1 softlockup_panic=3D1 nmi_watc=
hdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 drbd.minor_co=
unt=3D8 systemd.log_level=3Derr ignore_loglevel console=3Dtty0 earlyprintk=
=3DttyS0,115200 console=3DttyS0,115200 vga=3Dnormal rw rcuperf.shutdown=3D0
Checking pstore console is registered ... ok
Checking /dev/pmsg0 exists ... ok
Writing unique string to /dev/pmsg0 ... ok
ok 1..1 selftests: pstore: pstore_tests [PASS]
selftests: pstore: pstore_post_reboot_tests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D Pstore unit tests (pstore_post_reboot_tests) =3D=3D=3D
UUID=3De3401c7a-d241-4caf-874d-a86e33421241
Checking pstore backend is registered ... ok
	backend=3Dramoops
	cmdline=3Dip=3D::::vm-snb-4G-1019::dhcp root=3D/dev/ram0 user=3Dlkp job=3D=
/lkp/jobs/scheduled/vm-snb-4G-1019/kernel_selftests-kselftests-02-debian-x8=
6_64-2018-04-03.cgz-997dd9647-20190302-13226-yk1d47-4.yaml ARCH=3Dx86_64 kc=
onfig=3Dx86_64-rhel-7.2 branch=3Dlinux-devel/devel-hourly-2019022709 commit=
=3D997dd96471641e147cb2c33ad54284000d0f5e35 BOOT_IMAGE=3D/pkg/linux/x86_64-=
rhel-7.2/gcc-7/997dd96471641e147cb2c33ad54284000d0f5e35/vmlinuz-5.0.0-rc3-0=
0325-g997dd964 erst_disable max_uptime=3D3600 RESULT_ROOT=3D/result/kernel_=
selftests/kselftests-02/vm-snb-4G/debian-x86_64-2018-04-03.cgz/x86_64-rhel-=
7.2/gcc-7/997dd96471641e147cb2c33ad54284000d0f5e35/4 LKP_SERVER=3Dinn debug=
 apic=3Ddebug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=3D100 net=
=2Eifnames=3D0 printk.devkmsg=3Don panic=3D-1 softlockup_panic=3D1 nmi_watc=
hdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 drbd.minor_co=
unt=3D8 systemd.log_level=3Derr ignore_loglevel console=3Dtty0 earlyprintk=
=3DttyS0,115200 console=3DttyS0,115200 vga=3Dnormal rw rcuperf.shutdown=3D0
pstore_crash_test has not been executed yet. we skip further tests.
not ok 1..2 selftests: pstore: pstore_post_reboot_tests [SKIP]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471=
641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/pstore'
ptp test: not in Makefile
2019-03-02 12:16:33 make TARGETS=3Dptp
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9=
6471641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/ptp'
Makefile:10: warning: overriding recipe for target 'clean'
=2E./lib.mk:137: warning: ignoring old recipe for target 'clean'
gcc -I../../../../usr/include/    testptp.c  -lrt -o testptp
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96=
471641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/ptp'

2019-03-02 12:16:33 make run_tests -C ptp
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647=
1641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/ptp'
Makefile:10: warning: overriding recipe for target 'clean'
=2E./lib.mk:137: warning: ignoring old recipe for target 'clean'
TAP version 13
selftests: ptp: testptp
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..1 selftests: ptp: testptp [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471=
641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/ptp'

2019-03-02 12:16:33 make run_tests -C ptrace
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647=
1641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/ptrace'
gcc -iquote../../../../include/uapi -Wall    peeksiginfo.c  -o /usr/src/per=
f_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f5e35/tools/=
testing/selftests/ptrace/peeksiginfo
TAP version 13
selftests: ptrace: peeksiginfo
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
PASS
ok 1..1 selftests: ptrace: peeksiginfo [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471=
641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/ptrace'

2019-03-02 12:16:34 make run_tests -C rtc
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647=
1641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/rtc'
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  rtctest.c  -o /usr/src=
/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f5e35/to=
ols/testing/selftests/rtc/rtctest
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  setdate.c  -o /usr/src=
/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f5e35/to=
ols/testing/selftests/rtc/setdate
TAP version 13
selftests: rtc: rtctest
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
rtctest.c:49:rtc.date_read:Current RTC date/time is 02/03/2019 12:16:35.
rtctest.c:137:rtc.alarm_alm_set:Alarm time now set to 12:16:44.
rtctest.c:198:rtc.alarm_wkalm_set:Alarm time now set to 02/03/2019 12:16:47.
[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] Running 5 tests from 2 test cases.
[ RUN      ] rtc.date_read
[       OK ] rtc.date_read
[ RUN      ] rtc.uie_read
[       OK ] rtc.uie_read
[ RUN      ] rtc.uie_select
[       OK ] rtc.uie_select
[ RUN      ] rtc.alarm_alm_set
[       OK ] rtc.alarm_alm_set
[ RUN      ] rtc.alarm_wkalm_set
[       OK ] rtc.alarm_wkalm_set
[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] 5 / 5 tests passed.
[  PASSED  ]
ok 1..1 selftests: rtc: rtctest [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471=
641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/rtc'

2019-03-02 12:16:46 make run_tests -C seccomp
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647=
1641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/seccomp'
gcc -Wl,-no-as-needed -Wall  -lpthread seccomp_bpf.c -o seccomp_bpf
gcc -Wl,-no-as-needed -Wall    seccomp_benchmark.c   -o seccomp_benchmark
TAP version 13
selftests: seccomp: seccomp_bpf
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] Running 72 tests from 1 test cases.
[ RUN      ] global.mode_strict_support
[       OK ] global.mode_strict_support
[ RUN      ] global.mode_strict_cannot_call_prctl
[       OK ] global.mode_strict_cannot_call_prctl
[ RUN      ] global.no_new_privs_support
[       OK ] global.no_new_privs_support
[ RUN      ] global.mode_filter_support
[       OK ] global.mode_filter_support
[ RUN      ] global.mode_filter_without_nnp
[       OK ] global.mode_filter_without_nnp
[ RUN      ] global.filter_size_limits
[       OK ] global.filter_size_limits
[ RUN      ] global.filter_chain_limits
[       OK ] global.filter_chain_limits
[ RUN      ] global.mode_filter_cannot_move_to_strict
[       OK ] global.mode_filter_cannot_move_to_strict
[ RUN      ] global.mode_filter_get_seccomp
[       OK ] global.mode_filter_get_seccomp
[ RUN      ] global.ALLOW_all
[       OK ] global.ALLOW_all
[ RUN      ] global.empty_prog
[       OK ] global.empty_prog
[ RUN      ] global.log_all
[       OK ] global.log_all
[ RUN      ] global.unknown_ret_is_kill_inside
[       OK ] global.unknown_ret_is_kill_inside
[ RUN      ] global.unknown_ret_is_kill_above_allow
[       OK ] global.unknown_ret_is_kill_above_allow
[ RUN      ] global.KILL_all
[       OK ] global.KILL_all
[ RUN      ] global.KILL_one
[       OK ] global.KILL_one
[ RUN      ] global.KILL_one_arg_one
[       OK ] global.KILL_one_arg_one
[ RUN      ] global.KILL_one_arg_six
[       OK ] global.KILL_one_arg_six
[ RUN      ] global.KILL_thread
[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] Running 72 tests from 1 test cases.
[ RUN      ] global.mode_strict_support
[       OK ] global.mode_strict_support
[ RUN      ] global.mode_strict_cannot_call_prctl
[       OK ] global.mode_strict_cannot_call_prctl
[ RUN      ] global.no_new_privs_support
[       OK ] global.no_new_privs_support
[ RUN      ] global.mode_filter_support
[       OK ] global.mode_filter_support
[ RUN      ] global.mode_filter_without_nnp
[       OK ] global.mode_filter_without_nnp
[ RUN      ] global.filter_size_limits
[       OK ] global.filter_size_limits
[ RUN      ] global.filter_chain_limits
[       OK ] global.filter_chain_limits
[ RUN      ] global.mode_filter_cannot_move_to_strict
[       OK ] global.mode_filter_cannot_move_to_strict
[ RUN      ] global.mode_filter_get_seccomp
[       OK ] global.mode_filter_get_seccomp
[ RUN      ] global.ALLOW_all
[       OK ] global.ALLOW_all
[ RUN      ] global.empty_prog
[       OK ] global.empty_prog
[ RUN      ] global.log_all
[       OK ] global.log_all
[ RUN      ] global.unknown_ret_is_kill_inside
[       OK ] global.unknown_ret_is_kill_inside
[ RUN      ] global.unknown_ret_is_kill_above_allow
[       OK ] global.unknown_ret_is_kill_above_allow
[ RUN      ] global.KILL_all
[       OK ] global.KILL_all
[ RUN      ] global.KILL_one
[       OK ] global.KILL_one
[ RUN      ] global.KILL_one_arg_one
[       OK ] global.KILL_one_arg_one
[ RUN      ] global.KILL_one_arg_six
[       OK ] global.KILL_one_arg_six
[ RUN      ] global.KILL_thread
[       OK ] global.KILL_thread
[ RUN      ] global.KILL_process
[       OK ] global.KILL_process
[ RUN      ] global.arg_out_of_range
[       OK ] global.arg_out_of_range
[ RUN      ] global.ERRNO_valid
[       OK ] global.ERRNO_valid
[ RUN      ] global.ERRNO_zero
[       OK ] global.ERRNO_zero
[ RUN      ] global.ERRNO_capped
[       OK ] global.ERRNO_capped
[ RUN      ] global.ERRNO_order
[       OK ] global.ERRNO_order
[ RUN      ] TRAP.dfl
[       OK ] TRAP.dfl
[ RUN      ] TRAP.ign
[       OK ] TRAP.ign
[ RUN      ] TRAP.handler
[       OK ] TRAP.handler
[ RUN      ] precedence.allow_ok
[       OK ] precedence.allow_ok
[ RUN      ] precedence.kill_is_highest
[       OK ] precedence.kill_is_highest
[ RUN      ] precedence.kill_is_highest_in_any_order
[       OK ] precedence.kill_is_highest_in_any_order
[ RUN      ] precedence.trap_is_second
[       OK ] precedence.trap_is_second
[ RUN      ] precedence.trap_is_second_in_any_order
[       OK ] precedence.trap_is_second_in_any_order
[ RUN      ] precedence.errno_is_third
[       OK ] precedence.errno_is_third
[ RUN      ] precedence.errno_is_third_in_any_order
[       OK ] precedence.errno_is_third_in_any_order
[ RUN      ] precedence.trace_is_fourth
[       OK ] precedence.trace_is_fourth
[ RUN      ] precedence.trace_is_fourth_in_any_order
[       OK ] precedence.trace_is_fourth_in_any_order
[ RUN      ] precedence.log_is_fifth
[       OK ] precedence.log_is_fifth
[ RUN      ] precedence.log_is_fifth_in_any_order
[       OK ] precedence.log_is_fifth_in_any_order
[ RUN      ] TRACE_poke.read_has_side_effects
[       OK ] TRACE_poke.read_has_side_effects
[ RUN      ] TRACE_poke.getpid_runs_normally
[       OK ] TRACE_poke.getpid_runs_normally
[ RUN      ] TRACE_syscall.ptrace_syscall_redirected
[       OK ] TRACE_syscall.ptrace_syscall_redirected
[ RUN      ] TRACE_syscall.ptrace_syscall_dropped
[       OK ] TRACE_syscall.ptrace_syscall_dropped
[ RUN      ] TRACE_syscall.syscall_allowed
[       OK ] TRACE_syscall.syscall_allowed
[ RUN      ] TRACE_syscall.syscall_redirected
[       OK ] TRACE_syscall.syscall_redirected
[ RUN      ] TRACE_syscall.syscall_dropped
[       OK ] TRACE_syscall.syscall_dropped
[ RUN      ] TRACE_syscall.skip_after_RET_TRACE
[       OK ] TRACE_syscall.skip_after_RET_TRACE
[ RUN      ] TRACE_syscall.kill_after_RET_TRACE
[       OK ] TRACE_syscall.kill_after_RET_TRACE
[ RUN      ] TRACE_syscall.skip_after_ptrace
[       OK ] TRACE_syscall.skip_after_ptrace
[ RUN      ] TRACE_syscall.kill_after_ptrace
[       OK ] TRACE_syscall.kill_after_ptrace
[ RUN      ] global.seccomp_syscall
[       OK ] global.seccomp_syscall
[ RUN      ] global.seccomp_syscall_mode_lock
[       OK ] global.seccomp_syscall_mode_lock
[ RUN      ] global.detect_seccomp_filter_flags
[       OK ] global.detect_seccomp_filter_flags
[ RUN      ] global.TSYNC_first
[       OK ] global.TSYNC_first
[ RUN      ] TSYNC.siblings_fail_prctl
[       OK ] TSYNC.siblings_fail_prctl
[ RUN      ] TSYNC.two_siblings_with_ancestor
[       OK ] TSYNC.two_siblings_with_ancestor
[ RUN      ] TSYNC.two_sibling_want_nnp
[       OK ] TSYNC.two_sibling_want_nnp
[ RUN      ] TSYNC.two_siblings_with_no_filter
[       OK ] TSYNC.two_siblings_with_no_filter
[ RUN      ] TSYNC.two_siblings_with_one_divergence
[       OK ] TSYNC.two_siblings_with_one_divergence
[ RUN      ] TSYNC.two_siblings_not_under_filter
[       OK ] TSYNC.two_siblings_not_under_filter
[ RUN      ] global.syscall_restart
[       OK ] global.syscall_restart
[ RUN      ] global.filter_flag_log
[       OK ] global.filter_flag_log
[ RUN      ] global.get_action_avail
[       OK ] global.get_action_avail
[ RUN      ] global.get_metadata
[       OK ] global.get_metadata
[ RUN      ] global.user_notification_basic
comp_syscall
[       OK ] global.seccomp_syscall
[ RUN      ] global.seccomp_syscall_mode_lock
[       OK ] global.seccomp_syscall_mode_lock
[ RUN      ] global.detect_seccomp_filter_flags
[       OK ] global.detect_seccomp_filter_flags
[ RUN      ] global.TSYNC_first
[       OK ] global.TSYNC_first
[ RUN      ] TSYNC.siblings_fail_prctl
[       OK ] TSYNC.siblings_fail_prctl
[ RUN      ] TSYNC.two_siblings_with_ancestor
[       OK ] TSYNC.two_siblings_with_ancestor
[ RUN      ] TSYNC.two_sibling_want_nnp
[       OK ] TSYNC.two_sibling_want_nnp
[ RUN      ] TSYNC.two_siblings_with_no_filter
[       OK ] TSYNC.two_siblings_with_no_filter
[ RUN      ] TSYNC.two_siblings_with_one_divergence
[       OK ] TSYNC.two_siblings_with_one_divergence
[ RUN      ] TSYNC.two_siblings_not_under_filter
[       OK ] TSYNC.two_siblings_not_under_filter
[ RUN      ] global.syscall_restart
[       OK ] global.syscall_restart
[ RUN      ] global.filter_flag_log
[       OK ] global.filter_flag_log
[ RUN      ] global.get_action_avail
[       OK ] global.get_action_avail
[ RUN      ] global.get_metadata
[       OK ] global.get_metadata
[ RUN      ] global.user_notification_basic
comp_syscall
[       OK ] global.seccomp_syscall
[ RUN      ] global.seccomp_syscall_mode_lock
[       OK ] global.seccomp_syscall_mode_lock
[ RUN      ] global.detect_seccomp_filter_flags
[       OK ] global.detect_seccomp_filter_flags
[ RUN      ] global.TSYNC_first
[       OK ] global.TSYNC_first
[ RUN      ] TSYNC.siblings_fail_prctl
[       OK ] TSYNC.siblings_fail_prctl
[ RUN      ] TSYNC.two_siblings_with_ancestor
[       OK ] TSYNC.two_siblings_with_ancestor
[ RUN      ] TSYNC.two_sibling_want_nnp
[       OK ] TSYNC.two_sibling_want_nnp
[ RUN      ] TSYNC.two_siblings_with_no_filter
[       OK ] TSYNC.two_siblings_with_no_filter
[ RUN      ] TSYNC.two_siblings_with_one_divergence
[       OK ] TSYNC.two_siblings_with_one_divergence
[ RUN      ] TSYNC.two_siblings_not_under_filter
[       OK ] TSYNC.two_siblings_not_under_filter
[ RUN      ] global.syscall_restart
[       OK ] global.syscall_restart
[ RUN      ] global.filter_flag_log
[       OK ] global.filter_flag_log
[ RUN      ] global.get_action_avail
[       OK ] global.get_action_avail
[ RUN      ] global.get_metadata
[       OK ] global.get_metadata
[ RUN      ] global.user_notification_basic
[       OK ] global.user_notification_basic
[ RUN      ] global.user_notification_kill_in_middle
[       OK ] global.user_notification_kill_in_middle
[ RUN      ] global.user_notification_signal
comp_syscall
[       OK ] global.seccomp_syscall
[ RUN      ] global.seccomp_syscall_mode_lock
[       OK ] global.seccomp_syscall_mode_lock
[ RUN      ] global.detect_seccomp_filter_flags
[       OK ] global.detect_seccomp_filter_flags
[ RUN      ] global.TSYNC_first
[       OK ] global.TSYNC_first
[ RUN      ] TSYNC.siblings_fail_prctl
[       OK ] TSYNC.siblings_fail_prctl
[ RUN      ] TSYNC.two_siblings_with_ancestor
[       OK ] TSYNC.two_siblings_with_ancestor
[ RUN      ] TSYNC.two_sibling_want_nnp
[       OK ] TSYNC.two_sibling_want_nnp
[ RUN      ] TSYNC.two_siblings_with_no_filter
[       OK ] TSYNC.two_siblings_with_no_filter
[ RUN      ] TSYNC.two_siblings_with_one_divergence
[       OK ] TSYNC.two_siblings_with_one_divergence
[ RUN      ] TSYNC.two_siblings_not_under_filter
[       OK ] TSYNC.two_siblings_not_under_filter
[ RUN      ] global.syscall_restart
[       OK ] global.syscall_restart
[ RUN      ] global.filter_flag_log
[       OK ] global.filter_flag_log
[ RUN      ] global.get_action_avail
[       OK ] global.get_action_avail
[ RUN      ] global.get_metadata
[       OK ] global.get_metadata
[ RUN      ] global.user_notification_basic
[       OK ] global.user_notification_basic
[ RUN      ] global.user_notification_kill_in_middle
[       OK ] global.user_notification_kill_in_middle
[ RUN      ] global.user_notification_signal
[       OK ] global.user_notification_signal
[ RUN      ] global.user_notification_closed_listener
comp_syscall
[       OK ] global.seccomp_syscall
[ RUN      ] global.seccomp_syscall_mode_lock
[       OK ] global.seccomp_syscall_mode_lock
[ RUN      ] global.detect_seccomp_filter_flags
[       OK ] global.detect_seccomp_filter_flags
[ RUN      ] global.TSYNC_first
[       OK ] global.TSYNC_first
[ RUN      ] TSYNC.siblings_fail_prctl
[       OK ] TSYNC.siblings_fail_prctl
[ RUN      ] TSYNC.two_siblings_with_ancestor
[       OK ] TSYNC.two_siblings_with_ancestor
[ RUN      ] TSYNC.two_sibling_want_nnp
[       OK ] TSYNC.two_sibling_want_nnp
[ RUN      ] TSYNC.two_siblings_with_no_filter
[       OK ] TSYNC.two_siblings_with_no_filter
[ RUN      ] TSYNC.two_siblings_with_one_divergence
[       OK ] TSYNC.two_siblings_with_one_divergence
[ RUN      ] TSYNC.two_siblings_not_under_filter
[       OK ] TSYNC.two_siblings_not_under_filter
[ RUN      ] global.syscall_restart
[       OK ] global.syscall_restart
[ RUN      ] global.filter_flag_log
[       OK ] global.filter_flag_log
[ RUN      ] global.get_action_avail
[       OK ] global.get_action_avail
[ RUN      ] global.get_metadata
[       OK ] global.get_metadata
[ RUN      ] global.user_notification_basic
[       OK ] global.user_notification_basic
[ RUN      ] global.user_notification_kill_in_middle
[       OK ] global.user_notification_kill_in_middle
[ RUN      ] global.user_notification_signal
[       OK ] global.user_notification_signal
[ RUN      ] global.user_notification_closed_listener
[       OK ] global.user_notification_closed_listener
[ RUN      ] global.user_notification_child_pid_ns
comp_syscall
[       OK ] global.seccomp_syscall
[ RUN      ] global.seccomp_syscall_mode_lock
[       OK ] global.seccomp_syscall_mode_lock
[ RUN      ] global.detect_seccomp_filter_flags
[       OK ] global.detect_seccomp_filter_flags
[ RUN      ] global.TSYNC_first
[       OK ] global.TSYNC_first
[ RUN      ] TSYNC.siblings_fail_prctl
[       OK ] TSYNC.siblings_fail_prctl
[ RUN      ] TSYNC.two_siblings_with_ancestor
[       OK ] TSYNC.two_siblings_with_ancestor
[ RUN      ] TSYNC.two_sibling_want_nnp
[       OK ] TSYNC.two_sibling_want_nnp
[ RUN      ] TSYNC.two_siblings_with_no_filter
[       OK ] TSYNC.two_siblings_with_no_filter
[ RUN      ] TSYNC.two_siblings_with_one_divergence
[       OK ] TSYNC.two_siblings_with_one_divergence
[ RUN      ] TSYNC.two_siblings_not_under_filter
[       OK ] TSYNC.two_siblings_not_under_filter
[ RUN      ] global.syscall_restart
[       OK ] global.syscall_restart
[ RUN      ] global.filter_flag_log
[       OK ] global.filter_flag_log
[ RUN      ] global.get_action_avail
[       OK ] global.get_action_avail
[ RUN      ] global.get_metadata
[       OK ] global.get_metadata
[ RUN      ] global.user_notification_basic
[       OK ] global.user_notification_basic
[ RUN      ] global.user_notification_kill_in_middle
[       OK ] global.user_notification_kill_in_middle
[ RUN      ] global.user_notification_signal
[       OK ] global.user_notification_signal
[ RUN      ] global.user_notification_closed_listener
[       OK ] global.user_notification_closed_listener
[ RUN      ] global.user_notification_child_pid_ns
[       OK ] global.user_notification_child_pid_ns
[ RUN      ] global.user_notification_sibling_pid_ns
comp_syscall
[       OK ] global.seccomp_syscall
[ RUN      ] global.seccomp_syscall_mode_lock
[       OK ] global.seccomp_syscall_mode_lock
[ RUN      ] global.detect_seccomp_filter_flags
[       OK ] global.detect_seccomp_filter_flags
[ RUN      ] global.TSYNC_first
[       OK ] global.TSYNC_first
[ RUN      ] TSYNC.siblings_fail_prctl
[       OK ] TSYNC.siblings_fail_prctl
[ RUN      ] TSYNC.two_siblings_with_ancestor
[       OK ] TSYNC.two_siblings_with_ancestor
[ RUN      ] TSYNC.two_sibling_want_nnp
[       OK ] TSYNC.two_sibling_want_nnp
[ RUN      ] TSYNC.two_siblings_with_no_filter
[       OK ] TSYNC.two_siblings_with_no_filter
[ RUN      ] TSYNC.two_siblings_with_one_divergence
[       OK ] TSYNC.two_siblings_with_one_divergence
[ RUN      ] TSYNC.two_siblings_not_under_filter
[       OK ] TSYNC.two_siblings_not_under_filter
[ RUN      ] global.syscall_restart
[       OK ] global.syscall_restart
[ RUN      ] global.filter_flag_log
[       OK ] global.filter_flag_log
[ RUN      ] global.get_action_avail
[       OK ] global.get_action_avail
[ RUN      ] global.get_metadata
[       OK ] global.get_metadata
[ RUN      ] global.user_notification_basic
[       OK ] global.user_notification_basic
[ RUN      ] global.user_notification_kill_in_middle
[       OK ] global.user_notification_kill_in_middle
[ RUN      ] global.user_notification_signal
[       OK ] global.user_notification_signal
[ RUN      ] global.user_notification_closed_listener
[       OK ] global.user_notification_closed_listener
[ RUN      ] global.user_notification_child_pid_ns
[       OK ] global.user_notification_child_pid_ns
[ RUN      ] global.user_notification_sibling_pid_ns
comp_syscall
[       OK ] global.seccomp_syscall
[ RUN      ] global.seccomp_syscall_mode_lock
[       OK ] global.seccomp_syscall_mode_lock
[ RUN      ] global.detect_seccomp_filter_flags
[       OK ] global.detect_seccomp_filter_flags
[ RUN      ] global.TSYNC_first
[       OK ] global.TSYNC_first
[ RUN      ] TSYNC.siblings_fail_prctl
[       OK ] TSYNC.siblings_fail_prctl
[ RUN      ] TSYNC.two_siblings_with_ancestor
[       OK ] TSYNC.two_siblings_with_ancestor
[ RUN      ] TSYNC.two_sibling_want_nnp
[       OK ] TSYNC.two_sibling_want_nnp
[ RUN      ] TSYNC.two_siblings_with_no_filter
[       OK ] TSYNC.two_siblings_with_no_filter
[ RUN      ] TSYNC.two_siblings_with_one_divergence
[       OK ] TSYNC.two_siblings_with_one_divergence
[ RUN      ] TSYNC.two_siblings_not_under_filter
[       OK ] TSYNC.two_siblings_not_under_filter
[ RUN      ] global.syscall_restart
[       OK ] global.syscall_restart
[ RUN      ] global.filter_flag_log
[       OK ] global.filter_flag_log
[ RUN      ] global.get_action_avail
[       OK ] global.get_action_avail
[ RUN      ] global.get_metadata
[       OK ] global.get_metadata
[ RUN      ] global.user_notification_basic
[       OK ] global.user_notification_basic
[ RUN      ] global.user_notification_kill_in_middle
[       OK ] global.user_notification_kill_in_middle
[ RUN      ] global.user_notification_signal
[       OK ] global.user_notification_signal
[ RUN      ] global.user_notification_closed_listener
[       OK ] global.user_notification_closed_listener
[ RUN      ] global.user_notification_child_pid_ns
[       OK ] global.user_notification_child_pid_ns
[ RUN      ] global.user_notification_sibling_pid_ns
comp_syscall
[       OK ] global.seccomp_syscall
[ RUN      ] global.seccomp_syscall_mode_lock
[       OK ] global.seccomp_syscall_mode_lock
[ RUN      ] global.detect_seccomp_filter_flags
[       OK ] global.detect_seccomp_filter_flags
[ RUN      ] global.TSYNC_first
[       OK ] global.TSYNC_first
[ RUN      ] TSYNC.siblings_fail_prctl
[       OK ] TSYNC.siblings_fail_prctl
[ RUN      ] TSYNC.two_siblings_with_ancestor
[       OK ] TSYNC.two_siblings_with_ancestor
[ RUN      ] TSYNC.two_sibling_want_nnp
[       OK ] TSYNC.two_sibling_want_nnp
[ RUN      ] TSYNC.two_siblings_with_no_filter
[       OK ] TSYNC.two_siblings_with_no_filter
[ RUN      ] TSYNC.two_siblings_with_one_divergence
[       OK ] TSYNC.two_siblings_with_one_divergence
[ RUN      ] TSYNC.two_siblings_not_under_filter
[       OK ] TSYNC.two_siblings_not_under_filter
[ RUN      ] global.syscall_restart
[       OK ] global.syscall_restart
[ RUN      ] global.filter_flag_log
[       OK ] global.filter_flag_log
[ RUN      ] global.get_action_avail
[       OK ] global.get_action_avail
[ RUN      ] global.get_metadata
[       OK ] global.get_metadata
[ RUN      ] global.user_notification_basic
[       OK ] global.user_notification_basic
[ RUN      ] global.user_notification_kill_in_middle
[       OK ] global.user_notification_kill_in_middle
[ RUN      ] global.user_notification_signal
[       OK ] global.user_notification_signal
[ RUN      ] global.user_notification_closed_listener
[       OK ] global.user_notification_closed_listener
[ RUN      ] global.user_notification_child_pid_ns
[       OK ] global.user_notification_child_pid_ns
[ RUN      ] global.user_notification_sibling_pid_ns
[       OK ] global.user_notification_sibling_pid_ns
[ RUN      ] global.user_notification_fault_recv
comp_syscall
[       OK ] global.seccomp_syscall
[ RUN      ] global.seccomp_syscall_mode_lock
[       OK ] global.seccomp_syscall_mode_lock
[ RUN      ] global.detect_seccomp_filter_flags
[       OK ] global.detect_seccomp_filter_flags
[ RUN      ] global.TSYNC_first
[       OK ] global.TSYNC_first
[ RUN      ] TSYNC.siblings_fail_prctl
[       OK ] TSYNC.siblings_fail_prctl
[ RUN      ] TSYNC.two_siblings_with_ancestor
[       OK ] TSYNC.two_siblings_with_ancestor
[ RUN      ] TSYNC.two_sibling_want_nnp
[       OK ] TSYNC.two_sibling_want_nnp
[ RUN      ] TSYNC.two_siblings_with_no_filter
[       OK ] TSYNC.two_siblings_with_no_filter
[ RUN      ] TSYNC.two_siblings_with_one_divergence
[       OK ] TSYNC.two_siblings_with_one_divergence
[ RUN      ] TSYNC.two_siblings_not_under_filter
[       OK ] TSYNC.two_siblings_not_under_filter
[ RUN      ] global.syscall_restart
[       OK ] global.syscall_restart
[ RUN      ] global.filter_flag_log
[       OK ] global.filter_flag_log
[ RUN      ] global.get_action_avail
[       OK ] global.get_action_avail
[ RUN      ] global.get_metadata
[       OK ] global.get_metadata
[ RUN      ] global.user_notification_basic
[       OK ] global.user_notification_basic
[ RUN      ] global.user_notification_kill_in_middle
[       OK ] global.user_notification_kill_in_middle
[ RUN      ] global.user_notification_signal
[       OK ] global.user_notification_signal
[ RUN      ] global.user_notification_closed_listener
[       OK ] global.user_notification_closed_listener
[ RUN      ] global.user_notification_child_pid_ns
[       OK ] global.user_notification_child_pid_ns
[ RUN      ] global.user_notification_sibling_pid_ns
[       OK ] global.user_notification_sibling_pid_ns
[ RUN      ] global.user_notification_fault_recv
[       OK ] global.user_notification_fault_recv
[ RUN      ] global.seccomp_get_notif_sizes
[       OK ] global.seccomp_get_notif_sizes
[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] 72 / 72 tests passed.
[  PASSED  ]
ok 1..1 selftests: seccomp: seccomp_bpf [PASS]
selftests: seccomp: seccomp_benchmark
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Calibrating reasonable sample size...
1551500209.437535461 - 1551500209.437518589 =3D 16872
1551500209.437588771 - 1551500209.437546726 =3D 42045
1551500209.437653943 - 1551500209.437591153 =3D 62790
1551500209.439971623 - 1551500209.437655789 =3D 2315834
1551500209.440228787 - 1551500209.439975220 =3D 253567
1551500209.440786341 - 1551500209.440231590 =3D 554751
1551500209.444106498 - 1551500209.440789172 =3D 3317326
1551500209.453270343 - 1551500209.444112283 =3D 9158060
1551500209.470761541 - 1551500209.453277760 =3D 17483781
1551500209.479659272 - 1551500209.470770205 =3D 8889067
1551500209.496162685 - 1551500209.479665982 =3D 16496703
1551500209.528526731 - 1551500209.496169999 =3D 32356732
1551500209.596893011 - 1551500209.528533528 =3D 68359483
1551500209.727380093 - 1551500209.596900390 =3D 130479703
1551500209.985417772 - 1551500209.727387460 =3D 258030312
1551500210.725693794 - 1551500209.985425040 =3D 740268754
1551500212.057371101 - 1551500210.725701579 =3D 1331669522
1551500214.133055315 - 1551500212.057379959 =3D 2075675356
1551500218.442781923 - 1551500214.133062951 =3D 4309718972
1551500227.647919681 - 1551500218.442789596 =3D 9205130085
Benchmarking 16777216 samples...
25.617469420 - 16.876335086 =3D 8741134334
getpid native: 521 ns
37.507159568 - 25.617567429 =3D 11889592139
getpid RET_ALLOW: 708 ns
Estimated seccomp overhead per syscall: 187 ns
ok 1..2 selftests: seccomp: seccomp_benchmark [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471=
641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/seccomp'

2019-03-02 12:17:29 make run_tests -C sigaltstack
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647=
1641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/sigaltstack'
gcc -Wall    sas.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647164=
1e147cb2c33ad54284000d0f5e35/tools/testing/selftests/sigaltstack/sas
TAP version 13
selftests: sigaltstack: sas
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1 Initial sigaltstack state was SS_DISABLE
# [RUN]	signal USR1
ok 2 sigaltstack is disabled in sighandler
# [RUN]	switched to user ctx
# [RUN]	signal USR2
# [OK]	Stack preserved
ok 3 sigaltstack is still SS_AUTODISARM after signal
Pass 3 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..3
ok 1..1 selftests: sigaltstack: sas [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471=
641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/sigaltstack'

2019-03-02 12:17:29 make run_tests -C size
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647=
1641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/size'
gcc -static -ffreestanding -nostartfiles -s    get_size.c  -o /usr/src/perf=
_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f5e35/tools/t=
esting/selftests/size/get_size
TAP version 13
selftests: size: get_size
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
TAP version 13
# Testing system size.
ok 1 get runtime memory use
# System runtime memory report (units in Kilobytes):
 ---
 Total:  4033180
 Free:   1877908
 Buffer: 0
 In use: 2155272
 ...
1..1
ok 1..1 selftests: size: get_size [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471=
641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/size'

2019-03-02 12:17:30 make run_tests -C sparc64
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647=
1641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/sparc64'
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471=
641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/sparc64'

2019-03-02 12:17:30 make run_tests -C splice
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647=
1641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/splice'
gcc     default_file_splice_read.c  -o /usr/src/perf_selftests-x86_64-rhel-=
7.2-997dd96471641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/splice=
/default_file_splice_read
TAP version 13
selftests: splice: default_file_splice_read.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..1 selftests: splice: default_file_splice_read.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471=
641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/splice'

2019-03-02 12:17:30 make run_tests -C static_keys
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647=
1641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/static_keys'
TAP version 13
selftests: static_keys: test_static_keys.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
static_key: ok
ok 1..1 selftests: static_keys: test_static_keys.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471=
641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/static_keys'

2019-03-02 12:17:30 make run_tests -C sync
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647=
1641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/sync'
gcc -c sync_alloc.c -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647164=
1e147cb2c33ad54284000d0f5e35/tools/testing/selftests/sync/sync_alloc.o
gcc -c sync_fence.c -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647164=
1e147cb2c33ad54284000d0f5e35/tools/testing/selftests/sync/sync_fence.o
gcc -c sync_merge.c -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647164=
1e147cb2c33ad54284000d0f5e35/tools/testing/selftests/sync/sync_merge.o
gcc -c sync_wait.c -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641=
e147cb2c33ad54284000d0f5e35/tools/testing/selftests/sync/sync_wait.o
gcc -c sync_stress_parallelism.c -o /usr/src/perf_selftests-x86_64-rhel-7.2=
-997dd96471641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/sync/sync=
_stress_parallelism.o
gcc -c sync_stress_consumer.c -o /usr/src/perf_selftests-x86_64-rhel-7.2-99=
7dd96471641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/sync/sync_st=
ress_consumer.o
gcc -c sync_stress_merge.c -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd=
96471641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/sync/sync_stres=
s_merge.o
gcc -c sync_test.c -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641=
e147cb2c33ad54284000d0f5e35/tools/testing/selftests/sync/sync_test.o -O2 -g=
 -std=3Dgnu89 -pthread -Wall -Wextra -I../../../../usr/include/
gcc -c sync.c -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147c=
b2c33ad54284000d0f5e35/tools/testing/selftests/sync/sync.o -O2 -g -std=3Dgn=
u89 -pthread -Wall -Wextra -I../../../../usr/include/
gcc -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad542=
84000d0f5e35/tools/testing/selftests/sync/sync_test /usr/src/perf_selftests=
-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f5e35/tools/testing/sel=
ftests/sync/sync_test.o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd964716=
41e147cb2c33ad54284000d0f5e35/tools/testing/selftests/sync/sync.o /usr/src/=
perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f5e35/too=
ls/testing/selftests/sync/sync_alloc.o /usr/src/perf_selftests-x86_64-rhel-=
7.2-997dd96471641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/sync/s=
ync_fence.o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33=
ad54284000d0f5e35/tools/testing/selftests/sync/sync_merge.o /usr/src/perf_s=
elftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f5e35/tools/tes=
ting/selftests/sync/sync_wait.o /usr/src/perf_selftests-x86_64-rhel-7.2-997=
dd96471641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/sync/sync_str=
ess_parallelism.o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147=
cb2c33ad54284000d0f5e35/tools/testing/selftests/sync/sync_stress_consumer.o=
 /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d=
0f5e35/tools/testing/selftests/sync/sync_stress_merge.o -O2 -g -std=3Dgnu89=
 -pthread -Wall -Wextra -I../../../../usr/include/ -pthread
TAP version 13
selftests: sync: sync_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
# [RUN]	Testing sync framework
ok 1 [RUN]	test_alloc_timeline
ok 2 [RUN]	test_alloc_fence
ok 3 [RUN]	test_alloc_fence_negative
ok 4 [RUN]	test_fence_one_timeline_wait
ok 5 [RUN]	test_fence_one_timeline_merge
ok 6 [RUN]	test_fence_merge_same_fence
ok 7 [RUN]	test_fence_multi_timeline_wait
ok 8 [RUN]	test_stress_two_threads_shared_timeline
ok 9 [RUN]	test_consumer_stress_multi_producer_single_consumer
ok 10 [RUN]	test_merge_stress_random_merge
Pass 10 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..10
ok 1..1 selftests: sync: sync_test [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471=
641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/sync'

2019-03-02 12:17:34 make run_tests -C sysctl
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647=
1641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/sysctl'
TAP version 13
selftests: sysctl: sysctl.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Checking production write strict setting ... ok
Sat Mar  2 12:17:34 CST 2019
Running test: sysctl_test_0001 - run #0
=3D=3D Testing sysctl behavior against /proc/sys/debug/test_sysctl/int_0001=
 =3D=3D
Writing test file ... ok
Checking sysctl is not set to test value ... ok
Writing sysctl from shell ... ok
Resetting sysctl to original value ... ok
Writing entire sysctl in single write ... ok
Writing middle of sysctl after synchronized seek ... ok
Writing beyond end of sysctl ... ok
Writing sysctl with multiple long writes ... ok
Checking ignoring spaces up to PAGE_SIZE works on write ...ok
Checking passing PAGE_SIZE of spaces fails on write ...ok
Sat Mar  2 12:17:35 CST 2019
Running test: sysctl_test_0002 - run #0
=3D=3D Testing sysctl behavior against /proc/sys/debug/test_sysctl/string_0=
001 =3D=3D
Writing test file ... ok
Checking sysctl is not set to test value ... ok
Writing sysctl from shell ... ok
Resetting sysctl to original value ... ok
Writing entire sysctl in single write ... ok
Writing middle of sysctl after synchronized seek ... ok
Writing beyond end of sysctl ... ok
Writing sysctl with multiple long writes ... ok
Writing entire sysctl in short writes ... ok
Writing middle of sysctl after unsynchronized seek ... ok
Checking sysctl maxlen is at least 65 ... ok
Checking sysctl keeps original string on overflow append ... ok
Checking sysctl stays NULL terminated on write ... ok
Checking sysctl stays NULL terminated on overwrite ... ok
Sat Mar  2 12:17:35 CST 2019
Running test: sysctl_test_0003 - run #0
=3D=3D Testing sysctl behavior against /proc/sys/debug/test_sysctl/int_0002=
 =3D=3D
Writing test file ... ok
Checking sysctl is not set to test value ... ok
Writing sysctl from shell ... ok
Resetting sysctl to original value ... ok
Writing entire sysctl in single write ... ok
Writing middle of sysctl after synchronized seek ... ok
Writing beyond end of sysctl ... ok
Writing sysctl with multiple long writes ... ok
Checking ignoring spaces up to PAGE_SIZE works on write ...ok
Checking passing PAGE_SIZE of spaces fails on write ...ok
Testing INT_MAX works ...ok
Testing INT_MAX + 1 will fail as expected...ok
Testing negative values will work as expected...ok
Sat Mar  2 12:17:35 CST 2019
Running test: sysctl_test_0004 - run #0
=3D=3D Testing sysctl behavior against /proc/sys/debug/test_sysctl/uint_000=
1 =3D=3D
Writing test file ... ok
Checking sysctl is not set to test value ... ok
Writing sysctl from shell ... ok
Resetting sysctl to original value ... ok
Writing entire sysctl in single write ... ok
Writing middle of sysctl after synchronized seek ... ok
Writing beyond end of sysctl ... ok
Writing sysctl with multiple long writes ... ok
Checking ignoring spaces up to PAGE_SIZE works on write ...ok
Checking passing PAGE_SIZE of spaces fails on write ...ok
Testing UINT_MAX works ...ok
Testing UINT_MAX + 1 will fail as expected...ok
Testing negative values will not work as expected ...ok
Sat Mar  2 12:17:35 CST 2019
Running test: sysctl_test_0005 - run #0
Testing array works as expected ... ok
Testing skipping trailing array elements works ... ok
Testing PAGE_SIZE limit on array works ... ok
Testing exceeding PAGE_SIZE limit fails as expected ... Files - and /proc/s=
ys/debug/test_sysctl/int_0003 differ
ok
Sat Mar  2 12:17:35 CST 2019
Running test: sysctl_test_0005 - run #1
Testing array works as expected ... ok
Testing skipping trailing array elements works ... ok
Testing PAGE_SIZE limit on array works ... ok
Testing exceeding PAGE_SIZE limit fails as expected ... Files - and /proc/s=
ys/debug/test_sysctl/int_0003 differ
ok
Sat Mar  2 12:17:35 CST 2019
Running test: sysctl_test_0005 - run #2
Testing array works as expected ... ok
Testing skipping trailing array elements works ... ok
Testing PAGE_SIZE limit on array works ... ok
Testing exceeding PAGE_SIZE limit fails as expected ... Files - and /proc/s=
ys/debug/test_sysctl/int_0003 differ
ok
ok 1..1 selftests: sysctl: sysctl.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471=
641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/sysctl'



To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> job-script # job-script is attached in th=
is email



Thanks,
Rong Chen


--Lb0e7rgc7IsuDeGj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.0.0-rc3-00325-g997dd964"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.0.0-rc3 Kernel Configuration
#

#
# Compiler: gcc-7 (Debian 7.4.0-5) 7.4.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=70400
CONFIG_CLANG_VERSION=0
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_RCU_NOCB_CPU=y
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_SWAP_ENABLED=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
# CONFIG_DEBUG_BLK_CGROUP is not set
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
# CONFIG_BPF_JIT_ALWAYS_ON is not set
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_MEMCG_SYSFS_ON is not set
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
# CONFIG_X86_RESCTRL is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_XXL=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
# CONFIG_QUEUED_LOCK_STAT is not set
CONFIG_XEN=y
CONFIG_XEN_PV=y
CONFIG_XEN_PV_SMP=y
CONFIG_XEN_DOM0=y
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_512GB=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=y
# CONFIG_PVH is not set
# CONFIG_KVM_DEBUG_FS is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_GART_IOMMU=y
# CONFIG_CALGARY_IOMMU is not set
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_I8K=m
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NODES_SPAN_OTHER_NODES=y
# CONFIG_NUMA_EMU is not set
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_MEMORY_PROBE=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
CONFIG_X86_INTEL_MPX=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_EFI=y
CONFIG_EFI_STUB=y
# CONFIG_EFI_MIXED is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
# CONFIG_KEXEC_FILE is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x1000000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
# CONFIG_LIVEPATCH is not set
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
CONFIG_PM_TEST_SUSPEND=y
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_NUMA=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=m
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
CONFIG_ACPI_APEI_ERST_DEBUG=y
# CONFIG_DPTF_POWER is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
# CONFIG_CPU_FREQ_GOV_SCHEDUTIL is not set

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
CONFIG_INTEL_IDLE=y

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# CONFIG_X86_SYSFB is not set

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_IA32_AOUT is not set
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_X86_DEV_DMA_OPS=y
CONFIG_HAVE_GENERIC_GUP=y

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_ISCSI_IBFT=m
# CONFIG_FW_CFG_SYSFS is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
# CONFIG_APPLE_PROPERTIES is not set
# CONFIG_RESET_ATTACK_MITIGATION is not set
CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y

#
# Tegra firmware driver
#
CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
CONFIG_KVM_AMD=m
CONFIG_KVM_MMU_AUDIT=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
# CONFIG_VHOST_VSOCK is not set
CONFIG_VHOST=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_OPROFILE=m
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_HAVE_RCU_TABLE_INVALIDATE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_CGROUP_IOLATENCY is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
# CONFIG_MEM_SOFT_DIRTY is not set
CONFIG_ZSWAP=y
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
# CONFIG_PGTABLE_MAPPING is not set
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_ZONE_DEVICE=y
CONFIG_ZONE_DEVICE=y
CONFIG_ARCH_HAS_HMM=y
CONFIG_DEV_PAGEMAP_OPS=y
# CONFIG_HMM_MIRROR is not set
# CONFIG_DEVICE_PRIVATE is not set
# CONFIG_DEVICE_PUBLIC is not set
CONFIG_FRAME_VECTOR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_DIAG=m
# CONFIG_TLS is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
CONFIG_NET_FOU=m
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
# CONFIG_INET_ESP_OFFLOAD is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_XFRM_MODE_TRANSPORT=m
CONFIG_INET_XFRM_MODE_TUNNEL=m
CONFIG_INET_XFRM_MODE_BEET=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
# CONFIG_TCP_CONG_NV is not set
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
# CONFIG_TCP_CONG_DCTCP is not set
# CONFIG_TCP_CONG_CDG is not set
# CONFIG_TCP_CONG_BBR is not set
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
# CONFIG_INET6_ESP_OFFLOAD is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_INET6_XFRM_MODE_TRANSPORT=m
CONFIG_INET6_XFRM_MODE_TUNNEL=m
CONFIG_INET6_XFRM_MODE_BEET=m
CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
# CONFIG_IPV6_GRE is not set
CONFIG_IPV6_FOU=m
CONFIG_IPV6_FOU_TUNNEL=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_SEG6_BPF=y
CONFIG_NETLABEL=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
CONFIG_NETFILTER_NETLINK_ACCT=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_COMMON=m
# CONFIG_NF_LOG_NETDEV is not set
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
# CONFIG_NF_CONNTRACK_TIMEOUT is not set
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=m
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
# CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
CONFIG_NF_NAT=m
CONFIG_NF_NAT_NEEDED=y
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
# CONFIG_NF_TABLES_SET is not set
# CONFIG_NF_TABLES_INET is not set
# CONFIG_NF_TABLES_NETDEV is not set
# CONFIG_NFT_NUMGEN is not set
CONFIG_NFT_CT=m
CONFIG_NFT_COUNTER=m
# CONFIG_NFT_CONNLIMIT is not set
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
# CONFIG_NFT_MASQ is not set
# CONFIG_NFT_REDIR is not set
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
# CONFIG_NFT_OBJREF is not set
# CONFIG_NFT_QUEUE is not set
# CONFIG_NFT_QUOTA is not set
# CONFIG_NFT_REJECT is not set
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
# CONFIG_NFT_XFRM is not set
# CONFIG_NFT_SOCKET is not set
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
CONFIG_NETFILTER_XT_TARGET_LED=m
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
# CONFIG_NETFILTER_XT_MATCH_CGROUP is not set
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
CONFIG_NETFILTER_XT_MATCH_L2TP=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
CONFIG_NETFILTER_XT_MATCH_NFACCT=m
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
# CONFIG_NETFILTER_XT_MATCH_SOCKET is not set
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
CONFIG_NETFILTER_XT_MATCH_TIME=m
CONFIG_NETFILTER_XT_MATCH_U32=m
CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
# CONFIG_IP_SET_HASH_IPMARK is not set
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
# CONFIG_IP_SET_HASH_IPMAC is not set
# CONFIG_IP_SET_HASH_MAC is not set
# CONFIG_IP_SET_HASH_NETPORTNET is not set
CONFIG_IP_SET_HASH_NET=m
# CONFIG_IP_SET_HASH_NETNET is not set
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
# CONFIG_IP_VS_FO is not set
# CONFIG_IP_VS_OVF is not set
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
# CONFIG_NF_SOCKET_IPV4 is not set
CONFIG_NF_TPROXY_IPV4=m
# CONFIG_NF_TABLES_IPV4 is not set
# CONFIG_NF_TABLES_ARP is not set
CONFIG_NF_DUP_IPV4=m
# CONFIG_NF_LOG_ARP is not set
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_IPV4=m
CONFIG_NF_NAT_MASQUERADE_IPV4=y
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_CLUSTERIP=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m

#
# IPv6: Netfilter Configuration
#
# CONFIG_NF_SOCKET_IPV6 is not set
CONFIG_NF_TPROXY_IPV6=m
# CONFIG_NF_TABLES_IPV6 is not set
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_NF_NAT_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
CONFIG_IP6_NF_TARGET_HL=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
# CONFIG_IP6_NF_NAT is not set
CONFIG_NF_DEFRAG_IPV6=m
# CONFIG_NF_TABLES_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
CONFIG_IP_DCCP=m
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=m
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=m
# CONFIG_NET_SCH_CAKE is not set
# CONFIG_NET_SCH_FQ is not set
# CONFIG_NET_SCH_HHF is not set
# CONFIG_NET_SCH_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
# CONFIG_NET_CLS_FLOWER is not set
# CONFIG_NET_CLS_MATCHALL is not set
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
CONFIG_NET_EMATCH_IPSET=m
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
# CONFIG_NET_ACT_SAMPLE is not set
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_VLAN is not set
# CONFIG_NET_ACT_BPF is not set
# CONFIG_NET_ACT_CONNMARK is not set
# CONFIG_NET_ACT_SKBMOD is not set
# CONFIG_NET_ACT_IFE is not set
# CONFIG_NET_ACT_TUNNEL_KEY is not set
CONFIG_NET_CLS_IND=y
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
# CONFIG_VIRTIO_VSOCKETS is not set
# CONFIG_HYPERV_VSOCKETS is not set
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=m
# CONFIG_MPLS_ROUTING is not set
CONFIG_NET_NSH=m
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
# CONFIG_CAN_SLCAN is not set
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_C_CAN is not set
# CONFIG_CAN_CC770 is not set
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
# CONFIG_CAN_SJA1000 is not set
# CONFIG_CAN_SOFTING is not set

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB2 is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# CONFIG_CAN_DEBUG_DEVICES is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_PRIV=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_LIB80211=m
# CONFIG_LIB80211_DEBUG is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
# CONFIG_NET_DEVLINK is not set
CONFIG_MAY_USE_DEVLINK=y
CONFIG_FAILOVER=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
# CONFIG_PCIEASPM_DEBUG is not set
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
# CONFIG_PCIE_DPC is not set
# CONFIG_PCIE_PTM is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
# CONFIG_PCI_PF_STUB is not set
# CONFIG_XEN_PCIDEV_FRONTEND is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
# CONFIG_PCI_HYPERV is not set
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
# CONFIG_HOTPLUG_PCI_SHPC is not set

#
# PCI controller drivers
#

#
# Cadence PCIe controllers support
#
# CONFIG_VMD is not set

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
CONFIG_PCCARD=y
# CONFIG_PCMCIA is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_YENTA_TOSHIBA=y
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=200
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8

#
# Bus devices
#
CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
# CONFIG_GNSS is not set
CONFIG_MTD=m
# CONFIG_MTD_TESTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
# CONFIG_MTD_AR7_PARTS is not set

#
# Partition parsers
#
# CONFIG_MTD_REDBOOT_PARTS is not set

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=m
CONFIG_MTD_BLOCK=m
# CONFIG_MTD_BLOCK_RO is not set
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
# CONFIG_SM_FTL is not set
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_SWAP is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
# CONFIG_MTD_PLATRAM is not set

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_DATAFLASH is not set
# CONFIG_MTD_MCHP23K256 is not set
# CONFIG_MTD_SST25L is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# CONFIG_MTD_ONENAND is not set
# CONFIG_MTD_NAND is not set
# CONFIG_MTD_SPI_NAND is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
# CONFIG_MTD_SPI_NOR is not set
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
# CONFIG_MTD_UBI_GLUEBI is not set
# CONFIG_MTD_UBI_BLOCK is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
CONFIG_BLK_DEV_FD=m
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=m
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SKD is not set
CONFIG_BLK_DEV_SX8=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
CONFIG_ATA_OVER_ETH=m
CONFIG_XEN_BLKDEV_FRONTEND=m
# CONFIG_XEN_BLKDEV_BACKEND is not set
CONFIG_VIRTIO_BLK=y
# CONFIG_VIRTIO_BLK_SCSI is not set
# CONFIG_BLK_DEV_RBD is not set
CONFIG_BLK_DEV_RSXX=m

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
CONFIG_NVME_TARGET_LOOP=m
# CONFIG_NVME_TARGET_FC is not set
# CONFIG_NVME_TARGET_TCP is not set

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_SGI_IOC4=m
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_USB_SWITCH_FSA9480 is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_PVPANIC=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
# CONFIG_INTEL_MEI_TXE is not set
CONFIG_VMWARE_VMCI=m

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#
# CONFIG_INTEL_MIC_BUS is not set

#
# SCIF Bus Driver
#
# CONFIG_SCIF_BUS is not set

#
# VOP Bus Driver
#
# CONFIG_VOP_BUS is not set

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
CONFIG_SCSI_LOWLEVEL=y
CONFIG_ISCSI_TCP=m
CONFIG_ISCSI_BOOT_SYSFS=m
CONFIG_SCSI_CXGB3_ISCSI=m
CONFIG_SCSI_CXGB4_ISCSI=m
CONFIG_SCSI_BNX2_ISCSI=m
CONFIG_SCSI_BNX2X_FCOE=m
CONFIG_BE2ISCSI=m
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
CONFIG_SCSI_HPSA=m
CONFIG_SCSI_3W_9XXX=m
CONFIG_SCSI_3W_SAS=m
# CONFIG_SCSI_ACARD is not set
CONFIG_SCSI_AACRAID=m
# CONFIG_SCSI_AIC7XXX is not set
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=4
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC94XX is not set
CONFIG_SCSI_MVSAS=m
# CONFIG_SCSI_MVSAS_DEBUG is not set
CONFIG_SCSI_MVSAS_TASKLET=y
CONFIG_SCSI_MVUMI=m
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
CONFIG_SCSI_ARCMSR=m
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=m
# CONFIG_SCSI_SMARTPQI is not set
CONFIG_SCSI_UFSHCD=m
CONFIG_SCSI_UFSHCD_PCI=m
# CONFIG_SCSI_UFS_DWC_TC_PCI is not set
# CONFIG_SCSI_UFSHCD_PLATFORM is not set
# CONFIG_SCSI_UFS_BSG is not set
CONFIG_SCSI_HPTIOP=m
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
CONFIG_VMWARE_PVSCSI=m
# CONFIG_XEN_SCSI_FRONTEND is not set
CONFIG_HYPERV_STORAGE=m
CONFIG_LIBFC=m
CONFIG_LIBFCOE=m
CONFIG_FCOE=m
CONFIG_FCOE_FNIC=m
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_GDTH is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
CONFIG_SCSI_INITIO=m
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
CONFIG_SCSI_STEX=m
# CONFIG_SCSI_SYM53C8XX_2 is not set
CONFIG_SCSI_IPR=m
CONFIG_SCSI_IPR_TRACE=y
CONFIG_SCSI_IPR_DUMP=y
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA_FC=m
# CONFIG_TCM_QLA2XXX is not set
CONFIG_SCSI_QLA_ISCSI=m
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
CONFIG_SCSI_PMCRAID=m
CONFIG_SCSI_PM8001=m
# CONFIG_SCSI_BFA_FC is not set
CONFIG_SCSI_VIRTIO=m
CONFIG_SCSI_CHELSIO_FCOE=m
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
CONFIG_SCSI_OSD_INITIATOR=m
CONFIG_SCSI_OSD_ULD=m
CONFIG_SCSI_OSD_DPRINT_SENSE=1
# CONFIG_SCSI_OSD_DEBUG is not set
CONFIG_ATA=m
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
CONFIG_SATA_ACARD_AHCI=m
CONFIG_SATA_SIL24=m
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
CONFIG_PDC_ADMA=m
CONFIG_SATA_QSTOR=m
CONFIG_SATA_SX4=m
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
CONFIG_SATA_MV=m
CONFIG_SATA_NV=m
CONFIG_SATA_PROMISE=m
CONFIG_SATA_SIL=m
CONFIG_SATA_SIS=m
CONFIG_SATA_SVW=m
CONFIG_SATA_ULI=m
CONFIG_SATA_VIA=m
CONFIG_SATA_VITESSE=m

#
# PATA SFF controllers with BMDMA
#
CONFIG_PATA_ALI=m
CONFIG_PATA_AMD=m
CONFIG_PATA_ARTOP=m
CONFIG_PATA_ATIIXP=m
CONFIG_PATA_ATP867X=m
CONFIG_PATA_CMD64X=m
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
CONFIG_PATA_HPT366=m
CONFIG_PATA_HPT37X=m
CONFIG_PATA_HPT3X2N=m
CONFIG_PATA_HPT3X3=m
# CONFIG_PATA_HPT3X3_DMA is not set
CONFIG_PATA_IT8213=m
CONFIG_PATA_IT821X=m
CONFIG_PATA_JMICRON=m
CONFIG_PATA_MARVELL=m
CONFIG_PATA_NETCELL=m
CONFIG_PATA_NINJA32=m
# CONFIG_PATA_NS87415 is not set
CONFIG_PATA_OLDPIIX=m
# CONFIG_PATA_OPTIDMA is not set
CONFIG_PATA_PDC2027X=m
CONFIG_PATA_PDC_OLD=m
# CONFIG_PATA_RADISYS is not set
CONFIG_PATA_RDC=m
CONFIG_PATA_SCH=m
CONFIG_PATA_SERVERWORKS=m
CONFIG_PATA_SIL680=m
CONFIG_PATA_SIS=m
CONFIG_PATA_TOSHIBA=m
# CONFIG_PATA_TRIFLEX is not set
CONFIG_PATA_VIA=m
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_PLATFORM is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
CONFIG_PATA_ACPI=m
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
# CONFIG_MD_CLUSTER is not set
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
# CONFIG_DM_WRITECACHE is not set
# CONFIG_DM_ERA is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
CONFIG_DM_DELAY=m
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
# CONFIG_DM_INTEGRITY is not set
# CONFIG_DM_ZONED is not set
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
# CONFIG_TCM_USER2 is not set
CONFIG_LOOPBACK_TARGET=m
CONFIG_TCM_FC=m
CONFIG_ISCSI_TARGET=m
# CONFIG_ISCSI_TARGET_CXGB4 is not set
# CONFIG_SBP_TARGET is not set
CONFIG_FUSION=y
CONFIG_FUSION_SPI=m
# CONFIG_FUSION_FC is not set
CONFIG_FUSION_SAS=m
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=m
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
CONFIG_BONDING=m
CONFIG_DUMMY=m
# CONFIG_EQUALIZER is not set
CONFIG_NET_FC=y
CONFIG_IFB=m
CONFIG_NET_TEAM=m
CONFIG_NET_TEAM_MODE_BROADCAST=m
CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
CONFIG_NET_TEAM_MODE_RANDOM=m
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=m
CONFIG_NET_TEAM_MODE_LOADBALANCE=m
CONFIG_MACVLAN=m
CONFIG_MACVTAP=m
# CONFIG_IPVLAN is not set
CONFIG_VXLAN=m
# CONFIG_GENEVE is not set
# CONFIG_GTP is not set
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
CONFIG_TAP=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=y
CONFIG_NLMON=m
CONFIG_NET_VRF=y
# CONFIG_ARCNET is not set
# CONFIG_ATM_DRIVERS is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
CONFIG_ATL2=m
CONFIG_ATL1=m
CONFIG_ATL1E=m
CONFIG_ATL1C=m
CONFIG_ALX=m
# CONFIG_NET_VENDOR_AURORA is not set
CONFIG_NET_VENDOR_BROADCOM=y
CONFIG_B44=m
CONFIG_B44_PCI_AUTOSELECT=y
CONFIG_B44_PCICORE_AUTOSELECT=y
CONFIG_B44_PCI=y
# CONFIG_BCMGENET is not set
CONFIG_BNX2=m
CONFIG_CNIC=m
CONFIG_TIGON3=y
CONFIG_TIGON3_HWMON=y
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
CONFIG_BNA=m
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
CONFIG_CHELSIO_T3=m
CONFIG_CHELSIO_T4=m
# CONFIG_CHELSIO_T4_DCB is not set
CONFIG_CHELSIO_T4VF=m
CONFIG_CHELSIO_LIB=m
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=m
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
CONFIG_DNET=m
CONFIG_NET_VENDOR_DEC=y
CONFIG_NET_TULIP=y
CONFIG_DE2104X=m
CONFIG_DE2104X_DSL=0
CONFIG_TULIP=y
# CONFIG_TULIP_MWI is not set
CONFIG_TULIP_MMIO=y
# CONFIG_TULIP_NAPI is not set
CONFIG_DE4X5=m
CONFIG_WINBOND_840=m
CONFIG_DM9102=m
CONFIG_ULI526X=m
CONFIG_PCMCIA_XIRCOM=m
# CONFIG_NET_VENDOR_DLINK is not set
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=m
CONFIG_BE2NET_HWMON=y
CONFIG_BE2NET_BE2=y
CONFIG_BE2NET_BE3=y
CONFIG_BE2NET_LANCER=y
CONFIG_BE2NET_SKYHAWK=y
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_NET_VENDOR_HP is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
# CONFIG_NET_VENDOR_I825XX is not set
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
CONFIG_IGBVF=m
CONFIG_IXGB=m
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
CONFIG_IXGBE_DCB=y
CONFIG_IXGBEVF=m
CONFIG_I40E=m
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
# CONFIG_IGC is not set
CONFIG_JME=m
CONFIG_NET_VENDOR_MARVELL=y
CONFIG_MVMDIO=m
CONFIG_SKGE=m
CONFIG_SKGE_DEBUG=y
CONFIG_SKGE_GENESIS=y
CONFIG_SKY2=m
CONFIG_SKY2_DEBUG=y
CONFIG_NET_VENDOR_MELLANOX=y
CONFIG_MLX4_EN=m
CONFIG_MLX4_EN_DCB=y
CONFIG_MLX4_CORE=m
CONFIG_MLX4_DEBUG=y
CONFIG_MLX4_CORE_GEN2=y
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
# CONFIG_NET_VENDOR_MICREL is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
CONFIG_MYRI10GE=m
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
CONFIG_NET_VENDOR_OKI=y
CONFIG_ETHOC=m
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
CONFIG_YELLOWFIN=m
CONFIG_NET_VENDOR_QLOGIC=y
CONFIG_QLA3XXX=m
CONFIG_QLCNIC=m
CONFIG_QLCNIC_SRIOV=y
CONFIG_QLCNIC_DCB=y
CONFIG_QLCNIC_HWMON=y
CONFIG_QLGE=m
CONFIG_NETXEN_NIC=m
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
# CONFIG_NET_VENDOR_RDC is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
CONFIG_8139CP=y
CONFIG_8139TOO=y
CONFIG_8139TOO_PIO=y
# CONFIG_8139TOO_TUNE_TWISTER is not set
CONFIG_8139TOO_8129=y
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
# CONFIG_NET_VENDOR_SEEQ is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
CONFIG_SFC=m
CONFIG_SFC_MTD=y
CONFIG_SFC_MCDI_MON=y
CONFIG_SFC_SRIOV=y
CONFIG_SFC_MCDI_LOGGING=y
# CONFIG_SFC_FALCON is not set
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
CONFIG_NET_VENDOR_SMSC=y
CONFIG_EPIC100=m
# CONFIG_SMSC911X is not set
CONFIG_SMSC9420=m
CONFIG_NET_VENDOR_SOCIONEXT=y
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
# CONFIG_NET_VENDOR_TI is not set
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
# CONFIG_MDIO_BCM_UNIMAC is not set
CONFIG_MDIO_BITBANG=m
# CONFIG_MDIO_GPIO is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=m
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_ASIX_PHY is not set
CONFIG_AT803X_PHY=m
# CONFIG_BCM7XXX_PHY is not set
CONFIG_BCM87XX_PHY=m
CONFIG_BCM_NET_PHYLIB=m
CONFIG_BROADCOM_PHY=m
CONFIG_CICADA_PHY=m
# CONFIG_CORTINA_PHY is not set
CONFIG_DAVICOM_PHY=m
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
CONFIG_FIXED_PHY=y
CONFIG_ICPLUS_PHY=m
# CONFIG_INTEL_XWAY_PHY is not set
CONFIG_LSI_ET1011C_PHY=m
CONFIG_LXT_PHY=m
CONFIG_MARVELL_PHY=m
# CONFIG_MARVELL_10G_PHY is not set
CONFIG_MICREL_PHY=m
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
CONFIG_NATIONAL_PHY=m
CONFIG_QSEMI_PHY=m
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
CONFIG_SMSC_PHY=m
CONFIG_STE10XP=m
# CONFIG_TERANETICS_PHY is not set
CONFIG_VITESSE_PHY=m
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_FILTER=y
CONFIG_PPP_MPPE=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPPOATM=m
CONFIG_PPPOE=m
CONFIG_PPTP=m
CONFIG_PPPOL2TP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_SLIP=m
CONFIG_SLHC=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
# CONFIG_SLIP_MODE_SLIP6 is not set
CONFIG_USB_NET_DRIVERS=y
CONFIG_USB_CATC=y
CONFIG_USB_KAWETH=y
CONFIG_USB_PEGASUS=y
CONFIG_USB_RTL8150=y
CONFIG_USB_RTL8152=m
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=m
CONFIG_USB_NET_CDCETHER=y
CONFIG_USB_NET_CDC_EEM=y
CONFIG_USB_NET_CDC_NCM=m
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
CONFIG_USB_NET_CDC_MBIM=m
CONFIG_USB_NET_DM9601=y
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
CONFIG_USB_NET_SMSC75XX=y
CONFIG_USB_NET_SMSC95XX=y
CONFIG_USB_NET_GL620A=y
CONFIG_USB_NET_NET1080=y
CONFIG_USB_NET_PLUSB=y
CONFIG_USB_NET_MCS7830=y
CONFIG_USB_NET_RNDIS_HOST=y
CONFIG_USB_NET_CDC_SUBSET_ENABLE=y
CONFIG_USB_NET_CDC_SUBSET=y
CONFIG_USB_ALI_M5632=y
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_KC2190=y
CONFIG_USB_NET_ZAURUS=y
CONFIG_USB_NET_CX82310_ETH=m
CONFIG_USB_NET_KALMIA=m
CONFIG_USB_NET_QMI_WWAN=m
CONFIG_USB_HSO=m
CONFIG_USB_NET_INT51X1=y
CONFIG_USB_IPHETH=y
CONFIG_USB_SIERRA_NET=y
CONFIG_USB_VL600=m
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT7601U is not set
# CONFIG_MT76x0U is not set
# CONFIG_MT76x0E is not set
# CONFIG_MT76x2E is not set
# CONFIG_MT76x2U is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
CONFIG_WAN=y
# CONFIG_LANMEDIA is not set
CONFIG_HDLC=m
CONFIG_HDLC_RAW=m
# CONFIG_HDLC_RAW_ETH is not set
CONFIG_HDLC_CISCO=m
CONFIG_HDLC_FR=m
CONFIG_HDLC_PPP=m

#
# X.25/LAPB support is disabled
#
# CONFIG_PCI200SYN is not set
# CONFIG_WANXL is not set
# CONFIG_PC300TOO is not set
# CONFIG_FARSYNC is not set
# CONFIG_DSCC4 is not set
CONFIG_DLCI=m
CONFIG_DLCI_MAX=8
# CONFIG_SBNI is not set
CONFIG_IEEE802154_DRIVERS=m
CONFIG_IEEE802154_FAKELB=m
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set
CONFIG_XEN_NETDEV_FRONTEND=m
# CONFIG_XEN_NETDEV_BACKEND is not set
CONFIG_VMXNET3=m
# CONFIG_FUJITSU_ES is not set
CONFIG_HYPERV_NET=m
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=y
CONFIG_ISDN=y
CONFIG_ISDN_I4L=m
CONFIG_ISDN_PPP=y
CONFIG_ISDN_PPP_VJ=y
CONFIG_ISDN_MPP=y
CONFIG_IPPP_FILTER=y
# CONFIG_ISDN_PPP_BSDCOMP is not set
CONFIG_ISDN_AUDIO=y
CONFIG_ISDN_TTY_FAX=y

#
# ISDN feature submodules
#
CONFIG_ISDN_DIVERSION=m

#
# ISDN4Linux hardware drivers
#

#
# Passive cards
#
# CONFIG_ISDN_DRV_HISAX is not set
CONFIG_ISDN_CAPI=m
# CONFIG_CAPI_TRACE is not set
CONFIG_ISDN_CAPI_CAPI20=m
CONFIG_ISDN_CAPI_MIDDLEWARE=y
CONFIG_ISDN_CAPI_CAPIDRV=m
# CONFIG_ISDN_CAPI_CAPIDRV_VERBOSE is not set

#
# CAPI hardware drivers
#
CONFIG_CAPI_AVM=y
CONFIG_ISDN_DRV_AVMB1_B1PCI=m
CONFIG_ISDN_DRV_AVMB1_B1PCIV4=y
CONFIG_ISDN_DRV_AVMB1_T1PCI=m
CONFIG_ISDN_DRV_AVMB1_C4=m
CONFIG_ISDN_DRV_GIGASET=m
CONFIG_GIGASET_CAPI=y
CONFIG_GIGASET_BASE=m
CONFIG_GIGASET_M105=m
CONFIG_GIGASET_M101=m
# CONFIG_GIGASET_DEBUG is not set
CONFIG_HYSDN=m
CONFIG_HYSDN_CAPI=y
CONFIG_MISDN=m
CONFIG_MISDN_DSP=m
CONFIG_MISDN_L1OIP=m

#
# mISDN hardware drivers
#
CONFIG_MISDN_HFCPCI=m
CONFIG_MISDN_HFCMULTI=m
CONFIG_MISDN_HFCUSB=m
CONFIG_MISDN_AVMFRITZ=m
CONFIG_MISDN_SPEEDFAX=m
CONFIG_MISDN_INFINEON=m
CONFIG_MISDN_W6692=m
CONFIG_MISDN_NETJET=m
CONFIG_MISDN_IPAC=m
CONFIG_MISDN_ISAR=m
CONFIG_ISDN_HDLC=m
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
CONFIG_MOUSE_APPLETOUCH=m
CONFIG_MOUSE_BCM5974=m
CONFIG_MOUSE_CYAPA=m
# CONFIG_MOUSE_ELAN_I2C is not set
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
CONFIG_MOUSE_SYNAPTICS_USB=m
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=m
CONFIG_TABLET_USB_AIPTEK=m
CONFIG_TABLET_USB_GTCO=m
# CONFIG_TABLET_USB_HANWANG is not set
CONFIG_TABLET_USB_KBTAB=m
# CONFIG_TABLET_USB_PEGASUS is not set
# CONFIG_TABLET_SERIAL_WACOM4 is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
# CONFIG_TOUCHSCREEN_ADS7846 is not set
# CONFIG_TOUCHSCREEN_AD7877 is not set
# CONFIG_TOUCHSCREEN_AD7879 is not set
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_BU21029 is not set
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
# CONFIG_TOUCHSCREEN_EETI is not set
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
# CONFIG_TOUCHSCREEN_EXC3000 is not set
# CONFIG_TOUCHSCREEN_FUJITSU is not set
# CONFIG_TOUCHSCREEN_GOODIX is not set
# CONFIG_TOUCHSCREEN_HIDEEP is not set
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_S6SY761 is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
# CONFIG_TOUCHSCREEN_ELAN is not set
# CONFIG_TOUCHSCREEN_ELO is not set
CONFIG_TOUCHSCREEN_WACOM_W8001=m
CONFIG_TOUCHSCREEN_WACOM_I2C=m
# CONFIG_TOUCHSCREEN_MAX11801 is not set
# CONFIG_TOUCHSCREEN_MCS5000 is not set
# CONFIG_TOUCHSCREEN_MMS114 is not set
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_INEXIO is not set
# CONFIG_TOUCHSCREEN_MK712 is not set
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
# CONFIG_TOUCHSCREEN_PIXCIR is not set
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
# CONFIG_TOUCHSCREEN_WM97XX is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
# CONFIG_TOUCHSCREEN_TSC2004 is not set
# CONFIG_TOUCHSCREEN_TSC2005 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
# CONFIG_TOUCHSCREEN_SILEAD is not set
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
# CONFIG_TOUCHSCREEN_ST1232 is not set
# CONFIG_TOUCHSCREEN_STMFTS is not set
# CONFIG_TOUCHSCREEN_SUR40 is not set
# CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
# CONFIG_TOUCHSCREEN_SX8654 is not set
# CONFIG_TOUCHSCREEN_TPS6507X is not set
# CONFIG_TOUCHSCREEN_ZET6223 is not set
# CONFIG_TOUCHSCREEN_ZFORCE is not set
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_MMA8450 is not set
CONFIG_INPUT_APANEL=m
# CONFIG_INPUT_GP2A is not set
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
CONFIG_INPUT_ATLAS_BTNS=m
CONFIG_INPUT_ATI_REMOTE2=m
CONFIG_INPUT_KEYSPAN_REMOTE=m
# CONFIG_INPUT_KXTJ9 is not set
CONFIG_INPUT_POWERMATE=m
CONFIG_INPUT_YEALINK=m
CONFIG_INPUT_CM109=m
CONFIG_INPUT_UINPUT=m
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_PWM_VIBRA is not set
# CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_CMA3000 is not set
CONFIG_INPUT_XEN_KBDDEV_FRONTEND=m
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
# CONFIG_SERIO_OLPC_APSP is not set
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
CONFIG_MOXA_INTELLIO=m
CONFIG_MOXA_SMARTIO=m
CONFIG_SYNCLINK=m
CONFIG_SYNCLINKMP=m
CONFIG_SYNCLINK_GT=m
CONFIG_NOZOMI=m
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
# CONFIG_TRACE_SINK is not set
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
# CONFIG_IPMI_SSIF is not set
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_NVRAM=y
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=8192
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C_ATMEL is not set
# CONFIG_TCG_TIS_I2C_INFINEON is not set
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_XEN is not set
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set
# CONFIG_RANDOM_TRUST_CPU is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PCI=m
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
CONFIG_I2C_PARPORT=m
CONFIG_I2C_PARPORT_LIGHT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=m
CONFIG_I2C_VIPERBOARD=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
CONFIG_SPI_DESIGNWARE=m
# CONFIG_SPI_DW_PCI is not set
# CONFIG_SPI_DW_MMIO is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_OC_TINY is not set
CONFIG_SPI_PXA2XX=m
CONFIG_SPI_PXA2XX_PCI=m
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_DP83640_PHY=m
CONFIG_PTP_1588_CLOCK_KVM=y
CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
# CONFIG_GPIO_ICH is not set
CONFIG_GPIO_LYNXPOINT=m
# CONFIG_GPIO_MB86S7X is not set
CONFIG_GPIO_MOCKUP=y
# CONFIG_GPIO_VX855 is not set

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set

#
# MFD GPIO expanders
#

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set

#
# USB GPIO expanders
#
# CONFIG_GPIO_VIPERBOARD is not set
# CONFIG_W1 is not set
# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_ISP1704 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LTC3651 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24190 is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_CHARGER_RT9455 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
CONFIG_SENSORS_ASC7621=m
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
# CONFIG_SENSORS_JC42 is not set
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_OCC_P8_I2C is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_IR35221 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_SHT15 is not set
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS1015=m
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_CLOCK_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
CONFIG_INTEL_PCH_THERMAL=m
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
# CONFIG_WATCHDOG_SYSFS is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
# CONFIG_INTEL_MEI_WDT is not set
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set
CONFIG_XEN_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=m

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
# CONFIG_BCMA_DRIVER_GPIO is not set
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_CROS_EC is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_VIPERBOARD=m
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_UCB1400_CORE is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
# CONFIG_MFD_SM501_GPIO is not set
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TPS68470 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
# CONFIG_LIRC is not set
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_XMP_DECODER=m
# CONFIG_IR_IMON_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_RC_ATI_REMOTE=m
CONFIG_IR_ENE=m
CONFIG_IR_IMON=m
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_MCEUSB=m
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
CONFIG_IR_REDRAT3=m
CONFIG_IR_STREAMZAP=m
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
CONFIG_IR_IGUANA=m
CONFIG_IR_TTUSBIR=m
CONFIG_RC_LOOPBACK=m
# CONFIG_IR_SERIAL is not set
# CONFIG_IR_SIR is not set
# CONFIG_RC_XBOX_DVD is not set
CONFIG_MEDIA_SUPPORT=m

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_CEC_SUPPORT is not set
# CONFIG_MEDIA_CONTROLLER is not set
CONFIG_VIDEO_DEV=m
CONFIG_VIDEO_V4L2=m
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEOBUF_GEN=m
CONFIG_VIDEOBUF_DMA_SG=m
CONFIG_VIDEOBUF_VMALLOC=m
CONFIG_DVB_CORE=m
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_TTPCI_EEPROM=m
CONFIG_DVB_MAX_ADAPTERS=8
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
CONFIG_USB_VIDEO_CLASS=m
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y
CONFIG_USB_GSPCA=m
CONFIG_USB_M5602=m
CONFIG_USB_STV06XX=m
CONFIG_USB_GL860=m
CONFIG_USB_GSPCA_BENQ=m
CONFIG_USB_GSPCA_CONEX=m
CONFIG_USB_GSPCA_CPIA1=m
# CONFIG_USB_GSPCA_DTCS033 is not set
CONFIG_USB_GSPCA_ETOMS=m
CONFIG_USB_GSPCA_FINEPIX=m
CONFIG_USB_GSPCA_JEILINJ=m
CONFIG_USB_GSPCA_JL2005BCD=m
# CONFIG_USB_GSPCA_KINECT is not set
CONFIG_USB_GSPCA_KONICA=m
CONFIG_USB_GSPCA_MARS=m
CONFIG_USB_GSPCA_MR97310A=m
CONFIG_USB_GSPCA_NW80X=m
CONFIG_USB_GSPCA_OV519=m
CONFIG_USB_GSPCA_OV534=m
CONFIG_USB_GSPCA_OV534_9=m
CONFIG_USB_GSPCA_PAC207=m
CONFIG_USB_GSPCA_PAC7302=m
CONFIG_USB_GSPCA_PAC7311=m
CONFIG_USB_GSPCA_SE401=m
CONFIG_USB_GSPCA_SN9C2028=m
CONFIG_USB_GSPCA_SN9C20X=m
CONFIG_USB_GSPCA_SONIXB=m
CONFIG_USB_GSPCA_SONIXJ=m
CONFIG_USB_GSPCA_SPCA500=m
CONFIG_USB_GSPCA_SPCA501=m
CONFIG_USB_GSPCA_SPCA505=m
CONFIG_USB_GSPCA_SPCA506=m
CONFIG_USB_GSPCA_SPCA508=m
CONFIG_USB_GSPCA_SPCA561=m
CONFIG_USB_GSPCA_SPCA1528=m
CONFIG_USB_GSPCA_SQ905=m
CONFIG_USB_GSPCA_SQ905C=m
CONFIG_USB_GSPCA_SQ930X=m
CONFIG_USB_GSPCA_STK014=m
# CONFIG_USB_GSPCA_STK1135 is not set
CONFIG_USB_GSPCA_STV0680=m
CONFIG_USB_GSPCA_SUNPLUS=m
CONFIG_USB_GSPCA_T613=m
CONFIG_USB_GSPCA_TOPRO=m
# CONFIG_USB_GSPCA_TOUPTEK is not set
CONFIG_USB_GSPCA_TV8532=m
CONFIG_USB_GSPCA_VC032X=m
CONFIG_USB_GSPCA_VICAM=m
CONFIG_USB_GSPCA_XIRLINK_CIT=m
CONFIG_USB_GSPCA_ZC3XX=m
CONFIG_USB_PWC=m
# CONFIG_USB_PWC_DEBUG is not set
CONFIG_USB_PWC_INPUT_EVDEV=y
# CONFIG_VIDEO_CPIA2 is not set
CONFIG_USB_ZR364XX=m
CONFIG_USB_STKWEBCAM=m
CONFIG_USB_S2255=m
# CONFIG_VIDEO_USBTV is not set

#
# Analog TV USB devices
#
CONFIG_VIDEO_PVRUSB2=m
CONFIG_VIDEO_PVRUSB2_SYSFS=y
CONFIG_VIDEO_PVRUSB2_DVB=y
# CONFIG_VIDEO_PVRUSB2_DEBUGIFC is not set
CONFIG_VIDEO_HDPVR=m
CONFIG_VIDEO_USBVISION=m
# CONFIG_VIDEO_STK1160_COMMON is not set
# CONFIG_VIDEO_GO7007 is not set

#
# Analog/digital TV USB devices
#
CONFIG_VIDEO_AU0828=m
CONFIG_VIDEO_AU0828_V4L2=y
# CONFIG_VIDEO_AU0828_RC is not set
CONFIG_VIDEO_CX231XX=m
CONFIG_VIDEO_CX231XX_RC=y
CONFIG_VIDEO_CX231XX_ALSA=m
CONFIG_VIDEO_CX231XX_DVB=m
CONFIG_VIDEO_TM6000=m
CONFIG_VIDEO_TM6000_ALSA=m
CONFIG_VIDEO_TM6000_DVB=m

#
# Digital TV USB devices
#
CONFIG_DVB_USB=m
# CONFIG_DVB_USB_DEBUG is not set
CONFIG_DVB_USB_DIB3000MC=m
CONFIG_DVB_USB_A800=m
CONFIG_DVB_USB_DIBUSB_MB=m
# CONFIG_DVB_USB_DIBUSB_MB_FAULTY is not set
CONFIG_DVB_USB_DIBUSB_MC=m
CONFIG_DVB_USB_DIB0700=m
CONFIG_DVB_USB_UMT_010=m
CONFIG_DVB_USB_CXUSB=m
CONFIG_DVB_USB_M920X=m
CONFIG_DVB_USB_DIGITV=m
CONFIG_DVB_USB_VP7045=m
CONFIG_DVB_USB_VP702X=m
CONFIG_DVB_USB_GP8PSK=m
CONFIG_DVB_USB_NOVA_T_USB2=m
CONFIG_DVB_USB_TTUSB2=m
CONFIG_DVB_USB_DTT200U=m
CONFIG_DVB_USB_OPERA1=m
CONFIG_DVB_USB_AF9005=m
CONFIG_DVB_USB_AF9005_REMOTE=m
CONFIG_DVB_USB_PCTV452E=m
CONFIG_DVB_USB_DW2102=m
CONFIG_DVB_USB_CINERGY_T2=m
CONFIG_DVB_USB_DTV5100=m
CONFIG_DVB_USB_AZ6027=m
CONFIG_DVB_USB_TECHNISAT_USB2=m
CONFIG_DVB_USB_V2=m
CONFIG_DVB_USB_AF9015=m
CONFIG_DVB_USB_AF9035=m
CONFIG_DVB_USB_ANYSEE=m
CONFIG_DVB_USB_AU6610=m
CONFIG_DVB_USB_AZ6007=m
CONFIG_DVB_USB_CE6230=m
CONFIG_DVB_USB_EC168=m
CONFIG_DVB_USB_GL861=m
CONFIG_DVB_USB_LME2510=m
CONFIG_DVB_USB_MXL111SF=m
CONFIG_DVB_USB_RTL28XXU=m
# CONFIG_DVB_USB_DVBSKY is not set
# CONFIG_DVB_USB_ZD1301 is not set
CONFIG_DVB_TTUSB_BUDGET=m
CONFIG_DVB_TTUSB_DEC=m
CONFIG_SMS_USB_DRV=m
CONFIG_DVB_B2C2_FLEXCOP_USB=m
# CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG is not set
# CONFIG_DVB_AS102 is not set

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=m
# CONFIG_VIDEO_EM28XX_V4L2 is not set
CONFIG_VIDEO_EM28XX_ALSA=m
CONFIG_VIDEO_EM28XX_DVB=m
CONFIG_VIDEO_EM28XX_RC=m
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
# CONFIG_VIDEO_MEYE is not set
# CONFIG_VIDEO_SOLO6X10 is not set
# CONFIG_VIDEO_TW5864 is not set
# CONFIG_VIDEO_TW68 is not set
# CONFIG_VIDEO_TW686X is not set

#
# Media capture/analog TV support
#
CONFIG_VIDEO_IVTV=m
# CONFIG_VIDEO_IVTV_DEPRECATED_IOCTLS is not set
# CONFIG_VIDEO_IVTV_ALSA is not set
CONFIG_VIDEO_FB_IVTV=m
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DT3155 is not set

#
# Media capture/analog/hybrid TV support
#
CONFIG_VIDEO_CX18=m
CONFIG_VIDEO_CX18_ALSA=m
CONFIG_VIDEO_CX23885=m
CONFIG_MEDIA_ALTERA_CI=m
# CONFIG_VIDEO_CX25821 is not set
CONFIG_VIDEO_CX88=m
CONFIG_VIDEO_CX88_ALSA=m
CONFIG_VIDEO_CX88_BLACKBIRD=m
CONFIG_VIDEO_CX88_DVB=m
CONFIG_VIDEO_CX88_ENABLE_VP3054=y
CONFIG_VIDEO_CX88_VP3054=m
CONFIG_VIDEO_CX88_MPEG=m
CONFIG_VIDEO_BT848=m
CONFIG_DVB_BT8XX=m
CONFIG_VIDEO_SAA7134=m
CONFIG_VIDEO_SAA7134_ALSA=m
CONFIG_VIDEO_SAA7134_RC=y
CONFIG_VIDEO_SAA7134_DVB=m
CONFIG_VIDEO_SAA7164=m

#
# Media digital TV PCI Adapters
#
CONFIG_DVB_AV7110_IR=y
CONFIG_DVB_AV7110=m
CONFIG_DVB_AV7110_OSD=y
CONFIG_DVB_BUDGET_CORE=m
CONFIG_DVB_BUDGET=m
CONFIG_DVB_BUDGET_CI=m
CONFIG_DVB_BUDGET_AV=m
CONFIG_DVB_BUDGET_PATCH=m
CONFIG_DVB_B2C2_FLEXCOP_PCI=m
# CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG is not set
CONFIG_DVB_PLUTO2=m
CONFIG_DVB_DM1105=m
CONFIG_DVB_PT1=m
# CONFIG_DVB_PT3 is not set
CONFIG_MANTIS_CORE=m
CONFIG_DVB_MANTIS=m
CONFIG_DVB_HOPPER=m
CONFIG_DVB_NGENE=m
CONFIG_DVB_DDBRIDGE=m
# CONFIG_DVB_DDBRIDGE_MSIENABLE is not set
# CONFIG_DVB_SMIPCIE is not set
# CONFIG_DVB_NETUP_UNIDVB is not set
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set

#
# Supported MMC/SDIO adapters
#
CONFIG_SMS_SDIO_DRV=m
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_TEA575X=m
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_USB_MR800 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_RAREMONO is not set
# CONFIG_USB_MA901 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set

#
# Texas Instruments WL128x FM driver (ST based)
#

#
# Supported FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=m
CONFIG_DVB_FIREDTV_INPUT=y
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_VIDEO_CX2341X=m
CONFIG_VIDEO_TVEEPROM=m
CONFIG_CYPRESS_FIRMWARE=m
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_VIDEOBUF2_DMA_SG=m
CONFIG_VIDEOBUF2_DVB=m
CONFIG_DVB_B2C2_FLEXCOP=m
CONFIG_VIDEO_SAA7146=m
CONFIG_VIDEO_SAA7146_VV=m
CONFIG_SMS_SIANO_MDTV=m
CONFIG_SMS_SIANO_RC=y
# CONFIG_SMS_SIANO_DEBUGFS is not set

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=m
CONFIG_VIDEO_TDA7432=m
CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_CS3308=m
CONFIG_VIDEO_CS5345=m
CONFIG_VIDEO_CS53L32A=m
CONFIG_VIDEO_WM8775=m
CONFIG_VIDEO_WM8739=m
CONFIG_VIDEO_VP27SMPX=m

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m

#
# Video decoders
#
CONFIG_VIDEO_SAA711X=m

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
CONFIG_VIDEO_CX25840=m

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=m

#
# Camera sensor devices
#

#
# Flash devices
#

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=m
CONFIG_VIDEO_UPD64083=m

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=m

#
# SDR tuner chips
#

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_M52790=m

#
# Sensors used on soc_camera driver
#

#
# Media SPI Adapters
#
# CONFIG_CXD2880_SPI_DRV is not set
CONFIG_MEDIA_TUNER=m
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_SI2168=m
CONFIG_DVB_GP8PSK_FE=m

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=m
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=m

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_SIS=y
CONFIG_AGP_VIA=y
CONFIG_INTEL_GTT=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DP_AUX_CHARDEV is not set
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
CONFIG_DRM_I2C_NXP_TDA998X=m
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#

#
# AMD Library routines
#
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
# CONFIG_DRM_I915_ALPHA_SUPPORT is not set
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
# CONFIG_DRM_I915_GVT is not set

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
CONFIG_DRM_VGEM=m
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
CONFIG_DRM_GMA500=m
CONFIG_DRM_GMA600=y
CONFIG_DRM_GMA3600=y
CONFIG_DRM_UDL=m
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_CIRRUS_QEMU=m
CONFIG_DRM_QXL=m
# CONFIG_DRM_BOCHS is not set
# CONFIG_DRM_VIRTIO_GPU is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# CONFIG_DRM_HISI_HIBMC is not set
# CONFIG_DRM_TINYDRM is not set
# CONFIG_DRM_XEN is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_XEN_FBDEV_FRONTEND is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_GENERIC is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_PM8941_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
# CONFIG_BACKLIGHT_LP855X is not set
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
# CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
CONFIG_SOUND=m
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=m
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_SEQUENCER_OSS=m
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_SEQ_MIDI_EMUL=m
CONFIG_SND_SEQ_VIRMIDI=m
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_OPL3_LIB_SEQ=m
CONFIG_SND_VX_LIB=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_DRIVERS=y
CONFIG_SND_PCSP=m
CONFIG_SND_DUMMY=m
CONFIG_SND_ALOOP=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
# CONFIG_SND_MTS64 is not set
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=m
# CONFIG_SND_PORTMAN2X4 is not set
CONFIG_SND_AC97_POWER_SAVE=y
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=5
CONFIG_SND_PCI=y
CONFIG_SND_AD1889=m
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
CONFIG_SND_ALI5451=m
CONFIG_SND_ASIHPI=m
CONFIG_SND_ATIIXP=m
CONFIG_SND_ATIIXP_MODEM=m
CONFIG_SND_AU8810=m
CONFIG_SND_AU8820=m
CONFIG_SND_AU8830=m
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
CONFIG_SND_BT87X=m
# CONFIG_SND_BT87X_OVERCLOCK is not set
CONFIG_SND_CA0106=m
CONFIG_SND_CMIPCI=m
CONFIG_SND_OXYGEN_LIB=m
CONFIG_SND_OXYGEN=m
# CONFIG_SND_CS4281 is not set
CONFIG_SND_CS46XX=m
CONFIG_SND_CS46XX_NEW_DSP=y
CONFIG_SND_CTXFI=m
CONFIG_SND_DARLA20=m
CONFIG_SND_GINA20=m
CONFIG_SND_LAYLA20=m
CONFIG_SND_DARLA24=m
CONFIG_SND_GINA24=m
CONFIG_SND_LAYLA24=m
CONFIG_SND_MONA=m
CONFIG_SND_MIA=m
CONFIG_SND_ECHO3G=m
CONFIG_SND_INDIGO=m
CONFIG_SND_INDIGOIO=m
CONFIG_SND_INDIGODJ=m
CONFIG_SND_INDIGOIOX=m
CONFIG_SND_INDIGODJX=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_EMU10K1_SEQ=m
CONFIG_SND_EMU10K1X=m
CONFIG_SND_ENS1370=m
CONFIG_SND_ENS1371=m
# CONFIG_SND_ES1938 is not set
CONFIG_SND_ES1968=m
CONFIG_SND_ES1968_INPUT=y
CONFIG_SND_ES1968_RADIO=y
# CONFIG_SND_FM801 is not set
CONFIG_SND_HDSP=m
CONFIG_SND_HDSPM=m
CONFIG_SND_ICE1712=m
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
CONFIG_SND_KORG1212=m
CONFIG_SND_LOLA=m
CONFIG_SND_LX6464ES=m
CONFIG_SND_MAESTRO3=m
CONFIG_SND_MAESTRO3_INPUT=y
CONFIG_SND_MIXART=m
# CONFIG_SND_NM256 is not set
CONFIG_SND_PCXHR=m
# CONFIG_SND_RIPTIDE is not set
CONFIG_SND_RME32=m
CONFIG_SND_RME96=m
CONFIG_SND_RME9652=m
# CONFIG_SND_SONICVIBES is not set
CONFIG_SND_TRIDENT=m
CONFIG_SND_VIA82XX=m
CONFIG_SND_VIA82XX_MODEM=m
CONFIG_SND_VIRTUOSO=m
CONFIG_SND_VX222=m
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_INTEL=m
CONFIG_SND_HDA_HWDEP=y
# CONFIG_SND_HDA_RECONFIG is not set
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=0
# CONFIG_SND_HDA_PATCH_LOADER is not set
CONFIG_SND_HDA_CODEC_REALTEK=m
CONFIG_SND_HDA_CODEC_ANALOG=m
CONFIG_SND_HDA_CODEC_SIGMATEL=m
CONFIG_SND_HDA_CODEC_VIA=m
CONFIG_SND_HDA_CODEC_HDMI=m
CONFIG_SND_HDA_CODEC_CIRRUS=m
CONFIG_SND_HDA_CODEC_CONEXANT=m
CONFIG_SND_HDA_CODEC_CA0110=m
CONFIG_SND_HDA_CODEC_CA0132=m
CONFIG_SND_HDA_CODEC_CA0132_DSP=y
CONFIG_SND_HDA_CODEC_CMEDIA=m
CONFIG_SND_HDA_CODEC_SI3054=m
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_PREALLOC_SIZE=512
CONFIG_SND_SPI=y
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=m
CONFIG_SND_USB_UA101=m
CONFIG_SND_USB_USX2Y=m
CONFIG_SND_USB_CAIAQ=m
CONFIG_SND_USB_CAIAQ_INPUT=y
CONFIG_SND_USB_US122L=m
CONFIG_SND_USB_6FIRE=m
# CONFIG_SND_USB_HIFACE is not set
# CONFIG_SND_BCD2000 is not set
# CONFIG_SND_USB_POD is not set
# CONFIG_SND_USB_PODHD is not set
# CONFIG_SND_USB_TONEPORT is not set
# CONFIG_SND_USB_VARIAX is not set
CONFIG_SND_FIREWIRE=y
CONFIG_SND_FIREWIRE_LIB=m
# CONFIG_SND_DICE is not set
# CONFIG_SND_OXFW is not set
CONFIG_SND_ISIGHT=m
# CONFIG_SND_FIREWORKS is not set
# CONFIG_SND_BEBOB is not set
# CONFIG_SND_FIREWIRE_DIGI00X is not set
# CONFIG_SND_FIREWIRE_TASCAM is not set
# CONFIG_SND_FIREWIRE_MOTU is not set
# CONFIG_SND_FIREFACE is not set
# CONFIG_SND_SOC is not set
CONFIG_SND_X86=y
# CONFIG_HDMI_LPE_AUDIO is not set
CONFIG_SND_SYNTH_EMUX=m
# CONFIG_SND_XEN_FRONTEND is not set
CONFIG_AC97_BUS=m

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=y
CONFIG_HID_APPLEIR=m
# CONFIG_HID_ASUS is not set
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=y
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
CONFIG_HID_PRODIKEYS=m
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CP2112 is not set
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=y
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
CONFIG_HID_HOLTEK=m
# CONFIG_HOLTEK_FF is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
CONFIG_HID_UCLOGIC=m
CONFIG_HID_WALTOP=m
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
# CONFIG_HID_ITE is not set
# CONFIG_HID_JABRA is not set
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
# CONFIG_HID_LENOVO is not set
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NTI is not set
CONFIG_HID_NTRIG=y
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
CONFIG_HID_ROCCAT=m
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
CONFIG_HID_SONY=m
# CONFIG_SONY_FF is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
# CONFIG_HID_RMI is not set
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
CONFIG_HID_WACOM=m
CONFIG_HID_WIIMOTE=m
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y

#
# I2C HID support
#
CONFIG_I2C_HID=m

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
# CONFIG_USB_LEDS_TRIGGER_USBPORT is not set
CONFIG_USB_MON=y
CONFIG_USB_WUSB=m
CONFIG_USB_WUSB_CBAF=m
# CONFIG_USB_WUSB_CBAF_DEBUG is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
CONFIG_USB_XHCI_PLATFORM=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_U132_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_WHCI_HCD is not set
CONFIG_USB_HWA_HCD=m
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_SSB is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_WDM=m
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=m
CONFIG_REALTEK_AUTOPM=y
CONFIG_USB_STORAGE_DATAFAB=m
CONFIG_USB_STORAGE_FREECOM=m
CONFIG_USB_STORAGE_ISD200=m
CONFIG_USB_STORAGE_USBAT=m
CONFIG_USB_STORAGE_SDDR09=m
CONFIG_USB_STORAGE_SDDR55=m
CONFIG_USB_STORAGE_JUMPSHOT=m
CONFIG_USB_STORAGE_ALAUDA=m
CONFIG_USB_STORAGE_ONETOUCH=m
CONFIG_USB_STORAGE_KARMA=m
CONFIG_USB_STORAGE_CYPRESS_ATACB=m
CONFIG_USB_STORAGE_ENE_UB6250=m
CONFIG_USB_UAS=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_MUSB_HDRC is not set
CONFIG_USB_DWC3=y
# CONFIG_USB_DWC3_HOST is not set
CONFIG_USB_DWC3_GADGET=y
# CONFIG_USB_DWC3_DUAL_ROLE is not set

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_PCI=y
CONFIG_USB_DWC3_HAPS=y
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_USS720=m
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_CONSOLE=y
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
CONFIG_USB_SERIAL_AIRCABLE=m
CONFIG_USB_SERIAL_ARK3116=m
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_CH341=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_CP210X=m
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
CONFIG_USB_SERIAL_IUU=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
# CONFIG_USB_SERIAL_METRO is not set
CONFIG_USB_SERIAL_MOS7720=m
CONFIG_USB_SERIAL_MOS7715_PARPORT=y
CONFIG_USB_SERIAL_MOS7840=m
# CONFIG_USB_SERIAL_MXUPORT is not set
CONFIG_USB_SERIAL_NAVMAN=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_OTI6858=m
CONFIG_USB_SERIAL_QCAUX=m
CONFIG_USB_SERIAL_QUALCOMM=m
CONFIG_USB_SERIAL_SPCP8X5=m
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_SIERRAWIRELESS=m
CONFIG_USB_SERIAL_SYMBOL=m
# CONFIG_USB_SERIAL_TI is not set
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_WWAN=m
CONFIG_USB_SERIAL_OPTION=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_SERIAL_OPTICON=m
CONFIG_USB_SERIAL_XSENS_MT=m
# CONFIG_USB_SERIAL_WISHBONE is not set
CONFIG_USB_SERIAL_SSU100=m
CONFIG_USB_SERIAL_QT2=m
# CONFIG_USB_SERIAL_UPD78F0730 is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=m
CONFIG_USB_SEVSEG=m
# CONFIG_USB_RIO500 is not set
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
CONFIG_USB_IDMOUSE=m
CONFIG_USB_FTDI_ELAN=m
CONFIG_USB_APPLEDISPLAY=m
CONFIG_USB_SISUSBVGA=m
CONFIG_USB_SISUSBVGA_CON=y
CONFIG_USB_LD=m
# CONFIG_USB_TRANCEVIBRATOR is not set
CONFIG_USB_IOWARRIOR=m
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=m
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=m
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=m
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
CONFIG_USB_ATM=m
CONFIG_USB_SPEEDTOUCH=m
CONFIG_USB_CXACRU=m
CONFIG_USB_UEAGLEATM=m
CONFIG_USB_XUSBATM=m

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=y
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
CONFIG_USB_GADGET=y
# CONFIG_USB_GADGET_DEBUG is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
# CONFIG_USB_GADGET_DEBUG_FS is not set
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2

#
# USB Peripheral Controller
#
# CONFIG_USB_FOTG210_UDC is not set
# CONFIG_USB_GR_UDC is not set
# CONFIG_USB_R8A66597 is not set
# CONFIG_USB_PXA27X is not set
# CONFIG_USB_MV_UDC is not set
# CONFIG_USB_MV_U3D is not set
# CONFIG_USB_M66592 is not set
# CONFIG_USB_BDC_UDC is not set
# CONFIG_USB_AMD5536UDC is not set
# CONFIG_USB_NET2272 is not set
# CONFIG_USB_NET2280 is not set
# CONFIG_USB_GOKU is not set
# CONFIG_USB_EG20T is not set
# CONFIG_USB_DUMMY_HCD is not set
CONFIG_USB_LIBCOMPOSITE=m
CONFIG_USB_F_MASS_STORAGE=m
# CONFIG_USB_CONFIGFS is not set
# CONFIG_USB_ZERO is not set
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_ETH is not set
# CONFIG_USB_G_NCM is not set
# CONFIG_USB_GADGETFS is not set
# CONFIG_USB_FUNCTIONFS is not set
CONFIG_USB_MASS_STORAGE=m
# CONFIG_USB_GADGET_TARGET is not set
# CONFIG_USB_G_SERIAL is not set
# CONFIG_USB_MIDI_GADGET is not set
# CONFIG_USB_G_PRINTER is not set
# CONFIG_USB_CDC_COMPOSITE is not set
# CONFIG_USB_G_ACM_MS is not set
# CONFIG_USB_G_MULTI is not set
# CONFIG_USB_G_HID is not set
# CONFIG_USB_G_DBGP is not set
# CONFIG_USB_G_WEBCAM is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLE_SWITCH is not set
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
CONFIG_UWB=m
CONFIG_UWB_HWA=m
CONFIG_UWB_WHCI=m
CONFIG_UWB_I1480U=m
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
CONFIG_MMC_TIFM_SD=m
# CONFIG_MMC_SPI is not set
CONFIG_MMC_CB710=m
CONFIG_MMC_VIA_SDMMC=m
CONFIG_MMC_VUB300=m
CONFIG_MMC_USHC=m
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=m
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
CONFIG_MEMSTICK_JMICRON_38X=m
CONFIG_MEMSTICK_R592=m
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=m
# CONFIG_LEDS_LP8501 is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_LT3593 is not set
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
# CONFIG_LEDS_MLXCPLD is not set
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
# CONFIG_LEDS_TRIGGER_GPIO is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
# CONFIG_EDAC_GHES is not set
CONFIG_EDAC_AMD64=m
# CONFIG_EDAC_AMD64_ERROR_INJECTION is not set
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
# CONFIG_EDAC_IE31200 is not set
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_PND2 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV8803 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
# CONFIG_RTC_DRV_RX4581 is not set
# CONFIG_RTC_DRV_RX6110 is not set
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
CONFIG_RTC_DRV_RV3029_HWMON=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
# CONFIG_INTEL_IDMA64 is not set
# CONFIG_INTEL_IOATDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
CONFIG_HSU_DMA=y

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
CONFIG_AUXDISPLAY=y
# CONFIG_HD44780 is not set
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_CFAG12864B=m
CONFIG_CFAG12864B_RATE=20
# CONFIG_IMG_ASCII_LCD is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
# CONFIG_UIO_HV_GENERIC is not set
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO=m
# CONFIG_VFIO_NOIOMMU is not set
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI_IGD=y
# CONFIG_VFIO_MDEV is not set
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
CONFIG_VIRTIO_BALLOON=y
# CONFIG_VIRTIO_INPUT is not set
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TSCPAGE=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m

#
# Xen driver support
#
CONFIG_XEN_BALLOON=y
# CONFIG_XEN_SELFBALLOONING is not set
# CONFIG_XEN_BALLOON_MEMORY_HOTPLUG is not set
CONFIG_XEN_SCRUB_PAGES_DEFAULT=y
CONFIG_XEN_DEV_EVTCHN=m
CONFIG_XEN_BACKEND=y
CONFIG_XENFS=m
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
CONFIG_XEN_TMEM=m
CONFIG_XEN_PCIDEV_BACKEND=m
# CONFIG_XEN_PVCALLS_FRONTEND is not set
# CONFIG_XEN_PVCALLS_BACKEND is not set
# CONFIG_XEN_SCSI_BACKEND is not set
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_ACPI_PROCESSOR=m
# CONFIG_XEN_MCE_LOG is not set
CONFIG_XEN_HAVE_PVMMU=y
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
CONFIG_XEN_SYMS=y
CONFIG_XEN_HAVE_VPMU=y
CONFIG_STAGING=y
# CONFIG_PRISM2_USB is not set
# CONFIG_COMEDI is not set
# CONFIG_RTL8192U is not set
CONFIG_RTLLIB=m
CONFIG_RTLLIB_CRYPTO_CCMP=m
CONFIG_RTLLIB_CRYPTO_TKIP=m
CONFIG_RTLLIB_CRYPTO_WEP=m
CONFIG_RTL8192E=m
# CONFIG_RTL8723BS is not set
CONFIG_R8712U=m
# CONFIG_R8188EU is not set
# CONFIG_R8822BE is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set
# CONFIG_FB_SM750 is not set
# CONFIG_FB_XGI is not set

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set
# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_LTE_GDM724X is not set
CONFIG_FIREWIRE_SERIAL=m
CONFIG_FWTTY_MAX_TOTAL_PORTS=64
CONFIG_FWTTY_MAX_CARD_PORTS=32
# CONFIG_GS_FPGABOOT is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_FB_TFT is not set
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
# CONFIG_MOST is not set
# CONFIG_KS7010 is not set
# CONFIG_GREYBUS is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_PI433 is not set
# CONFIG_MTK_MMC is not set

#
# Gasket devices
#
# CONFIG_STAGING_GASKET_FRAMEWORK is not set
# CONFIG_XIL_AXIS_FIFO is not set
# CONFIG_EROFS_FS is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACER_WMI=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACERHDF=m
# CONFIG_ALIENWARE_WMI is not set
CONFIG_ASUS_LAPTOP=m
CONFIG_DCDBAS=m
# CONFIG_DELL_SMBIOS is not set
CONFIG_DELL_WMI_AIO=m
# CONFIG_DELL_WMI_LED is not set
# CONFIG_DELL_SMO8800 is not set
# CONFIG_DELL_RBTN is not set
CONFIG_DELL_RBU=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
CONFIG_AMILO_RFKILL=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
# CONFIG_HP_WIRELESS is not set
CONFIG_HP_WMI=m
# CONFIG_LG_LAPTOP is not set
CONFIG_MSI_LAPTOP=m
CONFIG_PANASONIC_LAPTOP=m
CONFIG_COMPAL_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
CONFIG_IDEAPAD_LAPTOP=m
# CONFIG_SURFACE3_WMI is not set
CONFIG_THINKPAD_ACPI=m
CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=y
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
CONFIG_SENSORS_HDAPS=m
# CONFIG_INTEL_MENLOW is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_WMI=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_INTEL_WMI_THUNDERBOLT is not set
CONFIG_MSI_WMI=m
# CONFIG_PEAQ_WMI is not set
CONFIG_TOPSTAR_LAPTOP=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_PMC_CORE is not set
# CONFIG_IBM_RTL is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_MXM_WMI=m
CONFIG_INTEL_OAKTRAIL=m
CONFIG_SAMSUNG_Q10=m
CONFIG_APPLE_GMUX=m
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_MLX_PLATFORM is not set
# CONFIG_INTEL_TURBO_MAX_3 is not set
# CONFIG_I2C_MULTI_INSTANTIATE is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_HUAWEI_WMI is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_IOVA=y
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_IRQ_REMAP=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#

#
# Broadcom SoC drivers
#

#
# NXP/Freescale QorIQ SoC drivers
#

#
# i.MX SoC drivers
#

#
# Qualcomm SoC drivers
#
# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_GPIO is not set
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_MAX3355 is not set
# CONFIG_EXTCON_RT8973A is not set
# CONFIG_EXTCON_SM5502 is not set
# CONFIG_EXTCON_USB_GPIO is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
CONFIG_ARM_GIC_MAX_NR=1
# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set
# CONFIG_FMC is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_THUNDERBOLT is not set

#
# Android
#
# CONFIG_ANDROID is not set
CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_NVMEM=y

#
# HW tracing support
#
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
# CONFIG_INTEL_TH_ACPI is not set
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# CONFIG_FPGA is not set
CONFIG_PM_OPP=y
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_ENCRYPTION=y
CONFIG_EXT4_FS_ENCRYPTION=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
CONFIG_F2FS_FS_ENCRYPTION=y
# CONFIG_F2FS_IO_TRACE is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_UBIFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
# CONFIG_CRAMFS_MTD is not set
CONFIG_SQUASHFS=m
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
CONFIG_MINIX_FS=m
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EXOFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
# CONFIG_NFSD_SCSILAYOUT is not set
# CONFIG_NFSD_FLEXFILELAYOUT is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
# CONFIG_NFSD_FAULT_INJECTION is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_SUNRPC_DEBUG=y
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_ACL=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_9P_FS=y
CONFIG_9P_FS_POSIX_ACL=y
# CONFIG_9P_FS_SECURITY is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_COMPAT=y
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_BIG_KEYS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_WRITABLE_HOOKS=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=1
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE=1
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
# CONFIG_SECURITY_LOADPIN is not set
# CONFIG_SECURITY_YAMA is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
# CONFIG_IMA_ARCH_POLICY is not set
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_DEFAULT_SECURITY="selinux"
CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_RSA=y
# CONFIG_CRYPTO_DH is not set
# CONFIG_CRYPTO_ECDH is not set
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=m
CONFIG_CRYPTO_GLUE_HELPER_X86=m
CONFIG_CRYPTO_ENGINE=m

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128L is not set
# CONFIG_CRYPTO_AEGIS256 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
# CONFIG_CRYPTO_AEGIS128L_AESNI_SSE2 is not set
# CONFIG_CRYPTO_AEGIS256_AESNI_SSE2 is not set
# CONFIG_CRYPTO_MORUS640 is not set
# CONFIG_CRYPTO_MORUS640_SSE2 is not set
# CONFIG_CRYPTO_MORUS1280 is not set
# CONFIG_CRYPTO_MORUS1280_SSE2 is not set
# CONFIG_CRYPTO_MORUS1280_AVX2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=y
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=m
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=m
CONFIG_CRYPTO_SHA256_SSSE3=m
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_X86_64=y
CONFIG_CRYPTO_AES_NI_INTEL=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SALSA20=m
# CONFIG_CRYPTO_CHACHA20 is not set
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_CCP is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
# CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set
# CONFIG_CRYPTO_DEV_CHELSIO is not set
CONFIG_CRYPTO_DEV_VIRTIO=m
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
# CONFIG_SIGNED_PE_FILE_VERIFICATION is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
CONFIG_BITREVERSE=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=y
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=m
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_BTREE=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_SWIOTLB=y
CONFIG_SGL_ALLOC=y
CONFIG_IOMMU_HELPER=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_CORDIC=m
# CONFIG_DDR is not set
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_UACCESS_MCSAFE=y
CONFIG_SBITMAP=y
CONFIG_PRIME_NUMBERS=m
# CONFIG_STRING_SELFTEST is not set

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
CONFIG_DEBUG_RODATA_TEST=y
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_CC_HAS_KASAN_GENERIC=y
# CONFIG_KASAN is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
CONFIG_WW_MUTEX_SELFTEST=m
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PI_LIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
CONFIG_RCU_PERF_TEST=m
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAIL_MMC_REQUEST is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
# CONFIG_PREEMPTIRQ_EVENTS is not set
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
# CONFIG_HWLAT_TRACER is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_STACK_TRACER=y
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_FUNCTION_PROFILER=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
CONFIG_TRACING_MAP=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
CONFIG_TRACING_EVENTS_GPIO=y
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_DMA_API_DEBUG is not set
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_LKDTM=m
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
CONFIG_RBTREE_TEST=m
CONFIG_INTERVAL_TREE_TEST=m
CONFIG_PERCPU_TEST=m
CONFIG_ATOMIC64_SELFTEST=y
CONFIG_ASYNC_RAID6_TEST=m
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_KSTRTOX=m
CONFIG_TEST_PRINTF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_BITFIELD is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=m
CONFIG_TEST_SYSCTL=m
CONFIG_TEST_UDELAY=m
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_MEMTEST is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
# CONFIG_EARLY_PRINTK_EFI is not set
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
# CONFIG_X86_PTDUMP is not set
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
# CONFIG_IOMMU_DEBUG is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=0
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
CONFIG_OPTIMIZE_INLINING=y
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# CONFIG_UNWINDER_GUESS is not set

--Lb0e7rgc7IsuDeGj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='kernel_selftests'
	export testcase='kernel_selftests'
	export category='functional'
	export need_memory='3G'
	export need_cpu=2
	export kernel_cmdline='erst_disable'
	export job_origin='/lkp/lkp/.src-20190227-162913/allot/cyclic:vm:linux-devel:devel-hourly/vm-snb-4G/kernel_selftests.yaml'
	export queue_cmdline_keys='branch
commit'
	export queue='bisect'
	export testbox='vm-snb-4G-1019'
	export tbox_group='vm-snb-4G'
	export submit_id='5c79fad70b9a9333aa53a133'
	export job_file='/lkp/jobs/scheduled/vm-snb-4G-1019/kernel_selftests-kselftests-02-debian-x86_64-2018-04-03.cgz-997dd9647-20190302-13226-yk1d47-4.yaml'
	export id='12a2045417dcb73daf6b1f7ab0a4a488df39c454'
	export queuer_version='/lkp/lkp/.src-20190228-164855'
	export need_kernel_headers=true
	export need_kernel_selftests=true
	export need_kconfig='CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_TEST_FIRMWARE
CONFIG_TEST_USER_COPY
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT
CONFIG_MEMORY_HOTPLUG_SPARSE=y
CONFIG_NOTIFIER_ERROR_INJECTION
CONFIG_FTRACE=y
CONFIG_TEST_BITMAP
CONFIG_TEST_PRINTF
CONFIG_TEST_STATIC_KEYS
CONFIG_BPF_SYSCALL=y
CONFIG_NET_CLS_BPF=m
CONFIG_BPF_EVENTS=y
CONFIG_TEST_BPF=m
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HIST_TRIGGERS=y
CONFIG_EMBEDDED=y
CONFIG_GPIO_MOCKUP=y
CONFIG_USERFAULTFD=y
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_MISC_FILESYSTEMS=y
CONFIG_PSTORE=y
CONFIG_PSTORE_PMSG=y
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_RAM=m
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_EXPERT=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_EFIVAR_FS
CONFIG_TEST_KMOD=m
CONFIG_TEST_LKM=m
CONFIG_XFS_FS=m
CONFIG_TUN=m
CONFIG_BTRFS_FS=m
CONFIG_TEST_SYSCTL=m
CONFIG_BPF_STREAM_PARSER=y
CONFIG_CGROUP_BPF=y
CONFIG_IPV6_MULTIPLE_TABLES=y
CONFIG_NET_L3_MASTER_DEV=y
CONFIG_NET_VRF=y
CONFIG_NET_FOU=m
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_MACSEC=y
CONFIG_X86_INTEL_MPX=y
CONFIG_RC_LOOPBACK
CONFIG_IPV6_SEG6_LWTUNNEL=y
CONFIG_LWTUNNEL=y
CONFIG_WW_MUTEX_SELFTEST=m
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_KVM_GUEST=y'
	export commit='997dd96471641e147cb2c33ad54284000d0f5e35'
	export ssh_base_port=23032
	export kconfig='x86_64-rhel-7.2'
	export compiler='gcc-7'
	export rootfs='debian-x86_64-2018-04-03.cgz'
	export enqueue_time='2019-03-02 11:39:03 +0800'
	export _id='5c79fc400b9a9333aa53a137'
	export _rt='/result/kernel_selftests/kselftests-02/vm-snb-4G/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.2/gcc-7/997dd96471641e147cb2c33ad54284000d0f5e35'
	export user='lkp'
	export head_commit='c84bb22363a1437fbea4ad9e1dc3cec34d672113'
	export base_commit='5908e6b738e3357af42c10e1183753c70a0117a9'
	export branch='linux-devel/devel-hourly-2019022709'
	export result_root='/result/kernel_selftests/kselftests-02/vm-snb-4G/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.2/gcc-7/997dd96471641e147cb2c33ad54284000d0f5e35/4'
	export scheduler_version='/lkp/lkp/.src-20190301-223747'
	export LKP_SERVER='inn'
	export max_uptime=3600
	export initrd='/osimage/debian/debian-x86_64-2018-04-03.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/vm-snb-4G-1019/kernel_selftests-kselftests-02-debian-x86_64-2018-04-03.cgz-997dd9647-20190302-13226-yk1d47-4.yaml
ARCH=x86_64
kconfig=x86_64-rhel-7.2
branch=linux-devel/devel-hourly-2019022709
commit=997dd96471641e147cb2c33ad54284000d0f5e35
BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.2/gcc-7/997dd96471641e147cb2c33ad54284000d0f5e35/vmlinuz-5.0.0-rc3-00325-g997dd964
erst_disable
max_uptime=3600
RESULT_ROOT=/result/kernel_selftests/kselftests-02/vm-snb-4G/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.2/gcc-7/997dd96471641e147cb2c33ad54284000d0f5e35/4
LKP_SERVER=inn
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-7.2/gcc-7/997dd96471641e147cb2c33ad54284000d0f5e35/modules.cgz'
	export bm_initrd='/osimage/deps/debian-x86_64-2018-04-03.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/lkp_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/kernel_selftests_2018-12-12.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/kernel_selftests-x86_64-f5d582777bcb_2018-12-12.cgz'
	export linux_headers_initrd='/pkg/linux/x86_64-rhel-7.2/gcc-7/997dd96471641e147cb2c33ad54284000d0f5e35/linux-headers.cgz'
	export linux_selftests_initrd='/pkg/linux/x86_64-rhel-7.2/gcc-7/997dd96471641e147cb2c33ad54284000d0f5e35/linux-selftests.cgz'
	export lkp_initrd='/lkp/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export schedule_notify_address=
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='4G'
	export hdd_partitions='/dev/vda /dev/vdb /dev/vdc /dev/vdd /dev/vde /dev/vdf'
	export swap_partitions='/dev/vdg'
	export vm_tbox_group='vm-snb-4G'
	export nr_vm=56
	export vm_base_id=1001
	export kernel='/pkg/linux/x86_64-rhel-7.2/gcc-7/997dd96471641e147cb2c33ad54284000d0f5e35/vmlinuz-5.0.0-rc3-00325-g997dd964'
	export dequeue_time='2019-03-02 12:11:23 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-snb-4G-1019/kernel_selftests-kselftests-02-debian-x86_64-2018-04-03.cgz-997dd9647-20190302-13226-yk1d47-4.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test group='kselftests-02' $LKP_SRC/tests/wrapper kernel_selftests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper kernel_selftests
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time kernel_selftests.time
	$LKP_SRC/stats/wrapper time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper last_state
}

"$@"

--Lb0e7rgc7IsuDeGj
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

/Td6WFoAAATm1rRGAgAhARYAAAB0L+Wj5SGYzWRdADKYSqt8kKSEWvAZo7Ydv/tz/AJuxJZ5
vBF30b/zsUFOhv9TudZULcPnnyAaraV0UdmWBL/0Qq2x8RyxDtkd8eDlFp664TyRWk15adee
FsGoNV0CFcUhdzRTXPevHYdBUb7TpDtgTQuxFYYNfXgOy5U5pn3+zWkF1e9O3EHhibR/eMpU
+s7QJYF1F+mtKU3HoqpVJAcPyKG87JNr3AH/tCVPCckAKzEsT7tmlMRtwenJD3GylnBJwcGc
RxsttH+WeRK0nLGQi/9phHxbjSGBkFzzPOxj3ZG6UytH5czpHCbk6h2slmQCD6MPtU+hapdU
A6F546GQ/xPS/PoqxqnWh8KNmcEk7tCVdsDi7hhL1bELw6ONJJI4lvkZK16p1Jvf2HC7QfYG
KLhNOF6dA8jawSB1w13H5aWG1r1TnDby8JpE6PdRlQXfRiiT+6A8IYZp8LgwVtNeS/1G81tU
xbYAeOxcfbuJMcKpHxGN15ZxzvnRGlPmsCIR/6Acvj3Wtvqyo0ZPD8ikyGK4nB1hU+aKYOLr
5h2rhuXu3GP+hQOMFMRqKV8onXI7HKYXTHP6ZhZXSYm87rzMku4HjcnXwTH5WdKnKuwWahYT
3f722wJ+FzGGOpbkEABtc+0m2XjCvKoUulOveoTYzO6AAF3ZoYy+AcGlXOubl03AUzPIwmMO
625iZkilDKUlO73WFX4TeelEETsONaq4HDLLJhr9mTn2HsdZE7NLsP3QE4EprA44/8OnVox1
miwdW3NaO8e0A5OM4GM7R/MjaZK7qprPH6Pu8k6h0lDS3sTCpRBorZCB+8TU5pFZiciXxQDY
8by73QJlJtYMs2N85vjh9c1fjxCsbZsGqo+NwYcHYBCVJXEuVfpJjwhKaejh6VvhskkwV+ef
EcI3cPnEk0SzQ4pftuz5F/e4zKOzdM2gfnc8CFcD4Nqn+p5dg3DjN+3y5wF0xrRGq0aqmSlu
qZ/Q3sAbnTow9G4gM7hO/pOaV2l/PqN2SPrEDX6Iuuayw24O0K13fz62OGmJz99867oK/DBB
JPjJmNWlj5pwrNF7cglxZ1fKGLSPVi7bTU6KRjcc8tPNB6A22O9vEEOCtFkhi4L2Kc0L4LGw
10AjWykJu3zFRQdbS25qSE1z/heV6ZV1dxEs9UfMF+t5HBTVfoBUaX0SDrdqLPCKKLkpS081
13c7v0bC6ZVk4F412Ueiu5KkkjN+xAi8Ztr1bJjgsTjDt0AtBDEEBsandSzBG+9GSNKVzb2Z
XQUXx1rETVhOcl6RxHWJ24liHZ0xPKPj9wRa43z2bA4I6qwE9lnEcJ2xzQWlJkJzUB0XYmHe
LIZ8eKLo9eeQCB1jeaqTjBX3dgaWoGLiuKAQLMBcn4cBeE/L4E4QAX4AHluYLVm3PKbzj/3b
kbh74REHVw9WbzMdDP5QLh5Pedz5NzKobwIlBHUKLasqDhLlMuFJgpMBFgjBSH0ckUad0QsT
K6FHmveDzI0RUEgkMhLaujThgNNxSaC/m6bJPbfqw/nXTfmKDJpomZSiwsHbtnSGirBlYGtZ
hXMiXgkYeqvZ018PDsTv1V7T1HCB0/k+1TPjRaLOJlN0/SmQCTRTlAG1cUm16jd+mJENgU2E
rh1Kunj597703UqIPOexD4VVG0QdEBIvKX52VNvaG8Rk8CENquOVpVtN0WrDlvWctfCirzgv
qYVF2PXl+6tY5+1FNzkcl3xhMCgSFRj4XpWw/r58o93GDf/yaXRHWPOY6O9dQPEvSrkYqjX8
oP9qtBYud2riE5+4U63vMSc5eG9+0lldtsWpOVAhfp4Gf+3glhweqYjHBfREnTWXXbW46+87
GdId6AMlMBGBLEIvZyl7kr79feGVI+nl7PDuFV31ZXVehkeaWMnnZvyVdtyHR9HeTgfjXgHq
SFVKpPZjKtnnGZb+FW617t1IUnX1AMa4hTpeim6+LIlRD8aOo/iaZTNztMUM2Mv3iVRsTDZh
JCrWlFhjwE1J+8XzO70gYWSEDaFQpV1IfbafZU4prDwJ0VVpcH/9N8ucCQBaDbcEwVqLKHO7
wkDQy0NcTv2cBcbQEXAiyPFwL4EuUON169+1Gwwyq/CVWH4Cr3I6UcRnbUPMM2CoTNGAPF7r
p0TxYU6OiWsYe+yWugtCNMcBC7RQP+ogBBGwGa5yv16dkF7JcHtTo+I6qQw7TEFB/IrhYqUv
CT8NYGeJL6HTfAsEobi4Nak71bkfcyCqV5b8bxzduuDWqsFgGySrLG3XGJGFpz37u6X9SEsm
mxfYq6jdqwiwu6CNDC215HlB2rcmbMoGcX+dMkNtuqGQkvVQlcDIyBE943RbitcHGjxi9OxR
yR0uKWcwDPSd9ED0P+LSD1vBMcfISn6njEI33oeR2OJukHk0TFodeTrUyDYobpJziNe35qSF
/DIrgwTIBEwZOTROnnsXOw63NtOH7A5PubUerwbugQfmriNvO4H5cdj7iFW1AqV06fVXBfVi
RGkuCKph3qEbvoVONtubMwPtYdU5OQWmICCCHx70yxqDSMGbtwJYnqzf9bY474OThGMR3mYA
RqHr7pPo4M3wvlTHFa/E2AuDfvJBpVbF2TJhyT25okt1mwfC0zNt/zotw6m0ds0oqAQtkG7w
3xcMhKgyEx69Cv/KVEHWltZ3yQoTnpWQvVM4WZWnT7QjKHMAjkhDFVgAX0g75J/zg9GNni5L
0hOcDUwADV/nFvsBTxkNGHIqrISVKjx8CEheFgp3as9yG1lWpgyJ4ELyTX4iX5Tq4WqF4oFu
LaRbmZxWKrFbUeGLiWTB89DcNQXbExwVGVfPDsjFjKmN6ZJk+1ilgwRX+vrROTGKuVbUcwMK
YdPC7NmP9lOmDJQyDYLJ7YtbmPPYjpw7thd9u2ycYxzzm0/LV3vCwRi+pnWHP7puSf3DjErp
4rIvPcbaCYicv73/v/gOZ79S5b8ooTrABAF9DX5ky2QQik0tdK7TWG4zsIWi+Krwht+ZErjN
07Wdk1RS4trj0aywUfgtMt9rGTkpWm15Vk3tAcyJKoWCXUJZDbV8O8CtABlMy4MTCOXoYQAI
maF4s/ThqGQDJFGVgz14U/VNLJDAavWadvog2tVyI+5GxuU08AQNgP5ROHkRe3IjS1rGgM9l
5fhmx5fsgZ8W1DMRbGDK9ttLa+rjBsisQZGwKZD/LH0sZr3Aw7W9qOzhezGV++XLW4kkncBJ
ZvVnorOnd6tb379dTfEsGyvbBul6TuKgOUIVlATU7DqjhYQ1gXKXqs89f1H9g/nRSk3/yYfN
wQEenWaIiM+5pGzrFyY+vQYB4uSZ7CktHc87jhOYnhWxD6eNt5bC6D0EoDYcv5tWOdmWNlkl
D2jiX4/ww35BDFVIfZ40SvOZ39BPqhMRHxtzENL2v2ZTIAdfhaFd9mTxpCUqjFWnC00e7ZKJ
3DqXUIPRwHP+PQuGDCaHeH8kKUSWmfR1qH75GOCBoh2L9M2W5q3oR4CHf8b74FHwa9zvv0jA
Hy4pWSbAZ0vL3mp+rRCs1MfNTnERgjIQwLcQWZINiffTJa/ixF/xcUl1qBfirwiYndVcr19r
bBwlFYDFLzgkVHUP0bH5Mvq/qpFaa3cqNxU0uSWM2v7SEUbt2ViALzLRhbblNgeWWiPFG2sz
S0iO6wCZk2/4JowGfRSBDm/djOEp0HHsl0GU8QX1GeiAtNGU9dt0bLxnO5lzgjAbscYwCatD
eqpujVQik9GNwjlpPqkQWwjIRXaC/Wl56o/qxzRX0Z4liZqtxIACOkAXFFh0nQJFQyq6iQLL
0FTDBrNyx27F+Olvhb3nezOfIJVQwiTFUPxGo1I2xeEaBgOymJ8/49ysYHTQcK6eW6j3ASBZ
hwgI8xrfO9NPuBDfJjLUCKVflwiDNOnuhfctpgOVfXuB+xOIGnXCqxCaL0+Xi2lt/hG8DFtg
HQZVxf/LK9JVm4MLq+32vdN1bATKy4/dScg1gyntuWV3fx3wpr5bZox/intZHLy1D7jH5iPp
MOLkLFt0jy3ua6KC2tEbXPud0TaGICBqdfinKqoSW1LvhM+4LCqefMDCji+deTqT6s+gnTz6
9VirwY4gRJeC8fTbCkwCcM+001XhRZrZS06MCf1yhhewZphdNPKfXqfYRKjDLYGK2QrFSanS
r23+JFmyW81XTnNMzvXV8OmWFnSB+adRTYSHI7eG7Mf+Tu+7z3f/90mno1SIDEOBMuWCbtjJ
4+N0rKO54FFx32EEobl9kFBv/qK5QrLUIc3iE++99jH81ep4RC+sMVr6IG3jHBgerK52Ylih
ycEknnbuYivrw6GBbXysHl2vWJf97cp8TFYJuaih8OyFn1ZRU33TRDuytQeWbusGpnJCBQTd
MOXx0VCQnKivwpeUzd1hqUZhii3F/NrWM4b+Xil7AuZVkCY3g/ddZb0OP3Q26nd5jW5oYJ1k
t6JJoGplmPxAyh7WWP+scmsqULjr4sRuqnqG1aKML6wgCAePtEnB594tR4pVgs40VoqemE4Y
iGpzMiMjHJXpXV7wmJnRBWfS7vV46QZjwaKiMm5rsg/h+hVqjVte1qef3/TmW9T8lFoj19+w
hnyHccdxMJDslqNCQ4hf2UprcGq5lCYTRhQQTADUgJuKk2QSnKIBF0g6595F0sHKTZFaAIXC
PGj13O3HnjoGnWKVblBpF5Ax6XNqeM8fKY+svEX+kqL8py9hMHc5NeSSiwo4uUqljxNwqNsS
pNw7njsuC3iqPvft1jMGUT8nJ1f3GV4prsru/5BdlWJ5nyKcVld3WGYpY4m/A8i6Rn2STUbp
8ESATi0rKs+ZHT6KUzOr0OBHAOXvysx7XBtgkh/Ol7yYEt5mgy/51o3eQojf6tkwB5ZwPJY4
Ifgx7TwhVQo33PiARSjtgPoZoPeOahQ1L8BeeMM3N6nh2mOYo+Nb/dcAZHZMSUtk8yB1O2a5
3me5EsQh9U+9VSpqtwLPM5hKSTHYnFYH5QpL6j+jSxLI/FDneDHBQoav8XM41to03d3zXTbu
X2jNcQW8A1F2mCF3Xpt2d9bA8SXNc1hz9OW68DWiBkY7SVzBReXxSC3ZcVM7W2rGv8wURZ1k
HTNJXVqeHyifyJfpNhySeH25d2TlA6qKutaODTWuagkSPql9Lppb381WEmMhaDMOz7Bc4u/c
SoZm3F3or6so117Kp4W1u+Wmq2aWx+yGKmkYAVHz7wr5E1zjXjreqpB0fmJT6MIJI6Sf3Muw
EY8PIxyN/bJGrAMT4B6/tyq4Z3m0TCKbeMqKtOiGBFCtF4gPgtnQdT4T/iNtbcIAxdkkNwFJ
NQKrV6iiXVNXxmbyje1Mt2pdlt4ccDR5kU1Ed2uqoy27oRXMnl6KSzWyGH0xUlmASteOORBV
7K9Vde2KNNnGMxvpD14sQP9aWb8Nlj9MCezDCpJCJ811SX3Ytc98/OQ4WcVyubJisgpgVHmS
iEzISvMiQQksI4HNCJRrFvDA3fzw8K2ecdRi9C+Vdi7VmkxEs0q3dOgKeC168cK1Z2opn1mR
Ua27DHmBJF7+zbD5Orx6oG2A9a4AO98OYJbzHmcqhSen1+/2xYEfHV9qOZb2clfmBWhs762k
SxA9RSGJty9aMMkm3K46ibadLP2TKbSxZhuzhw+x2XHAmXU6+B85HRCjIORzdGxux6fz13Aw
OU/vXpjS5rBXSe5PF6pTEAqrazEQra2GNU7CWKnfPu90hFJcRGjXpjsd7WI55Tp10WvxBwVw
5yE/wKZC+PlLe2jcOwG8WDHvNIQc09kvAcXnOWs1t9RRk8xRTWzbQo0CQNXdqfZyjPei34/q
88mnIxXhAcHqKwHRH87fTJirtGlcXzzEyH6QEJGZhb1p0IfqwuQ9ufKNk9BFnFL/cguCM8bN
YfkSWr2IccTWWdVy8ooaOUgZE9yDngKSKNWR01jwvTeknS5j7+IbXAziB/ejPmNnY3tsn2om
NrTE0Rru+6si8mcgS68lS0EYYUf8CtEB2hOzujAZXS942l0l5ZS41txZux2G/kaEzP32ierv
E7hEaPlw5JgT/iBch+YRfLYt9jFTiAVrI/f5pJHM5CMTUECKKistT6RwgxTDG1siBqnSpxze
VhrbUO5IdlFSeqt3X0HCSnE5PHjfx7vQwDycM7SownyeyrWhPEz6tV8oiUktIVLFl5LGbDU9
mjpMAZ6uRDNlXHlAcNjV3gOLPMwWDls02e4SrmZUXgXGikGXiY/yz+xFfuoCUxXOnFjJTkU0
4oON5PFIep+dpmZy5NJ6MN/AU3ZZzL/WAGEdd1txxt9AAAozQEUr2PK/4KABDdFlxYq41kGW
p2tbq0vTDkA/PDWcVerpYl/NUJ8Lsp8WaElVp4kc8hAKpuBe/Qb9Ok6qsGiWtJ8US2o8kK4J
WRZgZI6P/vKX7DONFRs7+ixCUa22iGn72bhUsHbSlv5MVOd5K2yzWGsMdCwmxiqeR0XEe1SP
zXYkKjWpoPb2RidZQBTNrfCIUeBq3Llt/GYOo6F9Kh0dsGkg/rVaToTU3g22wKPXWKK6jiJe
CSMC6hjG6eZrPqR7gxhqLek/xvSsMLcbEjVa7Unhvfak7kCtig8Yq4Z2RsV2JI+VVu7Ho1pb
mDSygy788VgHr5XlhrfgwxScnsBoeeVpfDWXVnKyFhk7TOmGInintP5ETjuYW9m7ibbXel9w
m7poxdXJZLAQOQYKbKTtVifX5arPkWcOdUbVTYBEgjU4NfNrRj7OsaiG2LV7WffRvnsd1uJa
dAtZTLla9dyBD9cGPMvvmvW2AkykmthXuZyCmO2raUuNJV2lw+giFW7f+qo6ckm9pXeoGAR8
oRO7+vI59pRiURVAl1YmHGO1+xFYesu3BKPhV+khXrmbyRZMK9DbCDxUGDAOCHjW9uh2fUOD
l+2KFxLxk/riu9yrB1hu4aZXthpwDUmBVawvzxr+k8COe4n27vJRcBiktLpZ6nFVftjNj0HW
5vkAajEOs0SVvORQrX9UIwPiNDswp/dNh81W0Fj0FMhRbHrLHKGVy2uiJivlxL/fELgiCldF
TixrB5U5bNNLniv5rIF52A0hxyYWIKEy0lfWZXRtaNAGS4rZ5Ml+EN4xrO0E7K+k962Lb5p6
REeQBa8c004d9bFZ5VRg9s14MA2Z6zDZ4mSGzr7U5wDemsk+HeOhRw4bOVcZ2hk8XsS2ppkT
Qo5XSPQgybKLPiRsl19xCQOCK0eG3vguywELKmA7T7Dwu1TvMgpBpqwWTrDDe/m6gS/W0egU
pI+8xEh/F6q+cZ9C57A0auf06N5FeuZu7uYLQiSIbk5xmlQrPxGwlt4oSQ9bl0kRSyiqiD4E
jIuWE7KBdyfhvwZK0pls98jtzk5Vs0SwxQxIx11C6/G5D5wyJ+jw6+AcJLRZ5tDcNSXq0UTE
RmDxT4n18bp8QJsoNrD5CaFHghZwMsJ9CqDScpKVM0Hm6QomJ1L0IOVGH1RYAtatnAvDKq87
GP4w1lEbfFIDYlk53xSgIG9YcOOgeMf/mVRNHLZ9W9YXMO0dXIwVhGRHLYxkDQDSWjItVxx5
+MfCCjP+62o6q85wG16DxjktQ9oJFEAM3bvMnV4ostPiquRJTj5fsXZxn7SAxO+dyzOKVH9H
8c7Yvuas0k7BNUumvFm9XGyfSqGcp4FNhKlVw9XVY52GyHrXoBdjdCVDOdefkYV80ACVfW2q
EHfJ56ffP9TuwpHQYDnfwTBsqUWqVsjM25kD1RA4FUO0r/QK9bcReJfvj36PsMGI4rrMXHlm
kzW5gLLzKIyQnuUqw740re7biblLXovyWucjORuTbDe/zr782urZsWpdg6R+zPTOqkhF0lpL
LNEvN0//YMFh2UIM2S05r2I4m7YYCYPd69OV2y9g6H4uaLhVNlmUIZpZg4waV/XJDFwsLOSz
Bt0mQFvgmEc/3eu6bkIOYut8gg9ir44r8b+1iq7bE6yEeTGu0HwEwnArrmPK+oHE9PeG5bNc
Y1aGWvdYN53499QaZJxSguCpl9ne/4+UvmfASgdSm16uiY67k7aCXYSsNL2axaRR7JAnueZ8
dHzJLTrcSyMs6EXj0lCZz3DvEsflhyPvczDqQ+H0a7etwmWh1ws6Ncw+BJcSNs8QbmKz2PJn
ij2LwDum/QFcohnRQTTCWjw1YQNSJiVALV6Nha3yJzBqVgTU004aX+ngXO+VCYil+MXm2mHj
q0cxDEV3wHVIGBOysuOtWqVA+KpEZLIUElOJKnSKLRhLyK8DMMJVz5xjNpdVaDwhV8KNlGu5
95S1N0/RgVP06F43Ay4d2JDV96DoJ2R576Hb3JLYjXbmyGCQvalZTE2QDfhDcXUEe04xegzn
GWvqQJie5yBoDbpERt4ohf4any1pBUkeIrFL3NLObkZa9sfATR8OKoz/mwrUZCULRVGIWbo7
v4Y+N5ZOvTHNlQG97XCHMsC06oTteNECmUkWSAU2W3Pbtp/yFrFEmIs5gLzeszsIXQDQ2r7g
N67A/mARkfazNHl0kolyypYF8WoeuGOWWcxp1ffVXhz4VjWfGC1NpCc9Z4Y/wfW8UWIBkZ4Q
5tyzeewzKHY0R9S15pRydp8rKButE/fFCldnLBNpqqBfhxvpfwBfMaeA9k2QUEtr9NkagbFx
J/0JAcQrJgp08qZ+Alnd7nOzyDxr6OvEO3CJOhIN43yNLNM2xQwxQQajRtxE43mk/WxHI+lK
vTWIiZgSAFCXzwY5TDwHnRkYR0lVQxv0yXztAmTK2aOQJohODPPIiKMYo5BcJdNiQVrIqMub
oWQrbV1h7aW0HWfIy1N6PCIPSCEUfirljI21LSOgDUDfKzIWCktli4gWFxOJYAxF8mrYAYa6
w0dX19+97ZKZv2kr784ymDm7NuKD8igWw0/9L+a+ORfhfCcFbtFh2v/98TqWIheAeOJb3SFD
T2qgn2SOiY5b85bKZ4AZOf66CV/+Qu55ff8O7siC9rbJDQXuOyMA1WlmqmVP2dvvbzpOVALW
xze5j2VwsCOT5lo4A1pTQS1nunmPeMY9PisZ2H+QRCktoyQbR0yxdaIBZIWoXTaG1WsaVaWA
r559YEXP+z1KnYTMcadD4rqd8SOGwcFTHqVFLMR6F91kX3/knJnu9OwZnMg0dZ4wbxUW30C8
hbLKwoJejRDyASik6qR/ExUeC7xVjsA1r2wK1OqbfIewVtK8RgnlH1hiupeNGmCbwaMVXXGK
CPWHDxdF2YRiKQ43sRiObblahnvLzvZ5h6HNliWIzi1mJdDQUwrpxhaHNMjqFPKqt9jSogGY
ZKp1+L0G8cTQMTTxUvzTneo0x573yOyN7+ebvlxLPh7q78obWWSIr2V17hHx05jC6UrkodyK
BNbLbvKLdUhqEGv+V3qO3MF9NKqKn/0801oowYHgPnd+zeCZ89ofvj/Mynve9s7VWuw0Je8B
15xoP5uZrh8K8MKRsasl/xn0oKryf+CGIqUr3sgwWom06Xa2JJ/LIqTmrOKD1pvChx/YMg3l
nzSUuznqQNOw9M/r0xjMIubusRrqcpv/2NEnzfgKUZQQiuKLMPP6yy43aZoUknusC/ZG+lQW
qZ1C5NYlewQOUYYWf4tWQ1NZOJT1PfIPSkhCB4iyc7vaLrX8Sw3b0oatJKFEBQXj+uUsAOsa
2nFzHtIO6fxQ1M05WFEWfofU2jxxVr9gihdzrwjkxP5EbEAzxwCgCWvn0quedEggUNapIfNe
/fk83gU8mELd56BlFMHPrPosJuYOqFjsKC4xzcpd0lf4q9nzjEElmsIFsMMs+uBjSyh5dyhW
tnZWHxo8Nn8G8z8fpsmtQif+haf48fSILTfSO1LyGBt9FCOvbqoa/WyVLN6xC11dmShdNDvy
IePSfXy2IJ1wqK61ZbQeaNZJ5xksug7p444yYiTHdI4g+VGd7F6vzwvuelyVRH1tMyHhREm2
fuDZQe5+hkoaIFsLmPM7K3N4lIrwVpz33juDo4tiuClisAc7E5CqF6koY1Oc7Js0NY/nLz0/
JQ5Apl7DMychK7rINDUEbMuymTS/R7OOzMZEE7VuzkckO9Ke7NLxO25R/A4ay+Ctv/uwkj6V
Z78ejdeURSkwQMyuzBAsFoaSoQLCNuygs4sQXH4F/etG8FNlyT/jCjKWTajM1ffxpktEOBNE
Mlkbdq64A7jOatTnADLuW45F6c/qA9OkTp0dPmJDLEgpyB5xv+909Nd7OifmsVs5eSWiXJFA
/SGNPXvwyGWZzvo+Khw/m/lkW7ajTmcyksy0zbsNfj69tUox+XAi3DXMaVp0KpRmtSanTc0s
rEeq8HZduKNlrc9RkSKrYxxV1zMA8+53EZ/EacRCG9V4sFvJb+soaVzmg2la4yWtoMzbi9xO
kwPApKhrBlxJn6p6ggnE3T3GPCXLjmF2IebcNzMxyJSXi/OdQk86CptyutfrDWBGAIbsUQAb
lhSb5B6jflC3r8gMpiQCsvaurFneVwoJxyMHAu2kUh08RgR4E3f408ROfRLb8kRzw6cD6VOr
75/pZiZalUjVE46YNv5QGqkW5DI6SFukawhpX1CrkehJ8wpA27f35U7WzjQ5bdVJ1Ei/GgQh
vIthbW7QMtKC9eXjEKNNTlJmO0Y29OeBeqNVmrTwN9iSc5nh0tHNc9JqYguPZVYl3MqcOVrj
J9KtM12/UC1Bk6HV1ZEMUzuHICAHBNzOsyp8rqLMvfw4/IZ12R/DrSr7NA5ap6PdWmxjoAjy
4hsSFWMrmmXYQN9xgsFRvGIvzOTu+qmZLGlDTe1JD4n2gvC3V2Und0uqfcoSHJy26TcmIFem
AEsLgNC6mccz4VL/WW78m2A0yZiG8OGeIUB4aj/TRTvZJRcEHpD3bWlTCKDvuo4RQSPcS8Kl
HidFzw9Dayv4okAJVydF0twUTvS1qKqQ/Jo6Rytgb+kkf+3trsFRVqMbGA20Zf2B+iPlSY+l
38+XmPo0gQZjFHdThf/P1+Ou/s5BcXjApp3PgoshXXB9VzzMAmgfubDXmBmRIx9w0EXYONzS
pIyN9M5BT0m16H4Fx1R48/kvth9GEwcKIOry3fU0zILkTNwKGPBML9uI9Nw4gUw3cBMeyYXb
kxm3aa8Z8onSPi/b+EQrbR/Z5nVi5kSDffqJQLSpcn8e+K5TXVQKodh2R0ixfsrbg4IpsjEX
t81rQGk/z4JcO2ykEY1DNJpfhdZjeCIHgpFVNgFBOC+LWYOW+uclqv7dNnY2+IW96NjwAHwG
DEaTbt/Sogt3LISe7Yk+1Sh5aSrlBN+XEV18HIFCvQgrTvCrzD12RUjFFoNTiIndXeyOvB2X
zweHypLgr8em9WLEmkQOT/c8Sbz0s0iRZtNc0b9lnWVfYx0DV1qIUieC9W7z9RXOf+qbm65X
waOYQN35gRfklA4J9Ips0rVXDvVZgYmMeuurApmLPJB4HSPv7Grcz+kHPwufUpbu4mYLiE4c
OJ04v1/aXd6neZ/J6psmrUoC1JDHy3yHHwpBv5sIF8uTvyVxotjT8+pyPGMzS4o1se5KuApK
G94c0v1QkWs46GXbxCEzFhehzL7j3FdbiXfco6Iusc5axoEfZoksuYAgJDWfSO5vfnUKJsAK
Oi7WpDuMj28izGGKc+eTZz5Qtu3ZGcG91Fh/N8qCQvkmXnB7QVxJRVL6S1+X+ZS81EDFQkMC
huVyHSjNah5sEi2niDA+KrR4sYj6eV9VGWTu89J7/KnBY7sc+C2mbwxSSadpmjyMSFTmmHNq
JpJduoRLyhIZaI+2GeZrvU9v1q9YRpK/DIUeoUpX22JtomqKDDYHvD2hPt3vCQvp6siDcbk1
QefQBTqz1ut47jnNahXtD3NgkAx96/NBBU55oz8c80VRQrtVov3h43tvuug2MluVmBKnTFJz
rUVlHB+AdI0W2S8ZsSGSxHKt2kqMaKsmEO4BRIpqneGffPOm392o4a/xeVetBesK9epRe005
zxulNiaXU987lNgMx3pPIq2pGSfUK4QcdKrRbbZHRbH7RPX63TiCu8j4cOtcq6ai1E2GqSgG
QfmI27K/vFfMbDENR7yq48/vp3vfIuaAr8sGMErpcPnfwFEmt/kfs33kDoN5JnsPXGDOACNJ
ET2fEzyDsV3LS1+g/Dabl2ewGkZRtN/J2RlEaInucWMuINYOH7ChSlwrj2JJUcw0xeza5a+D
xKeyKtG6CG/SVD2/ydoRvDejo/R5T6S0rDEWXNmV1gEE85zKhZKi7b2sLUgo3mEC0ArgXJC7
0LcYnx6EjTjV5fgoxQRrUmoDIsIs2ZHHuzbA3R1hL2+0JqiFW9j39MvrBmVMOvFU7ETpZBTy
M87zu7pID1SWmhJWYpoeThF7LydNVK1JA9TugBqxKP4KYByo6duXtXcmJWIJftlu5ks+b92/
rNZJZ+fHzvqzOl+jukLugqDzLpuXTXlvtzGfYUDX0bPS7qyDehskR44ct3M6gbSjH+RWGj82
0RHQGyM1ouSTl//1ypBde9mBbVjnSoG+/UGkL/2+ZhvCtpjKXpTQGCmlaMeR87YOe0inOBme
1XtB2V5mb3dyDEKEN857wdO2WM8sHhzkNsMaHfCD/ZUtBK4s9MCFAJEMC4MlWIcvS7Fa7ahp
AUE6LEcdS4i563yCRmkcg1pUzMfoTW1bT9R4ZHGRcuLUNVkQUkgV7UlcF5erGVW9kfIIGJlt
B2tStSg7M9yc/5NVJsufeXcf2Keo7J3rZ+kUH1BbKPRfoxUIHfMoPcfgSIwx7aMCgwZtplWb
xNKWMD4z14+xBwaPgQg/87Y2pF5TMNpPOJM/tXxOiwVGXDyUoSlKNUjpwMwb9v3ihshU2fc8
anN8AC7m24bgGNWVbleEHE3OlNPr8/ZP9ESfK7TbdI7urb/SPo/SeHxBK/ADQ2XOJT2XQ+89
Qiz9I+nbRklBEDATKoxBQYzcoXwqFGQGK2a0eRImOb09Tt/ft8q2ykXKp6JJVbT6oOdU6D8O
0ipyU4voFG6JStCEghIJB/vnP6tV0LInr4DkAJNj6hBOLy3igSvCdi+LHIwMLXKm9LoHd07g
lhpFPSsmic08dT8YUVA2SPCZI6Vvz882wz6Rn6IQ328FyGTvp/TNr66alFDB32ZnH1/9FRca
VqRPI3jWiHWF3biE9TgGMhgwWc090eErr6Kly25Vgx9bBA9opbeuyrWDxBZ0IgbSeB0r3nws
B6z9bsR1PVpIoz8LRkgn5fi47dJ2UwnwaHxog06WrFCoCVwE89ZF0jCYn9pDCyeBscm/06HZ
N/kcdmrxuwtUmYFM389OTwyHrDk7dEXHpaTWZLC3by+ofMnNCzpnQ7xQJj5MN1DFOTkAP483
5Yi1937KDAAvJfB7rjg7xMFvC3lE8Bmv+o/jchRr390dVk2Ob/Z1h3wivlc2gjCJncFjx9Xn
JTgx64BaBh6Xnr+xcp2sAZUzpc2Li6W9gws2LcQoAAmdadLyXxJBB+WiYzccueOx5hTLEwXu
mZ4JbRG57+FM/xaG2QqYd8wr/Mc2ohoDLXqEeAZuS869co/y+U11kKIYirpR5NRW7tZ2CtF2
zBlZX51tdXOmPKffRNF+1S3Yg8hSNqM+ZjUxRKaPhG1Kwx4hSqfFns3+tU47ivrChIbqKvAI
S5Hsa/AbvO7/Z7QfQ/S29AP7cd0dkjqi5onjfjopGyv7Fjroy38CZRAEOls7jXHcf56lCJYH
r7ZcZIdjRBwVGAggI3wmzjL0h9QrHIP64pqeh2dEQoq+MSmQkbA9suG6FbxYc5yVQXaXxNtX
Fe1HPMj04O3wGJ0JyyeTxZRokM/A65q/VMlshcsISrBoWcybU3XTu/5xs9vdIQxaJmZNKWyF
JXToTTI7O9TRa/q+UV/zGIx3PuPIYD8KGA9dwfuwKvu8HZ7URDyOzT2l8bDGOq/H9zzvHLU5
0+7Yx/MRhPGDdxeRLYGa1sD2Yp3qPzCJafJoOLHNFtWPWUw/JK4yc2FsqyzCfs0Otkq9mTuT
ZctQF24YnBf1T7e9Y+sZ2ChKZSEGCLzpK3cY0FW1jCS+/t2iyVt8RmiDS4WGATQQmxIs5kVd
wz4GNXiN3s1yypKIBnDPVUOPtJBY+5EfmCkrow6kM/U/IjwyUYa1vLUi01Ua/sKrG/YobZbf
gyXPaJH0SIajcgVgUK526YdoKuvIkXa5l9vTTF/a800z3NI07u3AcxFvfFFu1fzfO0g1DPpN
VdSMhthlF3Q5uijQB59uTMg6P59/uamdX/mFO/sQedMUE9wwxKAFs5t1aTxf34KHL0rcJsGz
R/GnEE8T4+wsPVNo4b7G9U10RelnBzItQeaEHORICLu9VnpCHkxIz5kv6MmjeS+6Oz4bpcQt
/XnLvu8ElUh8CcesUUrw0AWzhs+/LY6g1gmTghsyS9dwAJIP5cDOfNFbHBGGz1FdJgzlNy4Q
58zrqUr9e2FqoQ+bZH+dQw7jP5pQenOzbTNwtu9TXT2l6HUGhLme9mKklv75lZUkeiHuMrEV
w0TY6NmbzYg4dUU1qnOmPmeDQjUi3XA5SOxM1iYCD/H8jrfwxhAuqmcWqgU/DWxVIsesHsiY
NPEqp4M/PYUpfngev4RrYSgW1KUdZWBxbFDL7kJ6xJk4oJw/SEUrM1fIem0CWQaZdtlroyui
Hvd6LOi+75aeCDkVPI9HXMsrHteE2qR5azzJyDGpgi+LA7WNR8X0bcb3k7INtENPTdQ36oHt
qwCSTuWzfAf/mmqUNEGS9CwA7pptDClYoJpK3EDx1dVzJUMRaKqUPMImd4pWxlvjb5dBN8i4
3r2C+DvNbn0RRDkgiwHte8TALa1ydXYqLoPWxwDFbAQo/VIUtrQybU0T1s/aC6VvZ7TaDYTx
DHm85tMMF2UHGXApQDbVZLmnTfjuN3p6Wg84nVdGCIc5T6rQRejX6eTV6bn/A0z4u5X/Rk0K
p7vsYlLZUPC9a5Oyms69Ni2V9NsAscQhF7v+OqLtK61F0cAgVYm32Iyf3jsU9n/jGvwdfq6U
jjDu4BHWjcq3v5OCPvb9lv8VjeZVX5xnw4ZuD1/kDFvrWseC4klD1OPhndH90v9YuyVY/CS6
yJi2uWEx3ssSBIoD1lslsZGTD1uUifth8i/sJ2Ic/nyRenppuICJmv93+kGnKB8YqBcIdTBy
yogargpUT14IsXzOoi1JU7QOos06grotNDClnh0c3aAV0cGDInSZYDfT/fBvQTHtyonLN/V6
kGwRESghFMfd6iBxs/UKRusJA24aup5wdWcPspz9KRejZdJBIirj5EJ5BXpUVhg40gEHWUR/
4x0TKLRvRzVZSn060zSHYuEnAGrIY8hPoPA7bJvn6FwBnicA9MNtXxtFvMtZwW54ZqTDDdkl
MoBPkKnf0aLolYKehViYmrw8BreRMRf6LcNj3npV9fzsmKjl+fMxRjpQbBe3wqXCLJ31A+nr
eAnE06RSOIRjaD9TEdV1NAF+DMkj2tLO37voWq5GyU3JDzpQDQLU+xbsV8MXy34dPV+jgybf
0Kr2Yx3lHtuY+gF/jKeoXL65E+GJPYwelo44+l5qA74iLfmD5yELRleFwxCgmUP+0OKRy3wQ
EXQJwaTE5oEEWrFc/qhBehuVQOW49W7+AGkcLJENm7zIxkozPliGXmz4iGFxeBwFppVXmxAv
+ef7mHNdxKg86qy3c4VUteQMrfZRyeNgCXhDBWfNYS3BRvEd37fSEPWcJOOJzgP5uc70Mi2q
D8XXJIAFon4PfHLemgwMeLR4Wv5G5+jhsEbgjzP0CYJQ6dHibPhucLlD5Y9O8MsueRoq1jnw
tthmUmhSDsZu6Xegp0p94IZ4zjQ/Gf69bDfCjIgLBtAYULjwCVNsGzT4ivSKAw5Rn9NhM+Sk
zHPC0uIE9gP7xDYBwC+TiEy9ZaqaneS/0e5JfWnAPapa6mjvIaaQNVfDWDfeAM3ZOm8uxbbA
Ovno7/WU7cXbqSfsqEjQoED4KTlqId5kXfq3n9qvYs4Awjgi+/eknItUQnoWJCi6KSg1v2j0
7Y7bM2mo8vMDf99zUtEcTOsijNLdU3t2+kn5c6QncH8AjsicVcoTedu1np7agCvhRao5Dwi3
bXO58BAcdqwvy8y7Gwb5kpsZaNIIx8ZpbCbt1nbqttf7Qtm8ZG8dwihlu86enxa1iOglY/Y6
8rvHTJka8Ktl06taTdvza/vW7eBtgv93IA6kk0nkrij/2udS3O0I3A//KSB0ISBn+1WVR9+a
L9WkL9AdP8WHBM6+2Zk06kJP7co/Jlk8bXC+Ehy7GxwDrkG59XIswut4vX4ezk/Mqt6D7D4I
JPMvpzCgKw+hnj8r7c/oFFiLwY0dqMjt36/00R3ZkmjLNMf4yCCxNzHLmBYjB4vSVSDaUysp
qgFaY8d2h3Fw0Fz9Et+HHW8yu0C7LLvDUZ2Kidg43KL4BcNCWn2xpouXe7/iS7BBrPO2Em2l
3mc+HXfZDu6KtgOF0N1S01l2lRKrXJ+oT0q7OF9xcGpfeBQjdNtgswnMyah2cPqcnvg3u1zJ
9q/E5MvOo9aCPuW2OhxKT2ys7ytUurREhdsvf178U+ciTgbnUr3f1pnOeyyDN2kovxeL/CvM
Z4zBDfF+a7Yky9emx9hvaYTpIByJ1mhUntDFEyRoinSXW6+QHdE4916uSFraJF6QKElNwz+T
OOa4EtLp8nFcJBgWNUqeL/Vb56NlrBTgUN1NKReDGKrlK1vQB/2Jxc6nu0C5e4FLnTr8mFE6
gdpg1heTQv6gc2xuXkcQmcbflbEuFGtc5Q9vxT8H2EHKqHBfXPlbpUnFnkK/gV5wD5u0kdfM
NNz1Yis/WPBLxE2UqH75H0T/o9hLSMQv4VvOF+L6BzdXmea55mfiqaEgoNiqhoLulEGJq3o5
5NlJ9vOhFrfT1/5bEgPj6pvcHGSBB2jlNtLBs4KImZgJj8FwlHfojPCUVzCk6x6/9aQbuz2e
dppUONwLWmEGlQ6m3SROzHJzvmGRrrEhOXCbMG/hB1lmdGfxTaaHXuyBqPFejBrQpkBdesyd
js3sYiPVLOSTag+D8z9Q3uY7MP/CSHutOTmmqNmEKdbYqH8mvVDprIytgl8aBNa/TDSCs+l3
P3if3ic8VkgRG9wgF1Jr3mr0i4197sm8G7w6rS3MPUoBgQh1WB/YRregGxA2WwIqJYhh+L8M
ytFYDTQTqQ+7zX52ADvFcVAo1/1x0amIlWyS/IdbWQg29azYTDGOy4bHdLJ4kM60gg5zAo8w
kQ+1U7k7QIf21Hb/ZSE88/bdTTdFoQJWQVbErR2bmOB7xZ7wKWjx0PsBt51t0ihu/GCwWhTr
XbByb5JOkQINkJcrHh6oYU7HItG0tO8pQjlBNk00saJ5cif3+veZxB2Y8+GGrDGF0sq8XUCh
FW6QB+81aDdNVnS+0PLsIw8vbNhRd3iE9h67ZD4KXVJbIQIu74PHCrzBYbpSrOvdn2eSTlhT
AscWZH68x/KFy1/dAt0OVd/x2Rq6KLtGKR4+a00lvIEOBq/iQLyGT15wuQHA/PL+UObldBjh
I7F1VpfyMqXhSsoHUv4G9XUXnjWC2aNXXX1YrqyeMMAn16VSAx10TwwXRLndcmv2oKSwRwNr
FF/Q7x/1hB2H3sSJgYyuPDfpT2IBsatMd4RORGxWvkA2h1OoUaePatlrUC6vGyvKWUZW3E4z
NjTkYy1xDD0m8uj9jmMFL+dlVHvgu/rcaPU9xXxmHT6s1u/8HVITHTAYZkC8R2ULEMozGc5n
WzQBxbftJBX9H+U8pRWJRpZk6KisN/eAOFgmpIDhx+boIweeW+JgvEzdC7rhn6LzTDfLEAJ+
Sp/hJknFyX4gd/3tuZdut0xIRqkkUpryBifdGdYOigtrfdNuvWs4snP8GOOABAXmegO29hpE
wtcRCVq1idOzBhKomdrYBLnsxa8b4JgSfYPsgS5c6ZbYXNCY97q0lWKVv+6ByGouEjcdekyS
ciWOVAmXwjtRvRjixsXQwnZUHA9Pkz1IwC+U1qOEG8dGewtNLEt4MFfKyAqgqGJ9pch3yvqI
lFsZUBLWkGaCB3isBHFy4qc7mwHkDRDcGcXAS2j86uk04MOMVYKFWW3k8KymWSygJnUOOt6g
I/qzmi9F0qzIUGnm+cgVMQl+dl67LWQsZeNcRMKGPdOC6/qAaQduJ3d9K68FeumnvrsAaqvA
w+ME+Vhj17u7yWuogV4HozR6V706rZZgpiDFzI4TKZZxYi+AsKozbYopM595b6mygwJa86ub
zzlO6yReTWauls9i411L1mcpSICAg6JO0ytNPrOdROFu2VA7Gs+cmVpqyS92rUNa+Uk9JWyi
eHNAkc4qdj8lDvR3OJr7zY7ilIdqaYCJB2P+W7WOmJ9M5EC/TduiueSPfHDImvcafHn/tzsR
Bxqf3j85RmCcyy9pqJrViIPNzogJtzuW+Wl2bLyNCTNO0xGYhGc9ecrWu3KeCwUZSBrJg3sB
IKTA4wDttvuvwayA/ZBef55NXxIfyUTgWmz622K0/dU4ZQq2pTTkdnVcUQH9WiqyskbuDutr
LVVi5nTdzYzWamxFB6zSWBQEjbhG/mDiGl4mZxhjrVz8S4dJX9uUZT/ItL82BJ/wvvl0kkQC
8anXc7tYkAiz8hrKHEEc9svoM71Clh0XNW5V4lz28gcVwMdraMqd64mV1EadJBshLT8rMaNj
FvxsSlIkkRt5GBOTrlK/jMP5LkFm6p8j68fXK83g/HlO+KVypwbgx0UeWzsoDBGl2glal0Tz
wdSH30z3e8mJIyQDIP/eYKZyboHk3YwmTqvnCiCrsirpr3cZ4qj/zlNKdWbsLaoF5bA/ZVDY
wed+6wnP/5zGMh52JNNTQQUbL1gfJIL3yGdXdjb1iwaavZpYmnjku2Y6Ai3hUEFO3fi/Bs7p
6x/BaDg7B5gKEJsNqAg+vjRNnDVfRGrLciK3UPFQHFyR4AIVVK56the5Xe9AlYEil//yuXW4
qh4EvKfpSLb4/fBUlrfjtqRYfMCx7jfU9jN7A08RIWN9+6UJjOP/gOoQGHO+67SI7d2YC7kb
st85+m+3Ao0yXEiPwtY+dStLKqt2R3HnLkvqEf8FgwfVPJ6gpU/GeGZQpVNI+TOGgxXKI/Q7
/IYJ639yyOchkAQPeAPaptpsge1SAcrbRX6MlqZzFtybIKILvSgYPHK3cuHl0b6rkH3Z4U0O
Ftu2YEuPydX/B8Ywzh1CQsc6hztRgXQBo+xx5qkg2lydVCKQ44sBzramzL8B1J07fjFRkLkc
aKjZfWm2l8Lt1RbXzeCmdse7wB6nu7ty9UN/xrCCLUVimFwkQJ5GLeVg9FPUA8yXNGJ8X2fm
/LgVasnp7Ne+cmOVN5WQsYi4Iiy38jHYe6YE9wiV1tzQ2FRJ0OzE7LrUUbO1+V7b0nZgU9tU
1GYVYBh6Do53+MvpOF/z+3fLv5bBRUR8RcYTU0Of4FhIJFDEbIX1NBPCHnpzIr6BMGpqzGrC
YsUkypuS2odArA3fZOjMe1OanTZTOyRB7cDThj1g7LMTcGqh1ED30ugcsLcPERujkvRo5kIm
T7j2gt2jZIhInZciSkjFp1lIH7VxhlWC/iO6ThibluKIsnATHrbmwz0zxKxHy+x+f4JxFUYU
2IU5v5dKUIMdUKWrqiw3OEAK/e9uVqhaWERhWnEVnPgcOIeyMPMH2OdBbh/R2y/rnvgU0La8
X/2hUMTPTD1Vk+/1PAEMqlYhqt795k4+yGaHXaB/IBTOO3Q82uEvG/mjfldIFww5+8bsElD1
6BhmcyhnsUQG8BFXJDRpZ9n+W7sIUHXyKgY4NZPThFL5cVhtCjp3IhlnbEamLKJ27B6Btov5
0kQ4TJvw+vOk5yyZjDLnYVU/f/I/8kKytTLL2AU/nhyEhC4ogKGRUKmVWZYplqvxyzjDvwul
TQ2nzYl6cspuKFabYsIqg6/W7XwCEDkmD171mApQ9aL/69676b64bBBx0k0Bruqq+E6B2lyI
elN75TaRvGhc8YEO+atd+5EePmsIMkoh7Zznfcl6NvKwvGGr6eZIu2mVihe7VbHh+1O/fHoX
v97NIYDfHLnTb6c5TgNEUAYUX9SSQINjZ6F2ym0C1bc52lG1WUty4CaZw9ysp6dFHV/4IjBk
U4Mk36NXDIB7xSmUKEQO4dkYnZqDR0OAnVF3LNpqCbKz3ylqRCsAkWTxh8bPv9MHZjrUaVRk
fDJniYzg/rRIvcwm+TSqCZOgGnsgFR2b4SkQ1fUmwvmoCPQG7uOWexbLbIlJAIByx+Uly3dU
WQjB8Fu9wKsVYsEyw7DgFqETZX5lFGd1OFU8YhJBMJQ7SGtbFKGCewgJ+/YYDa1fHz57O3DN
8VizbB71mc3v3J2pAf/JMODYFOxCm67OTy1OlzKSoQzcPyoHIBe6o8MbXm26QJrDC2VhsasE
O/5JvT17PMQgwbghcVHDuS+Z1AfXxyEMzL/oHKVeVRwCKSJkXffHFJpWZ6pp2Mz4s6/0OiZc
5mmo8auFD5aKlMNfFTEdMi8b6j41aZpikj/0jQ52VuDguXp5OdA+ATAFoi67hbYtyfNK4am2
y6k8S/FnygeOEEjtyfOvGpr1Z7bXlT4W+ZOKH7smtaV3TqCnqMdGNLie0Sig3mq+588ou5Up
dYOTnWoFU05+hyXeavWU/0EdkGvbnKCbE0VBLILVyIpHqI9CpW4iVYeERnI39tZSg9BPpciH
xpkPIU3/2gfCDvqm0ZGt0cgmTm+xEY3ROlx1buCHsJgDOcm0yCDXa+TeRk3G3N1cWVjcGGic
6wPH43ztJF2EQDdw9Vf+/T2mDBlkUyqWMfIa991SUjtSYcvsmcBo6zLZzrSPAEC/68WgREUB
yDAilwhFCZfSqCXcjNiIddt1NLc9R6olWmeJGBKgllB5miBfJqNOaltvkz0Qgxab6zGTi1cC
gAZfLvOKc/U83mEMr/R3Y0I6EY2WwBNO1m4UejiLlg+7iuk4Nu1FpMHNIwVZEH1FqHKKNopA
8gAy1FsvNh1Jyq7AEjku14Q+292HnMR8hMMtF7MW2hOWcVTLbrCh150bcq4lhGG/4U21tCQF
tXihYoAGIzLReCZBFCJA4JXWigXf+BUWgpU5r1y7Qt9ADpeiGhf269y9t6sVUuSOuooXyLoA
yojdob0MtEEHwrUJyzAYu85lwl3lLrlrxLk7sQPqG1vKI2jOOEjyMGQmllsTK4iS+ODHGBLY
vV6EEYTAnJSfqRRKQtAHr5UvbotPFCSPbeswniDIgX/hmV41sZmF5OOApGVzyyka4d3Zo9ym
iogfVsGB6twoEx+eARX8LVht8BqgtPA6GORuWiuvtkaXfWyXoDU4UigrXzNVjSUMz8AUIhil
VnIzH/1+MM1EcdTXxHIPmtD34UmbwR52V4jZslJUdrJQQX2zFPiBEM+uhS/Wqjtspx/Hfm7U
zGYA0geZ0oSoVsF2MjCWYbE3Lf7NdbAGVacWgtwub1Pg0amaW97uQzXwVuPuUYfwWaC/19AK
q1Gd0fM1y1gaTpmwi5Z75N/5THgsXXnWfn8NjGG9hKf+t4gh7G/IkcYP++hmEEJ3fwpRY7il
2Tn18Im0X0wGsftsc07eQEYXA2mVArEphcPIcInsNWoWbC3yrnuWuVGzbevMAwczFd2axQyc
3IY3+1QCy0CiUwlPss7040i3jTL3G62C0hkCKX5Kb1bnZVL4N0NL2etJ4ALkTMHAFpYIv5sX
dCqWZfhdKjrC8seihDyLG55UB7l2Yc43bYlbbn5EcJJfGpyWmEdJddDWph5E5emR3uHtLNrM
utzVgf1xEeQw+79rxWMpNlGxbphRsFqJMfzEbBzFPHZfUv47hlST2CouPfrTKZQoUe49mVxr
rgPcytTcXzl/OdyOBPd9a1BSpEken67bzDB9+oEBew0M/Eg6K1TgAMaP4hbY/G9D1n1Vu+sH
ftqvK5ydLmLO6H8C6FJYO0RpkzagMVhfff3SpqQs0QINJXd2rQzHqQ8KzKhBd7rK/nb9EMqP
K+ybAsgAhLcO40j+RLRUGUCmVP21pfREZGklhlmk/7g7kb1F6rWrfwhaEWEP8U+xZxubEJmh
ZxnOGh2ltG0TuBqKkbDXHTppPcjovGdVUuNpMIyHeT/i0N6tOM426o8oxnrzhcRgAGVzIdax
ZR1p7aBS83MNkevqGUA8skq1bexIMlxsmfKK4UaPzGv1bUKM8We1j21WR446AaPt4xyzR1BO
WQV6yzXo0Qur6CCZz6mWuDSY4QrStvdQEvyAMI+j2+RvWJzf8062LxUGbwVQ2w7B1UC/Zb9E
0F6yo6FoN5jxFKaQxxj0+PdWJ2WpzULXqb/ojObcJQqxuv3up7aFsfglliEPwfHp8E9zJKur
It1gtVibKH+4+V8uzaozdRNXl5yd/uD6c0RqX+0BtQdviau8nhZDVfis8Jb+NFA63VNZj2Tf
cOJXuI2H8+3wkBATpu+IABwbMWiFXJxRQ9kl+3L22K0M/CdCDukZARZfIY4m0rc/IH2n4G2Q
aLGn7uYYFvtCT45UJfdXmGrOL291y9a1QcrLwitZQ3o9v28C+FQd98dips6kC3gyNQWoHJl3
J5YbNyPA5Tk/+qqwEr59E+NE85bBxxcEaFSMFxImuND2SaxzbyCJOBMCB1XWmckYA6vIpeYp
pLb2QtREmYsOFNJtqGoC3RypcFKU/08zr2eQTa+q8NBKmgEu8N4TQFsqLT9RmKdZpYtNY9pl
/YpYYLg/HvA9GZ4JTSnoCVHCLPLCoFxf7jefl9BV2XOT5Mwm+aVRpGSelSNEWHoTB1QZY+zq
HajHDlL5On+khdBeKCuV1N4EE/wM+kp8wTcpKWxgAmxlJmuJns1+43O18mKMgN+bBMywGdNk
92GacxaaHDXfUTZob1gshf8eC1XkqLmJtTNQDkG1pIUR5h6gMulrLwxgvYtu/y8wZpSuSPRr
O+vTrudOIQPRZA1tKC6w3lS5oFazISmwQJcK0n5674mgtnft/GeZoR89ocfZ61euaqEIaOvq
IrJMLdr2pWkrYKm7D8bJWDVpjNzcW7H8H5FSwyDEB9PKt6hF/9s+8ZRQl3CluUO2AMYmhd42
REC2ioscSYwJVSD1IBtStKVfaFJ9W1wSEdsjiK6HIqLpokmDFcsABCWuMLZklqdWi9ezpPYf
urFO6MNSH4g8mlGqCdgutGGa7Wn0FfRxdzXDWB38MOyTSas7JtPTKed0Q3+X1+ltO3ObBPW6
kpeE3nEh1c2vdCSO52fB8Hf1olv64hbju9l8ytJ8O5ue6BId5xdyjUHdh2dqFTbgq0eCOMVv
v0NT1rUwvZp2wKDcALk/TPkFXJC2PrYSF+jPzGTbSKKg8obxhXOexYMIEcXICmexpU/VuL5f
eBkbmUdTXY0My2l94nBANRQXcYi8Zn7bSgaUbQJIY3dVEnGDwV2IwJcgyzEYcAmxBHwbaeI6
PYNWY6eWuB7JuoQa+xS3UUo4luoeSpSubovyEcZOCQYCPuB646TEwWmzYF1iyQpav+MF047R
3y7EkJX+jIv1l8lg4xt2AWeLP7lXgAu/pGjoVXyFPZrhlsqp7XK2yRyhSRhYML9uVdRpHzyN
LpEziWpuo2MUXwHMm6dE+m3jDZMD9L39guW+HHKQcOtyElVNagwzuYpa32ABuBaMMe//u8kW
XKQ4nO+K07u31T6MWmjw2fp9ETmKyuSfxY5Ubqgf/roOv+iUoZBqxAtB93H7esRI8tf3Nq5G
yurAhiuHcQbFwnyFaIKMlPwnTV0BqumrtZOmTl1f2BYt8RqqKz2YZIwziUNBCDohi05wj0De
H5NJZ/5kxvDTeq878P1up9ko55QXEVToRgmKsQHzIpETVM1jPu6gH2ZbG6SiatkXGZOoKz1x
axKqryUHTxVC0502zlh7pzb3P5UWUAF8Heylg05XAqjdJ+mIns+Lft1uPl/5RW+7sw2t4uTW
Wzc6j3dhxXZ0qJhiRaov9w5ube44cVEMudAHPSdd/VvvX5TycNek+p3n54R03nZEA5EXAoEF
kgEYuvLFvD3BeVgtkmP6wGG3fJgZZkxiAW08oqwwUNkNirZmTP2uiqq+H+jR1NYAHOjDfJF+
6VvtQHyEfwrYD8y27WkAhho8iIUz/zlYcFpAheJ2RjJ8y4CUKrFcKnPY1vH4jFp4yphlzjdb
f4gPOPYl9VtPa8fO9V6sYTbQzWGB2OPqV8Tt0Jc/pjDVl7iT0nWNeCK4g2kKlPiXz6fNkC4a
YGFPARnR1JBkAtIlEEF4EBvR4d3SuX9+UjFsg8diP4Jw0RTrY0WKIQf8FGTJyYtuBbxUkgbp
3zdwm8XC7iftmkUYRAl+qecKvAl7xw1MBcxl+NEWjgTM7YHhXH+cukM2c3m2U96ZyXm9dXoH
oi013G49wQAXk38+xehEZ7p/JbtP2JekvacXzvx1kQmWBNRvmpR0CDJCK8vALD2d/1xFVOuf
vFsphcyr7faT8Q+vpRbX8G1Y9aSGCsvoSmAEhGzATTbK5ovIY2e5VQAK/bLqYJO/xibxhRt4
RYF0uGF8Dfd1kaaM4EMSEBZIUjlGbdFguKS/NJDnyOEBFzkKi2NscgLeRdVKruer/+f8HF28
Q1sdr+tzIaMx9R5EywrAPPTcq2SQvj6thtdmwLvhSTgIvVCMIfLFTNhsRYAva6tcxn6Kd1US
44LHpCcoHLsBpOqQLa0xF6xI9/sQsgIrjd8jpIWR8JnBCBfYd7UXRBAU7FcITuNxgrh7LMDY
LkCcexz6e2+vUGxzD6MtgNP7I0GIsNFMPxnyaZQIVkGq9aEvEeZoOVSwLMWHFHYWpo2bCpn1
jD5jFbkl2fx/D7mautGXvO+nGov67t1Aj8T/muS9oKr5OApsmrNkgyjfj01lDqv3HXJsybuE
Uy32J0tjb8f+vEKNWygmt8YDrdYf4kTTw7xcuO0YVjQTMtRr0mbFX9NQOCLhoF25qI2WRW1D
WTMVAY9wqWZbvN7dnlqcMSZemH8cZsqEQPefoIyLEK84QkjBZtq4KzeFLKoS78F0yaXb6Nws
mBgvY6Ib1rFZQK6AS4WEVUVRZFxBhr22vdyYP23CrhcJFhZpphBPyvEefQof8smlCzFvtIR7
RY3k5pCc8i6gIwFFoc8E1bJWajtg0CM4iZNJ19f6ZPYqTjv3Yd0Q9FmxVaGxdLZUgGf6zNe8
8UbI+NdjkxrqwhtjgQ0BcHbuum9C3gh/9YwFsmxJMyCbLgrPTyIqYM+etDURj+xrHkV9UvUD
r8J6+SrndF1+XsMfnURivWY8536Rf8F0VuiizcGEWhKSgsKooUiqqHOoI4fwdRkW0jhKX7PU
59YAZgb5/c7xUgp1j+k9OBY9aiavGIlaz+btYN1JcncNwcd+BiJ795C7iXvAivMX5mrBbm4k
XbmBFEBELPdU44ekaJFyQUDbx80dkI7VqbLJseS7jT0J7zO7Pb0nvqSxhRcNti1jqschcIkU
Y8zw1Ltq0sDIdeIiqIJsRQeh7luEEkkDuTulA5TX5ogwBC6YErCPwHK6WEJjYgG5tBd0OaJ0
Ga4mkkLHrjQySdrZKNHixtcvd8JNBHll5qcqUtkAnsk7ZK/wjhd7jYUChBe/pMTDk6hQXDyO
Sfecd/39ZT/wckIsVJib17U0EtWSQFCDbj6zbezomkD7RFC7tVRF2Um4+eXElv0y2czw4oHc
lEpHOdxntI6gqiB+NLDO0bs/4xy7OpZ2x6u/AbwFBFzKKu6bwiSBKtmy3R3AYih8zTX9vGU2
ruMWhLFasACcAqQdQaK6fCOvfarfV473S2RhXLiGBxXHqDk9DnvfLpLZllue3U0IRKS6X+H1
six3DWQCS33uc7QPg8AGBxwqqktebK22M+ezop21qmhj6hur06+fXCbSV/xE1bkeGl/SfJCM
ebIzQpfZCkhsiUNxTeH36jPuOBi2LIavB79zzXCa9xzmHv4QjQqDQKchpByDBHvSZnxi1bfc
VDSrP805xMMtxgIkQUZT5Ovt1Anzet0hr6PYIZQZ++hlRHxxT9ABM4n5R7RnBUl2cikD1BT9
8sE6LnaANM/59tSs1oEl7f5CxO6zEi0SRgxT9Tqn2Z4jWOAn2MkT58kpjGY8WeIP7htgX8EP
U0AKD22qLWQFdvdAktZOEKMsguFPFZHsVxe3xgKY+jxr1lHBKjHvSs3rOSueJjCRp8IcUKkB
yBifspSTugwmyuGhQuknZ6s2ihq1Dvx17ddKRDvVT6Gkgqy8JEJE34Wg8HI+JtVmwU3AiKjl
IK8D3OZ+9B9O9CcOZUd39bY3Gpmt0R+Cut0YvJYDEVMitzM15wXUeQyPr0WjAdMn5XyZ5rMh
hemH+lCNuNBxzYrLCvCc/QANe6tPnJweaqatF/Aw09NVBloeEP2t/XCpZnShnwcSUQkcK933
dX+/zS2OIBgC7u1OWX6uMfuXGSyPq3cYXE7D8X3dCfrfafoL9Q7q9rWHhJe7Psc3G1BTKz0L
yb6bzjcb0aonY8sr8N9wPYGsgkdGuJPWbPXqJGPy/DVMhC6n8kZ0yP7hFhI893kiJbmHkck3
BGurSrN9W5hasnz8TuU/5ChZSaBEnsPGf6+aTzx5Ri2WL3Bv/EaZ+hs9nU2Wudlz9M5+/WFD
/xKy+OKfncFWNxpqiM8YKfdJQ2e2O3O1x69UeGDDe9Wl0PQyG8bWSFrIyuUGKgZi/5DCAo8X
Yl/ZmaAYrx69e52wQ+2ZQkTY3IIo52LLQI+NP1sXqXxQwE1C8T1FFpzL9qR1loFW7zeq2x2q
TqwRzOUFLZgN6IPIo4ANJgQXbeBboo9e7m3mXXDGy17YQz+r1rCU5f+g9YQRwQncSsgyjo7O
/ybUZLtvE8iIGSV5o4dmQhPaXnHga45pP7DM+fbT/OmNBxQKVRVEKJ015Q369QfMUTN913gx
TaM2+qZc9Wk6L3u30ouGugtjuBMRfwLXe8NnCcHtfK3zODEyoK5y1/UZSjfXaLVlW8ADJbek
bX4Oe9eVbuTtH0gDFckSwwwjgG/chhrIRqEKFZzG/TQYqU/Pfzt6NR2hhxmFYIppURWLEYkU
WFZxBt8GTwEtznbk/AzQLtEPSxMfb7W6ZPZTCpV6Hlm6yCCAASuv36uT07c4ecguKcChlRe6
LNX/V++Xqxj4q23g5/69WQ/ug+qqWPP9oLG32t/Wsv5eaqMc/hiJMNMpu60RilcvGSCzhQuK
eRpZ/nojlvKy97/Mt5LHbvzVeHukDIlkIpXygKfwlO7L1S29x9dMBZvP02QPtOTrNzdIwj1X
FDIKL0AGQKfGftk/DIr1Fgn+Q5WJzbtUWz/LVFobYUouyy1Ax47zca+Wcqysy8YzDDLPCUT4
i/E3QspVvjkgC8FdPAfEYdPH5jDYnE44maHH5MjD8OJY6f7hWWbQuctW+PZ7UC7TKDJj3D9q
KrgvZN0hb9MWqyBXkQIN7XJDBu1mvdpmCohm0MP//AgoAdq/YguAPeP6lf9J6MrRhSo7CQUC
LT6M4IkwMoApQyvgWUqTb/T/V9lh65O/Og8dXKH3K8Htax9pFdOV7BeH5NZl2W1vVC7qd2o4
I1giANlgbgib9FPsdpeHJE0rTtruge7TXVnPk6cg7L9l/BqSNg1aoh1HQRj3YCe5hRTaEf38
0Tthf9/S7gW8+PWeHVI3Wp46qbytDIJbcIEgjYb56mscsEZjfvT8jKaFP8An0css/yUzrhqI
+xForohVAerdKVV/uJKS48VFVS7019epVG8B/MKBuFzLYOBRDo9/qZJ4YNrskgsecQvZLupj
c86OU6ZsDkFbnSBxLXkhdWKcMeQebIsAwbGDxfQwXmiInCFRK8L25gz9z4HZ2gVXtJ7nvlfd
Y9r5cNCendVNMepbu/EjWCp5DYCmp9NImR7f3II9XmXbQ4nJd+lR4vecQbgXjRxdKJf2at5F
IhnL66M2vBUo5dFWHBPtKD7fU2Re5WFWLb8B2RD/Qy107WDySN8af4KqsQ/9UHz+uWYjJ7ZJ
O5Jc5Ac/y/2o7ydEVAJm6jQxD8BSuj+E17dyPqtWgp0SzKTIu0+gl2FZ2v3L6C2jz5+I/9qM
92Ey3HslaWUs54P8K1nJjc1CFjmhONJJDDkjz8RM7RSaweYi/NvhMSZY+LOgKVKVpE7ABuA+
hYJjURox+05U8zlNnVEUrNwAvKxLym5D5TpZsVKYIsTwIRpD5D+B/PBEJy6z9O6MlYmrXxCG
Nqfc88zGte95788vRNAAv6byzddA7xRDkEhL3UTSFm/EYYRMETVZQUmN16HPeM4c3SF1+cBS
VQHerN+ftleYHqj5QI073qyjj2djDauDk8Gt23alYsjEmt/EAhY7jDxtlXqoJQJ+xBYnodNM
St98JDpt32ufRo7WOj+v+9C4vDAiHq6+s/djro3xAykVmvBJTRstAqMY7dmW66B8x1BYQ9PL
lWwRZZxOLn4W2MkrsHXe9sD/mPOeLUl2mtQJIiZbANij6vCikqIIAuc+lyXudjDdNXfWRBsg
13VhDdYKi35hua1yCjeDAGNtqmdio1p/7eUI1ETtLvDBuZTxhAa+o8H5Wzy/BWWwqsVzKpAy
KzO4W1kG8eKFfDuPBgFyRvjEbbEuQIPhTGIJvdGKODb3C8RhxBqdjogKyOM/zvtWlD7m4vgC
qwOXHhQp5v/zgTD2sIt3even5OpGelqG1gbDS69t7eH21rrngfxgepEo/Cy12zUpmAQTDSdf
y1Lg0pu2vX5Ox3jG3wj4NOlGkwnd31c++zyl8TMXLo+Pvg98h9hKiN4tFX4RTc8wdRq9FGM+
x8zIhJBiVmJrMX+0HBEIBU122OoV2Xnwnt/yMn1YeXOb2tAzRHF+fN+BfPIZTwaSHsf/q58J
4k6cUnt749W0jQXKljFh1f1JxcmeL5FJYoq7fm7MaWz361N03gwH/GSEM58Na43Rxt5Isbpr
kqWEunkxamH7tyOlxK5du22TcqwbHehJZM1Rjz63MIPzN7jie2uRKvsq40dOKWwvg3hDtn2N
0aXnbcnPyviLzl3ZS5FjMVjXXDvoha5Vd8gikoh0Hshng8I+bi/vDAiMxvYWZkXbZB2BKAws
9A58iQ7mScDHrdX+J1a+U00ug0m4Knpus2pYdDwNDslz3fN7KVpL1d/a0YvB2ZlpWlzJ2vHw
Apf3IgBCKzYCgzKrDQ7fBdp/a3+/R6OwTmQ5QPbmHPeea3Kg3iye6DManGoma9SjsMRrYa0Y
79Mu4t8as9qaKeT/0FSJkAMIXunIQDCD219ypxLwlTM0luDBhujIJv2SpT/FKXAWzYVKPfCJ
D3030gJkK2yIsYYPQhcV4unYdAO8kXZq9Ys3EmLCja6uhkLvgll/thi5VcEb8ULfsnSheGXU
1sNiZ9S4vF/t2xuBvOU/flfId0H5S0z9N9GNn/00SNrklLx52m+jB11x3gFRctwW7xt5Gq3j
K9PURtIp4w9ho3PvRiZdZp4K86OXUo8mj8toXpCZddJoxbZ/Osq6Z28UvVyP829X3UZJHRSL
XKifbbzb4Gwq0IA7E1OQCzt99CNzUIjE9UXldaZk6RwrT2pAMlP6OorUJNXuHDKdCXyHrQvv
CBqzFZewYO1mLqOzz9KQ9VpCBGdgweqPlnZ5499vywp9m8TvrajbSWMsfMbG2G4PpPpY6UyW
drxUPs298jF8lvqWfAmTs9NiuGW1+0j7Cf+E/J+JsoWkOKwI++o/0pDUFU8qTq9NWxWyeQI1
zAnxWhsB/Ri56xFrwZMNZpTY5FiWdmTFQmmZf+l6RvEoew+yGzvJ0jH2pZTqU+BtC7dA10hb
AzMK5Wkn6/xqczaQpT5wXOXcxGgSJdpYC3f5a52HbYDBy/GtlE5oQcPFxN7VEwojZfTbqhRY
zrFcvqefFETV/Ba3YRo1bzTFQejt7jxBdSaJTlF9N3No/ymAmc6EaIZyFV3H5y4C+nP1aikR
k6MNf24xrVm5/sF5xG3k6DMClPSeR7DPS5F3ncodHHUfpLn9OmD1u7QSvDubftexT990MALk
SO3QktOp8mJaTWflG5/7stsfZsK8aLUeZW0uqa62eJr6YeyiT9mRbJCWg43tG3bIpjGrRCuK
q3nPob+ZShMKBwuxtP+l8tcnmJSvJYXdIF3/zPTppqtZIqVZNP7AbyccVEKFbVVabIED5mQe
sz2ABzhs7lDR+sxmelvPQ4NRklH9caQT0wZBj1ZE/QOJESmGplgecN9mNy9pQXcvipi1hnGX
rpV3nfrx0le22Jel+p7uj3C69C9EFpI4r8MUa99FkWYi67k8yAy2ZhMUEQIumEZI3N1MPktv
1OeZf5Sxd69HaRTpYMXAG1b1GOnJYO/CXTj3Z+uk+j1wnW6suGSBIa4Qv5hngTXM1JclnK6i
4ylCuvj17pObFTVzXBSQohGKUEsXDvU3vI/XRQmQWV0IFPLcamOLU1mRPf7suCb8enAqAGcK
+nzTCAcAyCeIWg6xHz2+IiXVgMk9R8RXzj0oErWQMfHtDGasCMiPKcqtwu1kbOXxwMnJnRPR
qvb3yZNxP7P8rmRJhER7jh7GyAbjmTbJREJxW5oF6rk+CZ/FjaCkOXWa+9btNkZuCuYGwgMW
TpDdkMAZ2F2jIKmMJLEGZ7nbIQDGX27+xlIDkmK4kXWZ9/5WycU/iN1wVTOkX/bPQuXrshLT
pAxSzn7tKAKHKdZDywlXaBTrCJiGsr3NZm+FYjoLuKB99nPc8KJHtvjfiq4EZMdrmgxl4sJV
/MrNBdpZ0ashkIhN8ydTkuqTTaoYr2EiHRtNc5S87gKD9feM0Qiai1MYeEE3zmmk189hsEqV
xKdONr2hLAuKUXnEo24hbtqXcuMIkm6caFmPpQRHCxxyxHJnYbqtsj8kBgI4JyEd48U3Bcmi
cwhmpOHIfiNqExXWeEOll+/L6ar+5mPXqeRY1Fln/vg/QaS2vi/OkSv8QB3sII2wWkINvePn
Gl/J5PSSCimqxFhVDGzm6CFj6HNO3bR2/ZjbWzSNxIKaMl7G46X36dPnLD/AWUthqDKO1imN
J7uHoNcNyiQNJKyNAx9w/RboveuylH83b3cfXsQuGA7+Oo/PHsR8LON3Lr2oa48iJNaFJKgI
0s+YTkZru5X1CAgWed25kFEek4VsgUjGIeQQoS1p7gY8ks5C/GSk0Xuz3sJmJ14JOFX6q6J/
vWYIrd8M2i4MO2AIuN/ywwI2K63+1dVC7q/wD200rkfO3FySh3D/m+2aw6BiTOFiZgUlEezL
+eTK/cqC4CCgG2FRxFTeh1qsRG0fLsCE0QV3HXy/mREA0tZouL540d2wXUdfqs3N/Me3iqT0
ViE4ZEUcdgeOxyYKKyanHSC1YkHY7c9QV37xxnhK19EvtRzxic/Vi46YzgACvh6xPmQTOkcb
14VRUjCQtegrR/qOrXuTKLV4iLuKO5JKi++TmqK9zGLpEC0Oe+bFI2fQQmH2jlaQqJOBmJ43
BL9jkWzMY5voZ8y8ZPwuV9mLinOfL0KJfRVbsBgs2zTZqXFZl7IKO3c7HZ0qP15x/xVu7VVh
EnvhLbMBTUhNu7kXnOpLls/xDqV70rwkrZev3OOn0NJy0cM6/LQu+H2ZMdHMgK9J3OUctEzU
ZVB7ekOILHy+k848/LrR6xS5E3maVEd8CW//0zGFHIfdW5u06earekhTlgPWB3+33jdDFbWH
i3ssmPtIjDL+j5APi+iDEHH+0EWE6kISo8ujQTjMMsRPZq7oAGmDi7dwMrcWOHJ4dIyEyLEB
2L2sKbJXbWxKRRLgcgoXhXyZxVEG+TNeE3nk79Kegv27y8ECGeKt/0MUkt4gbVoHDrk7EX8Y
6KVe53jgnSSesfT7KPcXcUTU5xnttu8hINkm5J8vaqS3tI+hzNfwvBesBlVXyg3dJYD8pYk3
YJ7L3mUNrL0mL9PQ61VI0sp9w12PWB2aUB8Mbq3qVG7EfGzxfSgDMdYW35d9AH68enZqkWeI
MpHJKH9xS9ToHHIir/hVfzdaEZB+4bGQNnPLtikf2U4F6kWQFG9nMrMWmXVgBzxRcNn3oLJj
MaR7rKgGkL/XzlsM5j4v1djyM3s5wtfYRrc8ELK79kbOCbn48y+WB6OTPGcOmmgG/d/EQZfl
lcexIB6scofPOGHl2tPWcdWlKlStjy3mrUAmvw1JR6mK7ETqTKLkS1eBtXshD2lr4o58gdmP
J3BWqBBpf0YwYXmvsvd7GRHrE4cjN5LA6YBWBObuEvSEZHmsktJX7e1MWag+t/fvNpuF3OA4
GqUHUm/uF3fLy2wzGksenHlNxH30OS2Hf10F/eI5CNhZTB6qpVW4CgVd+pLoYn6oCL8ycdp6
vnwNP5xqtka6b2vlbVm+PdIP02u/s04mUxy4+u7ViayzpY56l6ll0pVL+GBiCUi57hxORcaq
T0i0RfPiBUXadNFOIAFTaEXOYkHY2V3/Km2abihL+JJIno87OugAvRa7SlFyw4gPcKLdLT8i
hKhR+F1ZtURf9E4EcbxCc4TfsGar7/bSiiOpdGf+jLzorIZJlld/QjOMNAOpiA/7+X8pxoi/
xM77U4UMb2XAO7nLo6ol86z6qPEA1tsuP400J0MQM1bPedq9f74wxubQvKH2t0Uj7bhlrJMm
9q4d5CUMj6nwBfpebHlgXg8bNdSZMOvnV50CzbrcnkcMER/DXQVQ0z8y1ONM+feEUltxf88Q
zjo7qg77cyi78tAMUM+23KkDpCn9hM3Skv8j5MdynqJeVeblXFHmP1ZBcj9bS6v+GFvcXQxS
yVPY5vop7Cy4JbTB78+2F0NkQ48rbhr5wmNJ6/TeCBQ6XFUC7OUmVa3X27sc4BGp0XN8ynV1
JcSJCNPxOGUDKg7yu0llU63tAzt3SXBfZADGV4GSxu6ZCr6bZZbQAwwxgGCbVxEfurcLc8ky
xC7DmyVG+GgIzDrZcsZbnJmPvn4J3keHEwKjqfGy63c8EqZ4scx+mOFdWtqejUKc3SbuSSoU
ehrUmvpbt9cmOi9MzVDUIS/4fGzFbS8KhQFK5BJm+zhSHTAL+1808OEv1kdWx5m0flvdVkIU
jvX34b33f9ULqlcrEOJSZxNSSbbl99bAF3Pz9DFgMLsGlreEnTYBjR+xgpyTPHDjMHuFUM03
SQ6CEmOkKxENmloR/KmZcYK0IAgiyr+l7/JHSidQJINlcTO/VjLQJoamWE9ObzOg68QUkIcx
MeiEh8xlovpoD5WX5A1IjccLGuM2YauJtqZG9osk/8mBXmolBlNPEcqvIL7GQSj4MM3VU5zH
nitGrH01J+Qkiz14rHsIMSLQxjW4j2SLQld3hCyDvpO+StD7Rzk/9oj6/3z7ZpJsCISEoZW4
uDJP1sxmxQikJhY3vq9UcJoDzTgiI20jKkWRpnFQfEjErIkA4/B7T0MEwffPlNDnZDn8XpfA
R7WG9Co/2hS+Ajh5aptSNvmVRFdk9Ie7aBAq1cYjVx6SVNop/R2sXG20XMh2omhg7G4dKq51
1fnfrSNN4loMRQSXDhqtV2HynxoPVxjzACAMuDn9JKEnDnnag29oWNAoDvqW4zzEPy1Jg1V+
8l+44Jrm1+COmat7ccYZrRmy8WAOAmJXH2/G018d0X6v46Vpb9OcsqgBPy9ilqRGsWzEuDmx
hjjL3CKMi1O6CwOsfDnfgy5PqijqmQ6dMrJeLED/F62BJEAwD8bLFOUQTCnlQRlz61MKPiq9
4BCj4iIV/FwpwZbZv+PW4YBLhpVL9kSjxVQY6fs5v1nTiMZN1REEV3tIEsWKTWz9SCFqbdSn
xI4PQtVdMHIvT3iQQoyF2V76M6D2W9o2FcEGWGEGU8iR4MiCyvhoymdS+QbPxQceoQA/FtUC
1faXIP2uRJx4FFljrc0bCZvqyjVTmkQxqn/Eyx8KHEm1li56Zp/30kiSaDugga8qYORfGung
5nqKnSqRgA3RCJATAYUTMUIq/F1sqamFVG4rvcF/I2yEI3YQckTksszNTpe+mYZrK1TAL1I8
zAg3Hz+JT7C+rQp7HhJDS3vJc6j+B44Yjg2rl3Kjur8JWQxMrGYZ9wi1wEaCyxf/xPKw+PUD
oPI18umeMbgANa4h+JTs9mF3vZRFRks++Otv7Hf9J292NEuGzY1yKymWq0h+Vz0Xs6gZJf88
j9XigXAnoIabdtbMeM+C01mKjHSqP85GDU4blVO7LwCFh61HJ4E284gDmByiUSRH8itKyiSn
ODEvkBN1U1lbfNJmRIzu9TUlf6nQQ/Q8kRseENp5tEcL3npe1wN3hhrkWZmbdmayr2sKyeli
O7szayquLG+SufaYuD7jauReQDwf7w+gra3n6AhDb+ejyLu5jaJQFzMpOBuc3FadmlclroKV
AL9zPxVsAPx+Yz9R/3qnOQ5HAu1J3HPbJiXd5AKUtQ9r6Cx46IytGmfEdCm2lceaXMGYM/77
o8NfGlE9iljgYXLGwM7wetROc3v10r4uy6ehlAmNdzjLvxD+bpmZxMwX/gMlb9ezOGQru1jk
g4601LstKY++I6TjMZZknkjYxadgeSxyDiCVZarkRBOlcxUbP0TUBasi7bz2o8I8q1R5vFz+
IREhk62tBYNWQ2uraYSgrQ1v6t9c+YRaTYQEDvp9AYZYz/y7djxZiqWAcqlhg/y8Bzbl7gEB
NOPuK+P6i9JCKB5I3V7hXbeJAAVATXhKY9w4HWbIGC2MHRPgRGZo7DezSuoaGqDy2ilyTwNS
o48p2+xjRWwr+9pvc3hMSn7j//Ke51CDDrCa7TSfM2BD5/VimQB3sWMpD1hMatrdCxBJvF/o
/9qAb8jNX7OGT6DPcX9BBz52StRK+Nw8QuUOVSDYxo1n8yOoUKf1+XP91Q3k3xZlHF+CvZDT
OTDZ34AgXFXiry0HyOEAOSMzRI3gEr4AylB+3rjigW+dQdpf5cde81wHtG86bFxaOI+LwTl+
wBAOq8JlUIy4+pH1AFmrxBShqZrkmKkvXW3pX1P9yqr+un++QGTlP0hZoFCSFlSP5IHKdeUk
1T/czHJkcy5NcwKkSWCZiW/njumkeCZ79Hv9n52axPNAGlIZOpEA3Ju/LemNRhSaLaDU9pyi
AwWC8AeB3xb1KIwo2ykRqzY1+H4yNIvSXL23o+sZbSlsQukOOvS3/y8rQYRh5if2qGnoGpP+
183k3dsd3/Rk5CG/J4iM65BbvAmNR7Yc3EgrErtY/5RzTAT6Q+ZomX7ZwbYaNlVa0wdpL216
Ym5OOqP2dlP3KG4aplX2Y9RLDUsIjbhBB0d6uzXKHhZiNlD6rBKA/klYhm9WSEGVtWn8se2m
AsZUMKSYYWAB9ONwcDcf9c0yUL8lQ18iIFfqc4CqLbm5Iye9qYjhRPXpHsbQk3tG39dVNSqa
o8ZlL/qcL/w+tPxhvvrk3fBi3M7zz2/hs8BR3PUdD7QyvHmxFiaQx7tnx25IIvOu+TV2MmLX
bAQvqycyFXO+BnvTTymk4bnFAqHZphLpJactq8hpExWuoLuDzXmikEOGy6ZVoOWBonaEmye5
3U7+QWzGfZcoTZpC+vcXz8bTrBwdwPJJVDNx6r8/Wl1eSXRXy8tc9Fcpm++A8Nn3LttVmD3K
qHL+wf1RDyXlIjNKJY50QbSeDxJ2aKjYV/Wy7bJ6GcsrbhUJX7nks/qQ7wPLTT+GbOzACCMI
tpEKfY3FEIWoNikrFkCWmiRBaqE2z42OYfoz19blUPXdeBHeDadEbxyzurvJsPosWDxXCvQA
7HCXDK5cnveMGgHeRpQSUE7Tf1lbWZTv3oGhY5eT3jNMycYZOvaGstY2J1+dFP/jPnsf4Lpn
QjpGvBAbDNUGLyt98q3ZkYFehVLEh0PELb37FYuTatx5gK0DRJTMXN9FENeIRJofKH4E3xDM
aG7iM2IglZWN32F3Nib+ByBXiPfaGIhHQ9bVQhhpjMBfWODgkvRB5SJ7g8j6V2HONe3a9zP1
CVAjM5TqtFacd+FIG4V4PYjuvbHepzf/vW5KeeSTmfeRkKz7rpG9sgtSD5/nog4Be/K8okPp
kTdcBnmI/lTRCI92NZzlw5s/6wx2ktuhzJEJQ1+ok/cH5+gnJpCrjGeVDmSpRDbwOB0CDkNX
2usnOdVVMD4Tk/S2rR9TDs7qyKcOjvgtytMr8Ww/zY3RaavMXbeH53A0PRj9KSRmiVvdEG0W
Nj3BV9p7oIu4mAGw3d0unQNMEdvytZpCCLwLRHw37TG1KUN22Y1dy8tgn7IKjmbtsTJQPeKd
AFZWmH2bZ4/QtSxJ1SZ67fMTheBd6dYZfJHlMnvi3rg4GjL9+DeaT70g8kqsieSQLGzaJfnl
hQvCeJjAfWgf8mg6udLc85aVHgy2vQsBPvpnJ9UKWRod1PNKnZ6nOT0+pq0O8D8mzYF0J1Zj
H+AHRksLmlmaivMKGi59oRu+RjoOu9SEXvjsyMTaFvA9i/o1Vhli7Q/JZo/HItDMVz7fpOes
fsgXCFnPPw4a5ACqZuMIkN4RWhI9F+6Cu4bHgjNyFWgcvGIwhE2uLcdxTbz2wP4hOX/VsYJW
8RDad56tNsICTvgh9lsuIYTmjoue6PkZ75Yo7gtjP1MzO4g9/U6QVFaEDAx7dcUNytiJ3AE0
jdEMtFcodxHJ3J+BMxRlMIYxqLTyUGMakwQz6r8V2rDxXJH9HYP3rNrP21ePQ4/Hk25IErHo
ZA/uG7QI07UDwiUkRtKa4iGuxSqlB4pIDfk8Eqb60vtBR3Thv6qAPcyiQroQk+6Ac7FFLppk
kYYqguWf908GUmQbfSdmgBZY+drnk/oU1CZEVPozEsMU1UFU/slA18/cdDOl/Pc3TkSEuyTj
mJUz9tmONaIMlWa/ez2u6EfB+npx1op9S0dYnxZbJgg9zFrPK10PmopUPubwUgGFpSuUf6eO
2wjzf89YlsE0kR4qme6zB0zgYkfXGHGLY3uLoUWsDR5FGw9g2KJKnIKd/SFAyEMRfnjBnj0V
2hpHN3DwgsjZdiIAPo+pOuo4h8+K3f4ocz2ou7Fh6QdVAKomFhf+V0xbs+Vbfpmiegvpirpm
ENRs8FTeiSs2THxgvYQqKLsiUJBZOLD8dPHCh2Bg2fkGAdeqZrMH5dzYkysuRpqKHnkmOuCW
IkZ0sqXu5g6X1ufAhocyLvIeXFfcWLfx6jhyLFJ1tvx5byPcHoH1302eJyFpNKYWx2mYHeeR
ezuqZQS03WdsxLs2lRprRwWUEWkAbY/UYgu16/OvX/UNrYmP7OsdJyHTVU3xRqyBNOCZ2/jf
i9Fm9fiolEADl9awghIWU7iNMQqUj+KxAkP0WCOi5F0K5qT1EkimhVX3ENEDv+/AgG91He7W
wLO6lfjlFNH4yAI5n+tRe7wRDvYh6Px/z266Fpz0szIqBT9uF3vexlod7ulbMd3IK1eBqzTT
vRSRzqIO9CF+ZPeJPOdmvKVYkzmu8zF6oVKmIsGO5Ro+DmQ7U28tGZ3b34MVSZhEU5Mg2LEu
L7xkiA1+v+KY3hxdFRVnHPeq+P1p3g9CjqUcrZxqHxv7TN07MCFXTPGWi9P5z2zhIAtcslJq
7LO/w4+1BZGvwiHQciIhn8ggsIGBreiX2My+nhouhDLkvuXSjtRBlabNvbJc5c9bY8RdUORK
E/ywX2mjcQCP9bnA2hTlvBXeePF+TMs4Vgk6EACPHquhDSIbDHYr/GpDMOKqTdyflLPzfVTf
+aaybzKhOSc+OmFf58AP6sK3idGJFI2rCcXioxhr+P8SPDdzJUVkaYNxiO4mMzVAfCtnc0NC
W6SOJ5V+eBOqZv2LW7bhog5NjrltnHeUIYOBQSt1AwYPNd+g9aaym1pWWgC7uoL7ivecoM30
I4yU/m6h9ZINqTwXmRCL70cYPBnBEMdEZ7kXSgHiw/2sC67WpWnJvuKmNOJZ1S7DYCCvHX6r
IFvUPx/zsu3NKLp+0loJWwlCOB88vomG/3loHeM0sKuPlI8M/f2YZ5mGGi1hk0zsihdw9R9h
LM/FZl+6UjzOrBLS7qeLJo375XS4XB77k/eKEdmCCiwzqI1gHfRXuwLaRTUG86WGlrr5zuWa
qkcXwLjY3UcVqM/mVmoP2eB2UvuFBSNtMdwJvPwOZ6smRi7PEUWrBlHQ1YzfhbvU2cqhW4aY
Rb5y3FJFb2OjWw+VtQEI/j5hsmrIV8DyRrLXo5ItxBpU8pfE+2YPVGXhEFzMrm1D3491XpHi
Y5+28KR49BJpKG5U3gfNcSZwvq9A0vLBpQRFu4Hj5kEGrzFdLMm1ZbcwmNoNPopu0kpjjMej
T2WvoVWTjM9gO3fbrTOCnsQ6j1Qb4xPR7QGueHCvB8gSbbxZziacpBGcFmhV5bT3NC/IV6hz
eHxMbYT9uaeV7xy3a/y+acuM5+dlrnj0US07hhIVls8Urgt1xE81JTv3Uh6CH7iQ97wNU5Qu
ZsQaRAId2V9AmymkTpyZj7Y/tphj0n7CzkMl/7H/JyAD6eK4NC7J/oTV+bOeZZpRccCKHCAW
nGl0glzutXib4MXZtMaJJzP658CLWmNZ6wCTD2+zUR+CYnLLO8wa+TSW3RO2JjrPmVs+bNv+
tHBCrxWhRaO/1GmF/WLOuB3nOiV8e1RoAOiNgzwV1Ltm0Auqs1qFkqrHawOpM3Yg0OHurEwL
NR6lPERbzJqWN2aGsp7eUE5NB0pNECtgQfvn2eFwt6hQ9vr4PCVsPB3CBHGcj1xVWBNcMMZw
9WgIJpRmMEt+2TACjsWVJJaXpcwLK/cu5jgx6SQNLE3CKdrsptUXFG8WKP9kvbuGjreDv7pG
xHTkUOZSqU7KGWcocGn3Z/KDX85zgimZSN5Ckf+Mqe/KTRogdblOiswSABa3Qxx0sGMGRtBR
VcWzJZW1vruvAzpVpX8bOGdBUWe7x6zpWQCvsb6ctgYs9bbSZziMU1ftN1YWWWZ4FjNLI4PU
Pjb+Vbxdk7uII5OS6RVE+1GIi8psFmEelwbotbw2NyLUGvQAPSLBwIToxWuNftxMHVzea58H
Jf6tgb872yI8BNTBxcmevzQbo7ZOfIhsqExOiPtzqD5RWYaYkw1spc3qSfANQCQOn2ee2qLG
tHMtFRuNnjrlatdFNL2aQMK4sCymY850aNjyVUqSYDfTsWyQ6JW8h362Oy6uI3D8rm8+s4p5
sfLK5zZ4jzErWR9e7aTGDGQhCvH9WvEGAIT7GU5jccr1WWXqeBRLoLMY4Yr5BjePw+VUD1lz
G6U8DOlpgGBf16JNpmf5bAzRqBDhiORBynVl1SdqggPr3X2BggJRDQT9lDl7vDWXBf6RUfwW
iGdednrsiCOY9Gxw66ANV+kl8hVPP6BDm7iA/8Aiad++v2OiSRz6nmIuv86KwfInwHQYNTeD
/odI1OddC+6CPYFcOo0My/4ohbGVf5io2zyJ7SRJ9btZkw4MxPkb800cZUGU5J1PofoLu45Y
re1hx/KuCNyLI6t5aOAj2o/67AzKAuuH8VsHuluDGlQk9B9aZBjcZcvOi6OJL8ZPBCw7Km53
RgDJfYyUJQG2+ea/yI7hZeOtGEK9YHTE7wyHZIGDrxBH7MyiNiXP7o6rhqk1XhToUBiXzuZi
Xqv9ARv62FGTNXWIdaJZuP9KFNL1+UoCGOZXUe7pyStWBMZu/w+Pa5cqIgpUAUET6jgoSrsn
IXH8yVyZIim3fWQgyTptioTkPa9VVMzbxP5GxS9Led6dvLK/PTtmyi+VgHXubi3/iGiwnBCP
QioZ4NpIvnMx7b0EZzeXX1II89ZIiF/6V6MllfsrxmGMMP4nvBjvrkJLNQv1nhIIOC2w1Hhp
eP0CfWfFc8DghgEb3rjkEJ5gS+saLm3s0yU0cprbfoHdBoTyiQfvl4gceWmxjz8Y0x7toiUG
AZ+bDIM/5sx9JYFRQ6p76SkMV4+zAclxIOaHl+2VLVCiEidrZ57FvhQOgPhv5BMyjKroNr2C
VbqjvS9rBFqZ2MGwq6k57CVbthlwPaxbs8l8Y1Lmv0zyLAML4ck2GjZUrGHy6LwluuHQXGf0
JU5pOXUiq9bmVNiYQFMqpAQ8PiZoSH0FUABJeTIScdYzz4Y4n+HKQjZqILnHspop78L1ICbr
Tj9W3klRcF93qG0o7BYEXE9OK/Qmm9qWX0DsvyATDsYWSY2F0JV1DsgXl1yShcPn36bDAti/
KD4WmZZNAJ4qGX9YTzU5rV1E8KTPvvAmuyNbqlIcgB9dgktn/5GBwc8q2LKKX0nj3VTvjUkw
tkqCvTd7n+DZMStr0hr4gxIZqotEGtqzKRc7EwCwA9z+WFc+67z5tY95Am/tUx3CQBGH8T3s
IYkEB+Jc5VM70uiCvUE4bBs+CsxFs9/jspM1/SztrNFyDjLM/jeNWDNcU1yU6aKeW9Mc9o8V
BBROf0D54mq7a0fvS3WmlXGlgp/Qufv7ZHFvWcuyMZBTY20qc/JFR0VDpxXJPRRGpZpXqwQp
66e1K5nfTWCQY4ltgpr6uLJ+SOoazUK8PXL3Db2iKBjkk+P5DroKr10iayIlltcoZNFgt+10
0y71TRzVeH+P+NMgcdHyrzyUmd+TQ3bn7MAuCaQJVbUtKn7JQu3zHA0qm4QgPEsDrA39pGpq
C/fvbfIYHTdb0KDoFX89USeQjcE2/TSdl1WjguHxZtprvoqum1mH8zx4uf9clTLWdvvIAeVE
zo5VRQsN3kO7RefsH4JH0/aRIN/Rx3bx6OYRFchakuKEnExL8PMUQw1J40JSu1NJ2E/YC2W8
r4uLLkCy798vPNJV4b5Y/3y6g14P0ZVnj5qLGkc2TVdi7jb+UpE6Gu9Ms4rTNR7B/YlLy1AR
9VFyJnExYe9NmsrLbmWwJx830aUBBYvIErEAT8WcybNd+FiVQOsTrOyPGz8oVL7oYAMgjuZS
d+XBsJWxX07s3yyovefOlmLFjZl2YUqyb0jBPPHyjp5MC85//E1X9Y3l0nidwitpwyn8uWNU
tJQZTyIY1p0nXsRCCqBwUcmt7F33GfiBULjW4J2GTEX2oV9tdp04keW8LMtPpAO7jjJmi+h1
KFx7W07zgePPeaiu+GthZeOzxvEbyncqpWcEIiJUwXsz3/LL0+LJpv8plMq1L9cCzwLgmpMW
hDhSGaoIhgJk5JUBXYiGDz5R4g0ECSumRQVzBHKrKAvi4xO+WZPmJFH0OwSpMQvEndgt2OOo
+RxsrMSWkU9ShK+D9p16XsLJROeoj/4WU0z8+3h07JCAvUBUQa8rkTSbgn2+80ErouGfrNIr
79UiPVBdeK1n+zT598RM4qsvcd5SAk3E3LIDtt+9mhHriGqUvKRDYoVp4VRzux6U2e7GaE/c
GgDrWkkx0hhSiO0CE0H90jOEHOxGAxzfG9wMYxX3/n/PJoSPyMA/YYb8DAjYzfxOVeVqUPwg
AEkuKrTL4yoQGtuTHrPapD9MXuIGcVk8/2FoCC+GNDOklJ6Fpi99AxSkEkHQiWbOXchYdhAm
pa1MP9Cw40oNDoE2Lgu7vz3YfCFKKRul1V7OESDroiH7fRONwUxbd2mBGj97BdJMFDsFgpdP
tEkQWEuxmsRbYSuTo6zJdBeYZNbX/F5osArHl5BldWzj8yOLnC8r0LWdERBkIkYOrDVUBNuv
k1L9ZgvfE+rFgJjLO1sxJg5qOgMqfhkB0yq6t+1cWK7kFxmPvGN9eD91MLnkMo06ZSbDvhqb
XV+A50bPsHOD4p4twvD3NYXT2pKWM18Pd9i8gx3vn3znUIeOFUEmvKWO6xlMeRm8Ct3Nyl2m
tVvVqQdYvP2FjHEtzmcfAGzFRvZYGVc2xu56nPbi/V2JJB0GQqqdrODGB5U1iYsreUsQhcWR
tblcPaGddvdZqaPv6PURDf4TU37Tk4YsdY7FXTMiGgrEuDGmCbkxpsG8EmMVfcPPutiD4cZM
YjG3n6IDnaKHdTPTeHr2dDUwfv+LieTyeImyGp8RBZN809hc1b6Sr1GWeMR+ui/tobX4okm0
xfsfgDk8feYHfgiEh77ApnplCrwUoX/GGu/0NdhjtB22pu9Few+nkvlvEsV/UwcrHapS/nXN
i/1syX6LtB+ZvhgGw+110buLybckw8vYUwEoz4IeNCllDyHlyzBhQCrIj0SzusbUH4+q9sSM
UXhrGRaOarB6zpZf/bR1mebMJGC2n6bdNtXYp2su678gX5IoqlXxUMnYNHT/P9eH5CBB9rOQ
zVAqccAFwpNEtAVnJ8YXSqtkwHCiIs82jRd0QPHL34ZDfOHcwKeJLFW8TSTFdO7RFoaxFk5Y
0nDdKq1bD34tzpZHJ0R8oAq4NgpToMd+I30k7n6pURprnG35KM3XyyW5xMY8SJakBiu/Y2k9
g/VqUcSUkRex3qimnb6Pk1VwGvJQWF3fAOx/5Cm2m08/wUvsFgmEFLAWz4CR0j/XRbBujkHT
meuKdwvtQqDTbTRSM9sLVYPtfrEw9+wLxVkDEC+t5EYjz5TNuIUyxNqVR97Nt29v1jkSn0g/
FheY2gSRLHJYWBftHVudA2k9Z1z0uEPiiwgts0PAYvJgWesgMRfX1i6CQINUm8f/kGgsde0h
xxNrdNFlc4ZT3L52uTUQAYaN5A7C3WqFKWASHt9LhwpEnRwAICCV+lKlG0FYf95DH7xzq5xR
+toQoI0BEtfwyVfdbgfheEJNaORSQlRcp6ZoWl7eP3nHXT4ZDTMWYVcGP2zXhmm0PebuX/HJ
olRDBEp0Ekb3DiHp7F+n36GWGGwg/QsRmj0y1D3cXDZ2vOEI9T2tltlTTHVdFDRw0I6qXkYY
v3tGOhfrila6Gtzx8WL/jQaZFbG2suNdt/AOmWrufdSrrpl5t222VTGTTIO1PS0PB5z4v0+f
5Q/vRKNsRLEDaKJ/ioQipUzu68YtpwSSxmGng9lNtFG7dIhpbkR2mpk5qWsognuHguTtB+Ql
8gz1l5aLC1lP9Wm9a50YMJN8ozYpzmNSnjRJjQFQbBbM8+P9zU16HfvOm4BmFan3HiHLCYd7
ol6mZBi6+s1+TDL+fcgxA8wTzm4l97fc8EMX3g39pUcuKVTH5BOBnuUF7/nhZnTDPXA8db+d
x2cV29lgRL/va/p88jTXfmgvep2hXGCv5hLKNDD+W+X4aefnL4SmwB97CWB+GN29GhrsY92D
0kOYoQYVjJqu3fr9uBBXb+lExseq5GKUmUy/PADCVAkd//PKPO2Xf3KsePcX0cZO+29HUDDx
kUAUgxz8r7lDVExdEtjjcjpd2R4WspXvbREaCC5EzkL3rIQwPgYc06NDSa5FyklClviMPnns
J2kvqGhNDepX6B2hC4C5F/fgixECq009Os4l9tHdqlZO6gZtsfJw2SSIpuyezXKZMoR8PVTt
0oMy6Yi+gicybK2cqM384hXk2QNYMAbN5jmi+ghEW7Z8Mh/uzYG0gbyLLRcFtJbxp4h2nyWG
+xdg9slH1C4hlukYyahaxrRh5IJRyIJQ/irwAfVtVoC0SV3S65qjh9SkQPwHVCW/aRlvYCj/
XLnbYPUo772yUnE/UVsziA/9J4ctHhF0WJ2AbH+TWacRAZRjxYigb1o/pWkoqFCPCzHrSdDR
5cVqyig7e8l98DJcYP4XxllJWr5+xPNpbQIbeueEGkMNZMgkM1j9K5qpWWf2ds1DJXunMXsA
B0uK49wg1/n4XrGQnThLAVFMEyrKnVFaexftAtuUhlLj8tYmWyHSbPUWxodJbEepH1D/uly4
1bTFxvIFgRT5TuWr3UJwMSt8XIFXS4duHavlds458S/CYATdITxDG5GGJsGrg9kRWdvIWPZZ
+1qv+oqs4e/Clh8E3M7sI69uXH4K3LBRj3QUDkrqfG2YVDbNFFn6TR5sfAZAgyNuS5522aEw
JwEtHbmw9nGhhsiLTBmC22Ry/mNEJXpEV/LgAhkFExdqPp+En+nMk4EGWzAheMd2OaHwe8+V
b/WMNMU42pG+tFqWSgoDkBV6rq8QtmHVv2yJlnw3Uo4w20sVcbu3HuJMiKPpB8Mu2f/knMXa
JrWQGNfJxckFUxZChDnMSJP/QG7BqXJHSzitrnE+NAe5y6C1LT834yt09LXQmftRik/jwmGx
LFtG/9SFKyraAhKdZmRTEXXl9Hvz5EZ5Wor4RzthQQh2E6E7l08+Hr4f3Umo3ESvHUaTOZmh
yfOu5m9ulHM8btix4wITCfd7a+p4q3t8O3mT7rpqPlmsIwSsLvF16IFdkxyx0o02rztiJj4l
5JKsksIM5LdkTE0qtspxkdiNy0FBVO/tgkf9Xk/wgaHQZhwTqB62v+TYOgl4XlsA4p3r3Gwm
RZQypg5x/x+5xfjKos0toxuYtiUsvdIPEYliS/6F6UPSvPoj8rKErrNlNfKAclPaTlagRv7D
0czZsBWyrL1fSjNEK1YiZIL7uZZ3vD1ftlLI6rDSgbYbGZLrA1vJltYPx1rjKHFcYmVkRcHy
gS8At8WTkjjPluAqM50qVi7UAR36D8ekq+SjHVD7yubyfy9XmTLq8eHgzuwff6LSfsPpCp/j
w8q+E9xq/0XXKcVRnS3QDVCEXGrewoJ5mMzRZQOFD5XQ0fbWznf2+B9HHEurhNTYLxYtunq5
q29r3+c2iOjBrn8NAxGPRs308Hjdn+P22vUn2iuy3GH3NRkWQOVohVKZJbFjGIRbI6Ofb1uB
kzQDG4hfGNv65a5Xc3mss3whIJLkQcXwZEkfV0LHPrYW0Bza+8EeEu4h1ty8gpnUWylNZJDx
UzAfB7zhTAaEALX6Jfdv1zILw1xYmqeO6Dpi0upA7Btyh5Np/pRcnLdCsfOK6nSbB5Czg4aA
nU/0l/IVlcDLnplafLD11tenOBVGZCnJC9wqVRa4WY/OGLt82g7t9puT12R2NuT3y7x94WHi
gdZeVSnF2Q0dki8o4nYiHga2kALP2U2JS6I0ZjjoYjxdn/DKFda6EW3j0Q4yZdnorkAPAOMw
zlgFISXg6sWdyR85H4M7HnrxYOZpipyaD2EvqEbDZElwmPiSi0z6JGK5zbJmeifwEIeAvcbB
Uzn1bQZwSHoFMUfp9AapAbj5Iq6xkgkG3wUlltbN+BXpR7c47BjINYduyq5pRvv4ySl+K6XW
FKtq5BhRNQDble2qRLlyg/99ZndMAqqGXpP+CJZCjbgcHqRqTYXw6iBXKQGUegD40yKfDaj4
R2f6x4yc0Vkp+tK/S1Lnbo0mL2W2BUC88/mc51oiXgFS6lry9otGkRL0dIWZWXYACbkEca5U
uiJcr215yUFiLJs395GhEObgSyxDQYCFEDQunstX/2+WM9kwIwpz0pSJhhAnbN/wBU8UcXew
nBoIOuszBYw0AhQnBchB92KQsncRlKVNnf8W4wNJwANhjs1tCBdcK06nwvCVeadHL/4H7Z04
Wv/LJIzWI6V9JCK4t+Zi+ynyKUJoSwiUsGuZyldHO3NDDb7q8bMWfkKfCf693Jk87Cqm/9iU
Zj1EM7WTuSEfRK8fewJQRs9S/sBG5pSdS4iBvhIYf1iZGsgRaV4ChUwRyFOmClyCKwbYDf0I
8hI7aw/qBvhq4rBRVkMpgJpmpeFLVN1iMkTlqTC9Uja0noTwtmpHayq32/n1wEiFcxKF6lDN
CcvPZzrv2t1dY9qT87i9+EUbifdH8VAZHwK93xfo5S1OuMLnuX8PPA9H2kknG5nFo5AE/7X0
+Gn7mwW0Rgj/j0fBxvDgF1VGkY1VITZVogBYdlZabyEaaEGsno3VsW/3awp7uv5hgybKJwMT
3v+FZ9brLTizOlRgR1fwxN2OgCkYoRs4jMMXn/oiQNUraoYvHZtx4VZg6rxolE1rjzS/NTxu
bpUIA+gDdM2Rpy1v8brrgfueLXOnJgiqbW3UVH4Asx43kiux8ZDjh/Ik8S8bc0bmjw6OigNZ
qsXHqHoC7x3nll6Pxfj4CGIfi+kEKtGwlrGn4T+dbv+ur0MvfNyqQZuv5SxUXPBlhSgiwxPz
46lNY9G+Vy/UIZeJ7mMegxv4QLaIa6vJiAK1Vwxmm0YuEyMW0Wz21i4VjQ4jFGJ1O+cEDJnf
MLf6yWkaBPsHOa8W/01WM7RCUypcMY5yuCtz5rbC1Ll1MpYm/zHpiBKRuA2Jmy+AB+dlyGjB
UH7rJBbGp4tIiH03bbzzDoVmGNtrBYnn/CwcmYvVrX7Shdin+NrPDkULj1xqwVaBuuw5/XKE
zDxA/cjxo7PKV9EkP1Pj3B14s5qUOKj4XHEwRN8UOwan96dT8dqlOd6LWyOIv99pqeg3nyB+
oXNqeqgV3DvoFbVEmXrP9uVK4xB6u2NSe16h8QraqcjlP7reOHSGaLbINF1IpFqR8tcuKlqr
vg+VXWbzzz68cn1jQm4Fwcx1fBdBCqiB6r3jzqTyGIMEMi2+DwB57CI6BjfpPgo04fBaXeZK
RjnGGBjCVYIBm6AGqWlLigL9rQNPtP0S+5pTYGZ3+ZBFSqtmbzqMdjbw18hnPFdqbmw1St1Z
uFyayj5a/qmaGpns3AGcL3u59GMapg3pbl8/CGJqnMYmfCUOU7KOwyBCUh5Ly0R3iiVd9hfn
8Znn7cgpdqH0hF98WfEeni+r9uqPR0IZj7fLJLloYwjHDTXiX+G7OIugn/Bm7e/qm/vLvU6X
sgnStk/TURXWLq64NuI1Dx2qKJnh+xMXAVxAP6rCV9BvkuTZZ70rb/HgaHuWNJofjTkHQXe1
WDUTxD8GhN93m9WaXtRrDw7DXrmqlpXISZl+YVzA3UPyPNRI4L3h1pwWH4c5buwm07AoIURV
lMvc/zS1PL9Ak+vzhdn5UZHWVWWnpZwKSu3yRKvw5WJvtvGKhXMJJOHgMTfcgU5JO4P49Ig8
swkKWkiw4OrWmkodnnyM3eCzEc2g55lJcn9TxACRuK13+CSicXKBki2C/GY7x4l19w8Z6ttN
GFwSN8IkIFDN8czMTHF6ZooVgRZZ5GW6RFOmt6tb3nKxNFY2Kr+IoelzHsPF67JmLDDSbez9
fQVLtsar5U+crJnSS9kAp7i5cD0aDPvjVEhbBVmNYLB7EpZ1ejfA7xZt+Cb2Mn8189ZgmVjD
M4jYXPko+ihStoSqlaVa4rZlXTbaorywwDAYQrKJDA9yIW7TSvoZEStkObqIlL7Xn4MrSQI0
Hke3z/RTJGQlHp1CwGGeHT6+zpo897E8Haht1ABVXbT1l+Vtap2S/ECuUHFL3ecMJlmdxY6P
n6cr5eKA4tfSgystJm3UDC93s5S5wRFXZ+hy2tQXKD+kU7fup7EV27t1cBbhtc3PeU4FPu0e
L313uPfErVXwdSf+3EF7hp+ycI5kdIIu3iykAC1LJQYedMc/IPVIxdVkK2KbxngBw45AIXlp
wLse1Mjo9keNzbdGbbKRHcajwmIDDEZEp+MRfxLO1uNHOJPJrOzFIoA+XX1wGLvmqKPVUwrs
T3R3Xys2i6AVI6aEVvCosVLxVmFvZWcx7tis8diFOba7JH1wT4yfHjWcXyC1NfvKPksYJePB
p0imjsjvCsdrh/iuLanF7ikZlftXBcT3gRz8wsbkiIfT8cJJICEiXMzO8HtweUXbtDxihmVO
eFcQ7eVT+X91NXw5pv5ru+nHhvvIfngAsJ5dazVFNbo1BHV7WOM2CA7TcSlnU2aN+oYKZm0a
slHAZ4YN+PAmzn1Xu8FnjgFt6/2WAvXmU/ss2cAnzK5/iMwjGdOHsqlypatfe+yIhOn+pkkq
jXwa6UPGvjbS0OSXSMCbefHLFqgqJ9xRXWqTSpVtevxszVV2AB1jNvRzd+UKJpJp6Wd6Ir27
CMFZhGfU+a49VbkQjqGlSIBF7pie5UZDbMTG2QHOXXZoff7xZbWpZdAx8rc2Az/uxSSad59I
xyK8/XL6u8P1si8aLm7p3Qni75wHtm6KkE43dh6Izl7sHyCiF3NCOxNqsV3jLTaqKmZIbjB6
RYLJbTZZ/e0Pme+TiPNZxFTvfo9/NWvbQhC9j13h5dm7C0UbBrx7KyP0vKL8D6fCjFrGckz/
EvqOyb2zgwvKeIkuwqn+bI07gdud0MIhpnIAVD0wp5chX12DlV/38VKhDa2LgThY+A0+5yBJ
cQXDzEz54CPG5QPhVJucB58x2CCpGSb7OWRprPrnb4SfKxfykoe/w5AQR6crNZHZse7OHc9/
/YVro1R/CDV6DrCi0djqbgCqSF1E5kCvEZ/GrjuwQpd02l2bE7KvH8RMyZTB9sYbGxA4AHiZ
9i1z4HqmweCohKlFgJX4OoADOrYkiXns/YW/9L2uRgtScrkGpqWhWoVn1iDGWXWkTwgISaiJ
xc58ubSE9xKYnigu9oyweniBmKOLS2BODXrw7n3uRbMDanRorzbvKOgUtyksUeOGWgNn3cIz
YTxzcrJjozGuGUrrUkxIsBU5n85EhpVF9VsIbtl4TXaD+72egLa02OslyW/ePUr4x4ZzCPWV
WxFubTmyULHj4n7xuBs9IdhtnEBdRQB4UKFydD1FQ2A1rAcc3oO9JnkyZAb2QPuVxQVKk1+w
ULZnjmttfN0cx5BxHUt//ba188GmCmkVDZf9aEnikussaChc18uL6vbWE5lQKCKcsOSt+yGm
v6/6vZsyEHOwtoHwlkiVeLZF9frlrwdAtHQbzJcc+oJlvDmazqS3Qo72xDVfeZoIxLEiKS/j
bmNyHRNuRaQHK7hUnRUq2FdQCwrcllI5+Nq7nFgJy1pydSyKYubdNDy76LDbIrIHgfFr24zq
6oBSv5fsq7Evi+ja3T4oh9avTbU0pMTMERQhPx939fh+CG4aRa9Uusfjvm/NCMEaJhwu7Y0c
6HfewOqsPI66ChnQ9gZ7417QL1DOCs9n8mZY7eD8vmRLfnBPmB8rrbtW0HRZRvD8hpaMpTmS
1uLBKzOjoo6ldwcrcHmlpWZBrh1hXqm5sboEzHzsV+XizDGkKYyPhXg8buUAwgSOVc8QVX5H
kiff5vwuBHhHnQRyqPxtPgUO1vlY+0+6MEm4gyKn67fxt5GdxeqpLiSY4mn1RBjLqzsj3SZY
K3/a8z0LRLkkHAKcHQDenrCyhUD51ql774IrnTZXSPiD28ibSw+N42NZz6gYmwu6VE4z1Vpr
m+Iu2PKR7lafbI6N/bVbeNW/iWUHuQp2M9Pdsq0Gr5NMue5ZtuBkW9lHzwkRGdOxO+NqHMDB
FY4CBb4DwFj627OX6CLS8B0aFsOFoxxudDHCo8n4sbqdZ0U/kEVcTzAOMFlF4PAeT+wqE2d+
vTfDuIbIsMSzlzNPGMzC9zI+1m6KSdkSk4S4KNNoy15wtsmx6EoHpDPcQgl22YpD9K/lOv1U
C3Xfohps5sTJaUMz92Z97oOqOw8FBIX+1jt9AVs02p2uvzZ5g6wXKh6KdQB9NYTaXj7cQ/pF
bfjZbrw34Znt4OIJIssWERyowj4tgvP/AkN8ZPDVTbc7fD2vp4f7diYlIc760kJ0vpFLY1uk
LAil5jLdTOdJaL8H4n8sz58NjpY2x/Yg4X5AcwFbVvHPhdIOEeqIMoQpju/T/1NHsPa5jCFz
YTkfWfnM1TECa4vDdZljez6yw0aqENXCjgER9m63TNN9QmVWTNYjAvCjDAB/KsNBNGi+6E3E
Fip2tk3m8oXosrl/7Jmp6WNL047J+uu+aaDs14cCiq3VOQgoQIKYpEnUIDofAKoHz/qYiXII
JythufMIQep3nogUXLHhKwoXI/hMjhIV5YSoaGDKEyD1ZKQ+4xt8BPpbTM+QGdcn9C4yx5le
tQioW7GwhRpaWCZ3B4ojfcwRqP8PGo/EdM9JEEbe6Sw3oa/rtGJ2ORu3oTHopk2cTfE0OZLj
Ytx477ExxEeKCSNrW0kklZrVmPh/QqXIaE8wwaWcFo7rp1uH0/FTvXw3dSg9pbjkwbyrQ1ff
RNgE1sWK/F+0bRSbGMeM9FZKEcTonMT1QeOnCuKWC9QqEzVUu3CU8W/rL3e+2ZiGWsoLCnJW
PYfP5lh16+LGxjXXRzyK8T7c9U6WIzJlej2YWtUlMkIWjSi6KjBoz4X2YzaBy0Rh7rXmBFnr
H85ABNhRExFY1bBVOD6Fmoo9CPw6HSazw79kr6ikKDH7p5AznKvhrUvaGsKV4c8eb1vkz0oK
8Y+vfTpQ03EOFYp4EHhqjuFXECftdjElvBhFSBlCvReAOFLx2QWDY6ZNULrqDjDuo6z7f445
Kcem+1nSnHTh5+khxVR3Nxltu926tKATu+q8lVExpQMZS8OPdhOyixd4+u7p3iBbGPiqEb99
NXwa3kO0H8leH2DuD4wYFDmo1e/WhWN+L1btKxnbiEynYTu7QOFD5aDaHCAoUBo2pmFPiSEH
Kk7Wp+Pr/hlZa8llbBBmNk28pNvVaOhmSLXSGqWgxy60/kiSiExMAnhhabVu4jMVfuoVIwEE
PHSjG5VIZma0D4YfhtwOXSOtWOqz2u5ShGsFWsRkXjsXSa+Jifzwqc0Q+KXLaaLDIUk4ebHh
n0wv1IH2J9yswPqQ3DrYRRnbC953MJ0dCWJj+E6+bV06aftlKPbJO3XPvS0MAtE2GlGR3mhl
9nie9ggvtoLC+waGZRjOl0LU9JdRc/OMzLE8BYc6oQMauZwttB+OF9mzXj/iPxYWpmxaXUMt
8qqSw4C4gIbWiB6ycRjIbz6gOFLEgiQl8DtAHL6K9gTkWPnGIti0bCCbxkeGuZ/sSduyB4My
JVhhJ/f1IdvNaB7lwksDzO6qHVawDcpcjBvE641xErlJnGLTd7f9MhUnb747sgN82wBmv6dX
pIXW6noNZDWc8TxRVEBSecqEN0oFxbcmwV2c3HGsUD6UcQAQWsvzOpMEqCBM7m8I9BLb1FHu
qtQ7RPZYAgguArgOQux47iue5oHVfDEu2LdcLm8vyD69fjDUpT9dIN/LjDJmqjjImw4Ay9ZL
iLMRdtKzFehX7l7I/G8aFH/dBmcCTz+k8uEvlTlH59SKPox7TLk1Yx/rBCfsQW4LiiBHrcJI
nOhWQgSLB5WVIsZ/TzFQqAgLoZODKV4oMjKdF1rT7XcPOpCSyV39G9bVqjlZRUuSQuYVhu+K
8cgdgLqeaSwSkPMfdInjgoFY6yntzDeST+WrLDBch6GSQgD92mhhcLPmZt8iahRgpwBsqlHm
I6gPsd30DtDI8QskJSRyda3uO6y3mXGPz60sn2E0JzwBHnCZUKryuYZtXDW4Ewa7DCSsl2Tk
ncAsgiY3EDrIFX0ZN4z31aeCLn1/oJ4knRYiJTXaCn3DAPLdzoisnUWntLT+R18Waf9lcgql
L3usLEhIKAgYrgFVCFPV5qAZNS9NIhEUZQXOKCJ9HevNcoSCIfYoQwI6oMnPYZnQ8NHXJhkn
tv/m6qsmkq7goOzNGhQ24jJyMkoVP3dG1jgTKJtfZ7O5sMe5Ew0brY0c6mBpibAwlpifKd6g
7Hi/JrH5zAWjwqbK9IHT8pvZa0FkjLikYmXOlgxr0YecR/pSmEqrbhhYzjFSf3KNythUvbYk
Ixv52cFYwDSdqnIjWfFXIBxxjyS/jjMNmS9PnT0retX1n25b9C8LnN70Jh9g41hsljT3FiMu
cBKDABxAqJb/o/mZGQiL48v0I2lVvgNrqkO09+CQjIARueqsB00NiitMaWiGC7QTNX4fkWSq
m3jQpqsTF19dkEiFoLKuNio7kvK9dIhmOL/L8nrTVxqQnil2LQ/ZEML8zCOy7cnkd67UZifZ
+LFQXCb2FRBiQm62ZJz6j/heG8FwRm7wdVen7dSR+ZIfPhsP/ej0IXfbxNpnpqLLVkyScRbr
ZEA06EtH0a0FMvEOdaHIGXYTuymSgEcNHO0q/W8UblecX16uqb6MIYOKrlebgUlHxSqf534j
gqtRQWw3wP3nvDM5AGZwn9Fr56sg9c+dm4LByQERLpf/8g23ixz5f9vm6+4x1nwvmkeJu9PM
Y1sZtOc+Dw+w2jii3N8sfJE6VN8rc4DxGnB1a4gJ2llNjc9XkHv1lrfem18asf/XRgBdMrtf
LKSWuAv311EtIGm6RB6aJtVt9KeihxzvSuQlVcgDAXsS7qgchLbL4waXHdvM+iw64Mevr5hQ
0P+CNrHaxQn+yVu7crMOF4WlYdKpYa5ipq9MWhbwna2bC7GR2ACxcGHGfInggoZtL10HmEY6
X7ebBni9oKTX3ZaA+nqb2F9m139Dx7Ior5vNGP4kuWeeDRX/sGOupBn38XbReetvuZJmx5YG
4UIPlPpe8sbRi/xkLS6i5N5R6ozmxWAyDinTYBip7tsrSvRzrjMK8KV5YqL2PLUnbq/R1bod
vrQDhs5UbjOMuzIoDrpZYeWNJxWJh9zFaJXujot5q1qKJEm5cAMkuJ1p9MAYXGhasUvcFt9S
m6bO98lYFGsu81jQceuOWfFGw/KnfWB1O7hWz0TcdmGQWsU4F2ScbLv4FS227Kap0ywayyhB
DcKBXNHPrjW6dusfVZCrCc8ygjjNhdIKeCMYsoKHSy8gbAIU3nscoWrOGXctWzOSzcJRJahA
JRMUxxUp1wkjiKR5ycYYuzcddQdY+QOrzsLZZe45dK+ei1GsvS8pf/UbtlYMQ5k1EgFAkce/
+8TA8jHqYEK99inZO7fpxyKxEk04w3/nuk327btfIoA+q7Kjmlv9oslHatupt8XP7vu0ovwf
9htEazXKJYY0lPI4MsIExbhjvx4qc2oRhUXL7WvaXEH9jy2odlZEyBCxkdc9rPnTYrPXyl7p
lvsZ4Cbs6fM9w92Cg67sqCYgK3pMf5bRFaQtCZ+yCvqEYlBGol6R1uZ3cW5ho8ohM02XsXQJ
qgZrzK2jgS0Qu0F0apJ0fA3MQQg+eM1Lwg56s8Ng2uGCfPtD7eUeJw3DW+tgSPiR4vAtHVoj
GLGHT8W7/o8SU9fyzzTUb1xQC8DeVGu3GLr0eyr7xcBaoG3vgx96Zub26Xo1Lo+fXFAFGsU6
lcT/iT8/rywhYV9aFrQXz1QiDAjvA+7SlvbfPBpn4qhesXynwrrmGxASJPIntrzZ/XyUisAf
eheffbg8QOmadbM9ChOmjblcPsgeA0gBzHUCTpS+2LWclw6sqsy7aPARKsA7lGvRfMECnqv+
SecUEC0XtwUS5rvF1AiA8LUrJgldz5MKIqcNehKbJDzc56J96CrElsWizYyvcC8MFTI4SZZK
PbhIvLDEMW9H1XBGWEl7NaSK51RI98Zr0q6VjhIgpdy2YLnJNP4yeFBj/gD+iMdi1KSfC8pF
PEZy/+oLk0nd4ANHrLTX/p9noPH16h8C4bnXX5b6+P8O7R60Uii/l71XXhs6A4ewkApUef0/
lDN2kmjW3c0BNRFNgSCHMZ3o3wiYaT5b9gOBoGQxYms/oHnwEvlMpuB0kethiwmDQTCP0iwU
zj/9bj/1998Qrv16CRvV5cZZzEikBNXXqtWu765eerM2OsMN+pKVXWrohPP1SUR6YrGvgYo1
557all4rp38/5c672LVsNQ+BTEpjiqHnOzv9sWOnq4eW40NmT7yeg1Ergfy4ICzgs6OeB1/S
dwhJcgHfQlKLzjF1gmvrPuyFpz9sIPPmeHYxY6IJPv4QsCSQzV4tyEjd/53gxabUwM12ZjP2
urRaXrk1UTDxhUf86GYdOtaaEdSAOuMeZk9srJQALGEK8vAAkVy0Wj7QqNKKumvbSMkuI7vS
gqQCfIYqmDCi68G2jw0mWHJZzdZRwrQjjERoss4JzE7SaNJ8lZL7Fh1qpm3QfvfOtZa5KSzN
yW0lJtrvrf2hstZZPHOQdY1De7hNWq1qMNPgGKJNUWmRfi6kzuNy3x66P2c9ECo5sohNwvs8
+ZGatkheAxOLv5Zy9jQdKrTg8HSDbdN19oV+JsKAaOXJ2Cm/WD02pBQKWy3Z6AMML6HbIzKE
bAb531gSQTl2hg9qv1ebERi6tDlvleXiwLsdzfKx5jlu0BjxXcHuro+s2zkjJLqEI3zaaybo
FLacMhOdSEudJf7nWlUieIZeZdW1dxjOuJwqy0Jc4ytVfHMa9AHk2BqQr2D0jVp9925WhbRn
bdoxsHYBLxdFALxG0h8b7bdOgy8ukkyKxbeI+iIW1Uz5DdAJ+4Zxw6dZNmOlbyxnFYC6LrPl
8BEQHXEbJ7cy9P/pC12HytaWocIDTmaVj7CU5Gkki/ms8SS6XXGIN3NM88TzIh34gnJdSs4G
tlZ2xkt9rCz5petS4Z6WAGmNVA2f8HFdfLTdSfk54Z7yZ99VFFsItYVzrZAex1Xnl7bIWZg4
lSpZM0bX1hBDdKHyK37Igk5LJD46v+7VWqdaR5zDtbOpHENParHExmACBqxeASdgEJrYMSCp
I/gAz7b37jWT3HRLca1hs3tWpA3PUMXg+Pzsdi3XXCUVpnyhjf6SrrN2s8g9JktCKyAu5YBD
jjZOigTMbUDCYfzc8NvNTAMOAsaxyuSAItLzbpU468he/g4+5Ljs5v8BPakKx7xoP//+sckg
yvmC5/twaIgDDpIWH8Xsv894CorvOn3m/aYZGULpf2WalQ8ZijFLCus35eSMBwl7WWczReyI
5GgMIqGY3Y9Vt6ZZgK3IpJV+M3Ph2sD/S6YzvwatAuk+Lqa65BPYX1YhR1fQ/EKMPZHVyYL2
L273nAz9Xf+Bya46Ct44PQgpkJD+N4Y6ZSNtuqILUi2mCCsSnQYmICqSyF9mOJU71HLgK9S7
jHP86s5z+ysiCzs705S0jmvYg48p2bxpbg3vXvRglkZf014dKSOz8rqRWjKr7FZebRztZ7gU
N/nNz9Q4o65ohoFwg/URWvVWipQyN5Ugkib1Ix1V3yeOR0iogJpLrKYAh4Hym1OmVy+KOHZ0
VqCEQW+Y5lFlK86CT2Smzi4VA0Whf/46n3NYo72HUgzfh0iIgnU/+EMTkYDalBn+93SAFgiH
pfm+9Isw9KSM3946DJmhxsy+GbLt/zeQ74Fx90EJiKhoDy0BaWTUv5kbMR59q2GTiMm46xT4
amyTX5IzoHJOVT4Uy1OHH940CkixP0q8oNjT64Y50AqN0Vlt4JVr6YiG7Izv3tiLMkucgbkQ
y9ck08QBBYvRQtSMWbu7vngxM/DDNp8hBtLqzKgvWi5mX/Rd7BQcUfO9LcywqUF6W2gsix/a
ARIULfnvzAmNVa1c0k1OYXMdCLoZBqt9rqlHZtrloEL8uNW6ljHY8jDo0cZWlggQXiFWTyVt
FrQYtbvPvVKSdEpoE9fVswOM1QKtqZSIJQz9WPwJ6r7Kk6Oy23oAR4kRNgqwef8TgbeBnl4G
CfzdUDIXFbV5zklOny1Fwd9ZhgxT7j87etqH59mFgHsI6l4H4q0fNyNdzSkyuhjFMmYBfX8V
kGN5f1YOLNhuv9u305FxO0j0Z7UmK5Fb9DLk76dYhH9hrc/LApSu6xzp+4ju6RLZUET9eALp
8D+5mq4m0xuoJzA4EwFuc+/FRW6HU9NLCEqGxNwIbj9OdZTtwqFOkyd5oNxvZHaeiZz4jMGM
Vudgkl6/swS2N0YlX6v3KNmqtihv73+DaWlN1cg82VrDcUiPzbtUEs60bRsrUSKUOZ4MJygV
xJn+phXR2mQKBFXHXB3NOPzjg3Un9mGFTi8rI9sRMbCLYygMMYLbrNYDYU+M+3JKyNcZ+bEm
3TzvLHzCpUCmmyg0Q9c3a0iktCvPhnSvTLI3EAeBcRAhSZlDBZRkFKhX8lyKq0BxIUuS7Ppp
Es/YM6IdF/5LAByv/Gfz/geDAie9Ab8dV8OUeav7bBDBPAqe94nhEkKKkoHKpwaS0F8GOPoO
u4Ug3j+qrm3uXyKyClDMOeMR9RqE31S91WJqxxuCauu1/blYsN/iaTaEJtR6LfR48Gt1MFW7
7UjDANRE0TYvZl+wk5KoGLJ4qznh02IDYT9WVLXG69EjH3gtgOI4Z5vexMR3pEkMOzHRkRTI
52tLZdKJfpSah1F+VU0e0DhxKPi2gRPel7arhst3i7WpvcXOWCNvEREVa4nY+9vrao5rEfHJ
Tz0lPy0fh4twzMewOe9ek3So6ARiPIlmATlcmu/CFYaSWuJeXQckWhVxPq2oHmwoa5BudmMa
vSTdQkzOdnVgcLf1h9GO3+7KTsvdrYjD4SXlAHk9JQunHaX71aO6RRT3E+Tsm7HbB3rQpcBt
cWjFjQLPdmNUN5AeZAwdFOKSBo9nFK/6ZJGKQoCVFytezB0BrBckGX+ohsJlsdwz4cfaqkBG
Pa64hSjyvBDy+bXJewKi4gtutwBu7JjT9Q6JSf7EKdXvrSe3giBDzNufJOvND6RozShesxAj
+Blm2O1z1N+JCZ7h3ZM9OFi0erYuVJT5G5j53jK8MH0fKHh+oWo8rQ5HfiRvaup/QfaYidkg
JVfTJhKxtaPgasqyxRqkVT7ozB53uQA161lxZMGi9kmSVWG6LvxpLmBILuJfioPrjjR+lLqQ
CQq6O8m8OlG6AQyGk3l0eMbpQWeMUGBCplEHtwIS/SQzM0ZPEPwy2ePuWRJ7ocZ0tkkYr2Jh
t/STovjSn0lablBdPa7Erq4sATR4d1QRez7ezmRX9sjjh+0joeyc0AzsybCnOcd951X5EnqJ
TTWUfaI1swWivKp6TblKCnCfXpZGu42D13oNxmPwkLPn+YEnMSv661AR+OhcLiscaOm+VeoG
xI9ecufaEV7zsdtWYWHkK5s9yU9jt7d94gsBB8eEFRCVrwMdRfW4Fnu5BEiL5Y5JaanmnWJ/
nSauJA7m9vK9QXY40LJ6hLwAgK6+aNq9uBLmjrkmczA7ZEYZbEU/gm6yf1mZ7SiheFqbFATv
rafwvQjfxn68ShoElJ4jEX63tESf6I+SIgQVOX6ay2LZWZV0ZXUsGUJbMBrG9vf+ZBQqn/PP
SdogBNVw6QCOx6A9LJb0YWKyLrXrZ0vCsRPSmbqIzu7i65mO5sMo6tpGzapFJ15F2dddZlUA
+0PrICL//REBVgYvienx3nrbmvBx9xA8v3mQWmCQ/nIcXIMhfoTqABS7AI7GyWHqOc/vP/vD
Y9RD2rqz2Mdv7UjecB66d2LTiD1Qcsok0pVDYX0sQvu/2/7DQpMmUdyKkHTIXJ5OTP+isseO
k5rn/OhKumvWOuPVBp1RYPpjOXgURauQs5kZSl7/ZCjTDk3m4cZ0mtT4XiDd7pxEt0+UWPKA
EexlkCJLbYAm6KoI2E2R9T7ZPZ9qezjUKmvpXz6t+EFe5PGf73sD7fqc5M2e5LaVvAkNUoJw
zNpiBvAP9oeFnFLApd/j43gJJhzPScIVyXKy6ldltZusx7t7Rqsin5BTSYm1NGla+Oxx/U1N
rDw9s91nBFrCrphU5JWMuauEbFMoxBIt/tKnOlU13a0AD1loa0g7G7pGIFU3wPabf93jXlx8
+JrazptwlhbUtQSUQO+OpZjy5J5bi7QM8XjN8KpLZ0+NldD5TiaWHY/5eh3PIZrmfQhJscJZ
wn88W64rxiponblGTO6mKJyHTTeMOGMXTnjQme78YPW+TPNgnc11UvtOEGnXpaCYw2I0gaj9
jDXWGTraJpPCZvw6nyA2GayXWFcd+MwySeUkthc3VPf+JKgkNRzSrd+lHEZY0X5LFSKgnmJJ
XeElIN82rbDSUrvVNVoNUvWBuG4qmojhzi8b6wWAIhc3lnJCQpP/EutgD7jTydY1adEtv3aE
d0nCS48dQQ7gVvfgvCRqwkC0fz99ycm6bCpopczJwaujLKFkaWnvxggtTbKlw56peC4zOCLy
tsdtfXeyMVOygA6bH4ndu97on9AilpaxnheES2a3Qjiv5F3ZaCyt3LPEBItLq4XTM07P6d1t
6zEicuVF0Dqr1nPucTgPn901Zdums7t5FTribYltK2z6kO7GZt81MPNucpd7S2PQoJWRDx2R
NQX5MmyiiNeNbqzeKlRo3m3XiwSGDr823UuRuxP2CTmw4l2Xx6xh+vGSz8HpTdIIYHhcCFjl
XJ55sKRM2LYT4Nq1BK8WXvD8HQS7pfh5aEU5ULXYqSUZAlcdw9A+OJWXqsuifrO9nsXgviuh
MWK5LnfoixXYJ1fFzs4X6FpFNkIvhqRHhlFhVajJuk9jAXoCHMRZQM+SPdK3/jnI/Qm8PSQI
28FxIM6/mxdhwDfbhEdeum61QXLYr3crQ1VMoeIsfAa6AjgbNOZSepr0tojGvbt7uuXPqgcD
RBlTodsgKMY8/OXS+CqfTVwBFuy4Gq7osRadlU06KBKse97fCrkxxRbCFA2MD0aWVJdB1kit
xWZv2jNF/ZL6eh3dIGMfPcM+iXMMwPmFa79npCfgc/3n0jmhL6MCnvsrTaZXXtNNNksdQUIK
mn8j/vdzceDRKrh0UxAdSXhcyK/TZKR5RKFtA5V8ozhxEepmVXiEKhAh9LaETBjtsBlJ6uvO
Ts2XbVGXuhl3cNBMukYFT+tzokeVW+F3h55rnZ9POxKyveQoCNAcoHO9s7J4PJLBA0pl+lYJ
tokHZjUmptMrMVWlRQSVPRF6hmy/6sxXUNP0F96hQLTEZqfS7F53C40cUAs7eed9fV7vYIF6
HMYDQqqGESvdXZagIXySkSok0itT6p8FAkl5axWrTWxD641Gswjbfuf1bFQzeONZ63ilJr48
Ur/sPx8wld3cZkS7Z6zrdIL+IZawLmYYunPf8ISteV97Ow6fhxGKgCN2ux2O2OHJwlFKOqwB
bn38OMczgQEQZTWrJe9KS9DIuALNh8gLh+08Y0uAoX84xt8pI5bJZOpKeURJtCjqma8mZNvn
9vPCfcHJsI/oLcHZz5gTCjThEdHCD5dqmFSOFk/Gdi5Do9njB+aHMSmV9AdznY8EcrN5vma6
uRqMc79c3/3ttpbwU0xksy1Gxh0qEOjOBPtbOGdjevlLk3lb+q4UJWgE6zxuw66FATONrVP+
5e8dyth4Na8BScujiV6knbgFZIHLFnoOvPH6bwwTbWyiYA69IE+4ROfww7oNI84DKilwbpf0
Q4fcAXZ7pWt9980mMMjX27ASv2T6acV3H+EsakQ5WKzJhUgxWNsTP4Jh39wXRBL3tcicVtfw
LhrpnuS7zGHxX2HJKyvLcrJJoNk1PEgKzZdbsnc9eaOHRikXHnoPgtE/qxR7Ry4Y9aDW8buU
jS+RrfXVb3OboNWG+BpE0HVDvDSYkQcwPewB4J4Vu5OUHV8LrVAtJXTWnu4hzwOrR6abA4PJ
ciKvKqKaFG4etzGNSITdk5IymN22hdZPXffR5CIwH0oBjOpScsCGyC+/2xXQUKgM3CyeeoOQ
GP5mkpnEm8xaH/00KKqhV2lXEEVLH2ktGxgHb2E3Zl8qsKngkOFdnEm3xNQF0UAx5vxd8gyU
mJnfUmv002D8LgsyBnYPl2DKA4J6ItbZIZN7oQCes+CAZvdBT3l4Qrv3TEBVZGkY2M8vOmjp
+8p2V9ZKXDvw0WrhUY4/nbcRlXeZL99beXkjbVpWBGs0VCsQSXfCCIfkZ2a4gRqXCJL9yJb/
t334k9l1gM565yMauxvjSxy1ddKSB2UBxvckb5ACGBlW56IwCdN2BJP+9JqM2UkN1TIPvMAx
oF6QYUe0HavAyAjRr2WJeqfglAYYImruhZtEa8pREU8EwFOVIrh5FV4WC+wzD/n5CaK8IX3H
8pZlNRi0NqVB28/ly0Qg1N/iGM/pcbrMjki2p0wKzjhY36GvAfh+BZ7iH75wafQxaUxsKy9s
skI0U1aYSW9MpESodebMaWs2+O4FTiIzIlTypLFG8HZzP24WxlEODJDhEXBCOT80x1YwG4Do
EQ8wuIVy8u77Tb25Pp5pfJQzpCBhEe7S7ujy7Bn/AR7YqTmBUK5bdAfSTeBKGXqpmDIy3izf
pje14RUOBb462oNtIw1s6/s3f5PkYCSQEpt+vwYghzHwRaJqj+1+5/XBwriBbMpd5wwO3e09
2MI65xacGoOEJjj2J9Ey6S5jhbNEBFPd3BTZTzvHY5mMfcyUuBBLy0PmPLBPrObbgYogW9th
Z4qMrfvGgoSWHQzme9EFX1KvF8v8vjd9qj9JF4xohqf7PWm6ftoMH9gKk+hFv52LXmfbippN
PlGz6xEC3l2ohYMgmmCkLD8lagg8/yo8IfNHQW0UpR7BxR1WSFNMTQqhopCb/L0bOhm9sAZb
Chpsec/mLADIW3G1cSgLTt9lbuUpcNixEdChqT2350aK2ede00z0JBJC5CcQwEFnpu/4lQFp
jfI4aOOsC6pTlQj5+7FkUAnpr4S2LZ5179NABqraPW3m/Zey4Z48TzqWwdvfAsL7nU+XJrjD
+nB7ZbMbRtxHlpiW634es3zAhP6q1qS9hMErrGmlzNUmKm2RdorwLmQ2ZLj1TWIc+eD69QYx
2U/KxmUlSNCh9NIWqGySzThvunsFpMclTneSwVT4ZE9eL6yxkvCe74TxeYUpSFhjkpTtORCG
LBN6X5qxHvmGxvr8aOjaf+yCnKT8WwQlgyG8bNYDMueXLlC5m6BDmyqjY5tTaaBba7y6Z7tr
IJ2QQqjKfwCdRhpi/TBPVpXctb2zeFGf7/sD08HHZqMo6aVMKhrYhTVAFeZC2mPlkjHiBJq/
4ebMf1lXAWgnw8BzqfPfrhjLwzXheC9T7+tCvgP0aGL7Puhz8c2QIc5YJgeNSzs2DmYYLnYh
RjzWwDW+KblyNEZjtr0ikWdtTgMM5Mvux0LkTeZ836FNJnlZ7yrhg80suhnUECCDCwJDnT21
bQrU4QTjYhb5YBnM4uUdPAguvgVRnTafcgNW0PKjVRT5VMfSKAYMLHQm4jEZJ2ZpItpQNWWZ
iTXgJp7kmoCb4PeZz3lVyYfQ1T6yu+faHIE+vCNiEc3SedxG09ZrEC6Rsp+DPlM6ffoHgcHB
88xSaDSAS4+O4jk6ee0HfZJc/em3tz+xDdFsgnSujHTWsbMEF+J9I2Esq44pLlMumKPv+5Fw
69NQXSSnQTUXQ+98llij9kqYaXxbL8RQxk7EOS91oYpKQCvz00JaMtZ0F5NL0zEuBWJNXPlB
Kuey/fRn3WHYU2okABJwdMXGI2DmPOjgreN6mXUxCM+AaB8pLAq+I0xkAnXfUKWOQ5imTpwH
CMQ/W5MGZS/2v4bLzplZ0An7v7P5gdWAE+HBFcfi46D2QRVY77HtZ7sMwyoEZwfTMLLjZWKK
dojWLE+08jyP1OVt8ll+fcI0cgnu1pFXw3s1QO+5Z96oqAzz2Hz4d7YWJggEx1zicY4pos71
GsHlmH04jVmS+wef+jlz9URvtMCMGb0UJzyYZI8H0eFOz6Q+XAwtB/h1TJ46KZ7PEfroBvd+
zhGssh16tln7kmtm2reR1fQl9fpq/h2KgcWbnQwjoUnXgk+RyHQVSQaG2jdl7p4ficSlgE7A
WEbq6cQC6Qlwnl20D89PUOp7gFiFIAyCh+haKD2VemU4SQmYkhN8Qg8CdAfIAMpablnqiUBL
Djeasz6M2c9nQ/eb4BoS1JYNPoDk+ooXHm5s/9KCbbJz+pAjJ+KLckKbKfbwpIE55XCclia1
PT06bvTnerRb50T/Ht5dcxOd5l5S+Mck/mgoHRSfbK3ETj+njYZeEb1axONCcCmoh21oNoaL
pWlreZZa+GGLVzBYeB2wpNqHj+lav4CjCCoIOmotQNlc6C3IzsG6ABfbtc6vYAaUEvx36WM5
tMQr9FZK18rE1ZHHx3l9cKjnekQ/cLKEMEh+sI0tvtX1wS+OKjYiJTMaRVMr5/rqBmUo/uSf
YsnvotY0AEBawcrRpoIe3bFQKl7hatiyo/5R8qN2SEdDCezU330I5z2YwMohAHZbHAX5RmLt
jkJFuEW6VbCNzFPzqpYw+1+qdr4LvPhU99+xLWeEo5HvNxm6HXgV0+An6e0f5E/iAIhdRhJq
fYDTL1B2izYR03245Wq1qnYVRvGf9Nt7ZQApib8YgWvMJfU+lov6TPRSjBO5wyGky5N432LZ
94c3rZAq5xja/7/+Aztg3SsayvzlI5dAZZBBqVsMCOyDZxHYkVT/2Au2+3APuK547XcbiVLn
0vXWQXirPARccOpSK94u5U6LN0EFsFVhcH/x/bepYQzHgU6mJDcWfKLiOsxiwkLMrVcjZwSd
GJS0NY8mTxajh+mKq3IfaecEI0R9ZXyS7kz3xgLRyHSFHzvoDLdeQu1DeqerDzAfk6xMzC5l
kNX59iGxD8eLO3FwHCTH5NW8YUKUCgy4rrpoKWgow/helmr5At94s8WWCz7lgCSlu0wdIXOJ
3SNVUHaGuI9jQN4HK1GpuYFlFxCOEShTIvC/TUmNo8FlvW37xo2RA2mixq3EFtYjDNxAEYMx
WYq8ETqbiYRTgHx15J165U1B+VVWg+EZrvYJE3KGX3oZvLVWe0ANY+BKCpK+VreFFyWRIA+I
93Qk5uvKzEna3dhRBBE0WIX4F3NiPPukpET36TKeTMawoNhB4bvvGVMFIfbDJ9vqZl+dGtcl
MrEgVnw0+fUd7z/iisj1PpkfWjYQ2ZNhnS3Kvsfn1Ct5MD1kYOgPY+0El6ji1X0OCw4VhtWb
4R0t1pct6pW8Fl8+9DlSTGo+2l+HlJsBWudoIsSKwAf/+9mvRvfA17D7o8VGLkIZ+H9SJIrs
FONM68DioF8uQlZd7Qqdt1nfRzTkYhipewuDiNN6XSVcWkz9nDaXeTIgiAMOcXgSuUskSH3v
38/e7HLxbbQhXNe78P4NICo2nkkLLllyv9UutdjrKT5w6ppnjU6jNZ5HuR+KHT5rGArza9lS
iA6CJR1ov4/HsOX5GEeV1OUm6nhsQZkBWC4nA8IA583QF98zhM9W4YOG9ojS9LJZZCnoJmtL
piftq8Aj6aAZrYDyQht0tbPp0sWCLlpesWpz5YvsOP6oBXeeFpsFZ7/kGGozqp+i7BFQrU7L
3577n7ZghLbbJknwmApjlMaAXOPj2HvlI1RVUopjrSzCqhV+MGeC8Vf5bTfsRMzOgehFfjso
jwAJCNVMkhEYcVmjMISm5HMXK9HvY5pL0CimX4TIH73Ui08arixcTRhQM16a6f3clGfaZ4dj
2038PDf8PctP4LmK7w6FJ2oqZaT1k3+HHUlQlQoms5zznB+HOKIEZ1j8/qwbXIUglao2yjjd
iDGokTrdeKnEXZfakuBezzfLYvQrDhAdaCsdT8X7xAWoxsFgdR7PCB4iA6TfLMfe173W5yIf
Yr2JtrNvKUS8R328hQzW77/BIb56TeRByeNkuV82wGYcv6jSqWAJb9zeSUzM3fg7Vpc0cEfw
WS93vricWaYO8PSoRqW7uastIJlJhRNpLno3zq0l/OjefvjRvyFUpOX2jABZD6j1wxvTWa4d
S8rRbTi+pS4VSbf4VIkjkN9ioQspK0rqG6cFjcVjfDw/kGcrGVhTPWt+SV3DPnS13BBXQIM2
IbuiGC1zxHNcfTZ9OLZ9cw3+IlgOJsHfuyo13XJrnbVxw6IcjWyhAZufEQ6vAHxw0hVQlT39
prk2MGMbN7Ak92aKjgH6hnaCPzaYPayZqsLdlyw7dTfh9NWHvXc39ylu6jprViGjvzoWKcih
s1PfKVw5xduveYqwVTfoba7U8VjkUdPWzr93Gmdw+Xmvof1rUApbq7k0ZK2G3wilEcBx5Esg
I9Syc5YciToWZjDE/j9cuQBox4quxHeb2ISfC+TI5ElNwEUcKZJ43xcmktMk8pwNMiOZLuun
fpMs4sPPk4UMWctFU4vMWjSk+LxbsqrVMVRYT7w36/ThtUYnT7Yy4q7HX3+xw5LWaBcDlX9j
mbCPO/3cfKUDzNiqispxqtbhsqLuOgxi8R3HNdDh1Kb+5NIE7fDlqYZCP0Rrp/SicCgGfpA/
c1fN/egdhTbqDmv+jIcVpWtEd9+XMyp2Gw1HQAaMpKqQxsU1+Ckr7Auq8YLmYQzMRe3C+FXT
MpoOtJshx80e57SFWrSkCSeIEMibRXi9WJXamXpMtpBL2KeST4SDJ1JdEMTBP2fTD5zVEq04
sNbBohff7mPPvOFwpfFMtvUMh7GeeE+zdL+ADYC4KL6yAy1XgdjM21T+iLbhSZuE2JB4MHYa
FbudhTI3Rv1m0pb8/CjyM/EaUtoHzfu1H8/79eRqih4q77nZDN3RQeHhkc1dSmi8UzINBJB4
+qpOQGCcFtH4+04vRYblrlbfE8yEFEDBAOG1dgyho/jrs9MegamNkzgmMwMPzRbIEBxcvIgd
+ao1gfQZHqrRJQQeaLla6EMwlo4yeLGgq33jJcm/rRY7sTizL6rQ1Uq+leejQbGZhUTXXICC
9U21i6xjKf5e8V1TiwElQWn2idXZWH6+QMQd4sjiDMaMhjdakMdUxA9y3pBPXq32VrjtXG1G
DSZBXYkusIGZxmjXqBVPShCIVGk83jheNpxnPTlyLVPhTeP+dwIGOquxqZ2OmLj/dt48hGmj
EVxCq5IQlRKGni3T7oFXdQMlKQZIzPPF3VapHoPcbX3w7+fXPUAMXEqXUkco0tAQMY5RcGk+
o5iLmS77qOfKe9ModWDNunzOHmiSRwYYsMHuSKakOnInVmXyAXCeDM4iV7vNTjnSYWP+TpBY
kUDHQ9e7XHyVSrhteeIfWhNMQI15gqkENwOwOGcq70QQmoO77Vg5eN6BguwDwiPWhqfUY9mf
Jwhq7sz4wgx4W43q09XSTVgGgwW/BgrL4u/vU/hgvvliU0TZB2VNayy7PQCjLKH5NWncwM/e
b3FJL1E7f0vW4w7Fzp0k5gJ8UyYm839Q4+thUBIJG/ljcMUltuESaMaVseHUJObRcwXhnX1X
DxPhW/WhaPtw/7WXBZFZf2iqYYfcyt6dISzv3MSQr9PalCbbCWQL9hHFBnlG5BH0sjQhE0kz
9lkcsMeyzmq0bF3OfehP1gGjBGH0tIb5aGELIGbz2jJdF+mFOyMcuVsTj0pnX5dC7H7f3Gbn
zH9weUwQg79W2vmaIG8DB62GfWrC5pXOqEwQypxoZkLVyUxJDIpnJJ+6CehLOMLv0C/VMzym
PhL5CQO97IomseJer3CDIBbEmfBMcu4oN3E8m6W4+kCVz85Lb3BEGCve9KRJjAkISdg4egea
7Ko7UEsf2p6bL/vGCdCSvBcxurvVdGnpfXDu/bSi6yXbOOAiWw5WmKyzrwTB2FTIPdfAVAFs
HQ79iK29fu++ijW0l1SsuVlYE1zG3aTa61aD4c2Ks3toUgynIolNiszJNu0L7KC80emHGRd9
pUuf5wRbTlQ+8it/TyVTUVX6/oYZoD6vzVFxZBVt1eg5iTpJikU1JElAqWmn07blVLWG4L9W
LgLrDSU34NGb2QdotlZ+ojpGGpcT/B+tN86IeH/Ba0ksaUJ3b8w2s/bFUGFvH0amL/HWQBHm
S8N+f6Qsq2f3RV+BedWcwZXc3H2MguCEHOm3RrE0JdHsg4e2y1ol5B1tOCp8NEOC0fE4xp07
VIP1gYDzT+CrnlvtWCRZBisDL/T/PZJA4kECgcERcOmSSL2a2HC0n8aoum89Fi5lCxkGefq0
tlPuPRkpFDVm1GdfR4Sis62I3D6ZJ7TSvu7Al6FLJ906loc+uxbQUQ9cGJ8Du/tu3Kf0KZby
vAx9zIkxnG4xlzss+4YxzS5Ql7/LNKHxLpJjESCtyE7/YA/rbX9oak+pB8itsrNYbCFPtNPH
H4OkkdHrlnawZxritn/kK6EaVGnKJ9ti42LrIQX80u9IDunXi27vAyUVYyIXBreqAcCGLInb
kdoFIwuXtbj9urcnXZul4lQtz38q+nrENthwMQbCSGo+UawdNmcNhHQmGiB8kj271B8CsZCA
SR0COEO65XqlK4vHS3ErZQPyrc/zkeOwxRYKmcE0zcluy59wqIjHIyzbUq2g8YVASLysJkjH
4Ljg8o7a+I8FAPFfOQH3KA0sKVqXCvZswQgN+PGKlUuxvce5UocArvCn+zrnadgGcsAPVxhu
EMiXVy58nrwnX1THwRfs+FiEc1WiV00+Qxx1MM79ONOPghSWlnqM912faQJeOLa7LhXc7SJW
BCx54Qi1N2zqQW/FH57ktoMjKVn5qYTQG/mJElaqyFRlKM9g+fP8rKDnP0FqXuLPybTPwoHK
mk6R9O4nqvTo8ABJOeWuHwveUR/Av/To/zgW5eqhR+Q84nnlamy+45osO2TYD7LwuNsdgDaV
xEUQ7F9+1YDui6Rpy4qrmQgdK2eppak+y+SjyAWjY6mTtosom5CjaikH2FjHoyOjJx9DKPwm
FRy2EX6BMLps7Sfyddi5jmsCLZyJz4fqfKL8xDbn9FwjLkEXQKnllkTewwVvAQz0nTKAf+iR
qD6F/QotfHFBoR5BwSyhfmDpH7Q1S8eODvrAiHERW6wSMivjXroUz2oWm45rQQyOLyWs+NY9
hWOIM1Ula1zPaNX0qR/ZooBJy+qrQUpX7d19PkI/SUYA8BYSoqcYoacCs9PcoxhaNqULNpV4
Ar2hluHf06q8o/mBXTWEgaUZTk8xMXxf01gemtEH41F5RI/fUiIKUWUlNBst+Lw9I0JBDAM1
IzfZykBubGe6LzDTf+ePpVr7kT8cWcjeTr8YDP/XgRCup1QYK3bDrprFssGB6nZjwhCD4pqh
0+RJvckfsYGwOryiJkPJ6+04YAVSEdoH/kGReEZm2mL3JpMcp3UM8rXe2QhLpTaIjuHo7Ldj
TV5J/UlsySZmcUsnRgwh8Hd1QtvliaG5rJE8uF8I84gKCSK9dT/ISn14x3+STU4NIdaXFR8d
fV7TyOXOAuchWxBCGJuR6gXg8eR4Bq6cbk2X5UTSA22R+Xj2BJ6oJRxyJU9rDEE55jq3G/cv
9J9+XWTTIleOliqdf+WkLdOSF6TdN3AiGGZtWqiS8oUhWX5lJXWEyub0R90QXo6O95gidqon
0oImBpz7ijMP3Ida75Rxk2D+MlIY9+aUctPhY+zQ1V11vJEddCGzfOg0TzrJYHUviHUVLdMF
dyNabPWDxJWqA3zLqsTmT7MG3h5qJsrZyFVtan9wgEDHLxQtXA38+MRD/VrrFR8Ii9sY30lx
xqo+oCdfYQ45o42bwaTw4Irhk66uu5DHxRpgQOt9Qd5jCZE4VCkGnQqgF7s5nEeCeAl5DbzI
NR3Xk6wlVmSkQdJy060/PTI6vL82MG5ETPdtmylMcDbi3mQWpSNt6/3HHujefpeGbgfnZcI8
//eNkhvpwMRJvOIiC9kO052jpj7ma+7qMnr71UWWF4wwTEbNiITexKFldxH+9pWb9un5i0LA
gYKvryRKmJ+NLWIdpd6kLxqxGSTUTnKFmXwXlJBEoYMU1wwk63wauzA/efoMv1gzNR1whP75
VuIfr8FbzFx95j/kXAm1a+KYfhQgo3GysX2b2VAhU792yOc4TX/G9df+pnR9ICrCF6V6GJn2
H8+7hAYkrsgpIAhD6DeL6gkvmgGBxcqaahsa42mPygvKnvYSefsiTDyqjum2ne/QI7kpUfOq
aEy0Lnrtkx3OQsK0jpmMXdKFxadIkxRWoB3Fc1ZDCTKH5skx9cMx/N+R42jvouMrjD4WerCM
IKnfCcuaWEl+GhN9iM3T2RwaB4h8G40Cxg0vestlt2/MPqGb9dmpYf7A/WZlLyMPp7Gnqi92
7VRS0sMLNQhZ+mwHkAfnIg5+6fwqsGH3+HGiXK/A2L+wNvEW90Q+Pcfe3gfqwC3ECURzye1i
EmiM4wOmKWTTIvs9CkH/KAJCMFt0/6g4DszUm+Dl6I4PHem5jwEJgZjvTjjrxo+4U5MdpBwf
wAHJvqt1AHpZhzwDiLcYXnJ7YOs/gwO9LwtpzkUqRAs6nDJ0k072vFM7QdbgN9za/1KtQX3+
KfvPj+3S0E4+XdIAfElN4RCY5DspR9qCzC3ZfLF8BrDrmgFRRz1tS0kqN+XxrACQz4euLZYk
mbInqsCJNmo6jlbxkOtQFXau+iqzPuDiSWEWBlCD6pkOwoKIXzsN554FW6qU+XIWvAJu/hXy
CSJStMlsSSy7VOTXYA4eyCRbDq0DOE/UrPNE/2LuWaxBw1Y/CMR9zrL0ogXTkPhw+ODyESEH
jGa0sJq/9DtBqFjhvwoORnYGCkdYEpn+PkLhdO/QL/B8Ij7k6EiAj5uP1pQguzFcVcprYiB1
Qrq4OmmRKH7QVUcttfIaAKlP881ZHe9QDDiceGJB0plhoBYuvhCIRa31HrWBittHM2/Nl1jv
oZYihVpx5mgQveSl7XwEfJ+5pF66iCxsm+P9jyuhsSwH6z4PsMNYznsUlK2nv90NVKh+4e5Z
B27Ka+8vFW7EEi5euHUhP5dwoDbweDr5f1HEbH8aClHobgmDkOYxvtIZv8q9ED4bxOCcEl/O
nl8QCW5ySX8pJtpNmvH4Tx0K84XUUfbcbeg66qjXMthKHYxf0Zsea5EhkKHsxOPDuEQ0DQPY
nFWHfnQ6ZKg469F7DWdje2ndkyBzMaeKFumv5iXl20BmRPVKFg4fJHA+18vTeXA7yUiRaDBA
PoU3xeybRiko0+nYiwm9wqM0O/bJsIzmaGbe0ATxxlXf4Zdl1JUC9dED0HWN8dKgGl4Etu3Y
409qm0EUQynZHGV5PgB9wUP5go2AFiQuuB6NZuvd2UoHkawlLS4z/fEmD1jbq+txCS6pRInO
eIIq8H/9UBeZ4JnfiTxk3gYpxFm9dxU2P3T/LLxqKIDrokz50MWH/ERDKzWMvfU0HWdJbBMV
g3CGXye7pBrTDF2swpYMaD/BYASjsaE9nUSB4ss5PikmYHyuHKeJ07XLlnqWbz1GCK3IGg/H
3kyY4NQI//jIUa7cSYZw9g+8/6bgc0kZTheyd7EBP99+PoW7G4zhCQgfKYFmJ9QCctLmoBle
/c/Eod9cM1AakaiFwblsWrHs11CZqxjg9kWxPQkzMbu6wbPZrYzBxzIku5R+ByeqN9jxvntf
qciC7+8w2PBiglEZzMD8ZbhhFJ1S6s434VyTuLy3jtl3xia1R5BOpvr14l/FQUxSOBd5nErY
uNBJATlIBGUwzYEv4wNcmaPmPyXipGW/KwEEQNNibennI9ULSc4HI4xw3F4da9JOl+orG/N+
VFVRPZ8e/RlPAVtWK4sCwNin/HC/JDxMhZOMAm0I3bxR0tyu2nLhVVMT3VRCoTMjQp/ig/ix
IRMFUARTiyMt7TVr7JKBDrsB0dyLZK2YB/Iy3zgrNMGW5UJcyyyOelD67WgbrYAdNfZmtMpZ
QwbU27n04AQXn8uIOW0XIAY2l669AgpcJnrP65CtZ/MpLMa6EHsqhYG4pELH2vCwTuBjP+6h
sYrex1E09qLjsb//LfXIZFWOpNRpBwFdSwabYuCRpUu+SWgBcuFpvya2Y+ak3x3JjuccabXx
ckhMfOIdvad+wHmlrVuNJRggxoqyQhut70j3Wo55fmh9/p/w8r3GA54WzB8gaJKXrZeAF1uY
bpJ09MbLh9m9aSykzvtEPU+h8WpLvdOh459PI3NY8uQEQFcqEGGBGq90nvOGK1MDF98FUg7y
9nQLWPcsM9VnmDwDusBYhe0Twqc+mdl0gD5GrrAeHjaQPnJSlfLKrCkgbsNYrKGvp/FCp+Az
iNG8KjwE8Pn/0EtPH3Xvf2PgC9YfEYFswgHny3rbvnavkS5kzZzVWJNXFdSwJxaVWAOl4wLM
UYVZ4QY8RUJn4oxPUnAuouvQ5oqALcNfiv9Nh/nE9Jv1mqezh9eKRfjzKZJWmcF5V00CkCoz
J1U4RaURhI87DHOkyPCZ4NPWr//oEpH3WJdTKT12cDDQY9HInID58sl/bov6Hk6Cmbmq1IA7
nuA7Z71NQWGwV00Tqi/14PGAoGQSPJbsdtq3Dp9kE9Fn1ygRBGTLLo3fSB+Yp1s65ExxgPXt
bQlIIRcypfyobelnn1XJOculpyVP7XJZzThknWulRU1RtnWLksW8mtyIyyYUaMWgVEsZvpTP
jfZKvezflHbM0QmzN+m5IiXS6tOJ5eJce8AtAHNJjprrhAIGvmKSETYsetwuB56OIbafweiH
b9N86m/BW+iiGN0nvMuLKuur0tJ3Xup2zj6SazxDuX0xPAPsY4ErGcJFzAFWPmDNC+MGD7yI
syiys2BAa8QSnhy1Dh1rH+qtm/qKzaBIdjFYAmLMSNsFljFhP5PJJnXGAmdOouc01CcHwjLH
oeS+6vw5UjREJBJASOvLHzZbxtpHo2eSXRcsL0wTrkzM7x0F/IHYP7NN5blVaCkU6FRI8ww4
TTc4ogxfHB4oWPLOZM7ZLKa0G4NKkko7Gh9WKVGystQ6aFdfNonoHoVMFIlR0bWGgn9kclv7
dvg/ZKuaAj8BPS13SNY7mSzZZ/rxsmp3asAGUzzif4KrE/1VAh5G3kYzfUkw6H37rRve87i5
SuBw806zl116jHuaEYS0VkL81YUF9KYufoTlksQoZ8YqJL/o3LiNP8E/GmPZWyzoG5zWNhCh
ztaA8Du8KajDKZjTNFFurtlNkhWFH43J7UrNABVaJaH6DInQVZoH3p8LBJn1nWXmsKxWDT8M
Q0vZYPw3lXQYs8QuAIhJAM2F9PFGgNPYAAGAmwOZwxRlqklhscRn+wIAAAAABFla

--Lb0e7rgc7IsuDeGj
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=kernel_selftests
Content-Transfer-Encoding: quoted-printable

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-7=
=2E2-997dd96471641e147cb2c33ad54284000d0f5e35
2019-03-02 12:11:59 ln -sf /usr/bin/clang-7 /usr/bin/clang
2019-03-02 12:11:59 ln -sf /usr/bin/llc-7 /usr/bin/llc
media_tests test: not in Makefile
2019-03-02 12:11:59 make TARGETS=3Dmedia_tests
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9=
6471641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/media_tests'
gcc -I../ -I../../../../usr/include/    media_device_test.c  -o /usr/src/pe=
rf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f5e35/tools=
/testing/selftests/media_tests/media_device_test
gcc -I../ -I../../../../usr/include/    media_device_open.c  -o /usr/src/pe=
rf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f5e35/tools=
/testing/selftests/media_tests/media_device_open
gcc -I../ -I../../../../usr/include/    video_device_test.c  -o /usr/src/pe=
rf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f5e35/tools=
/testing/selftests/media_tests/video_device_test
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96=
471641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/media_tests'
ignored_by_lkp media_tests test

2019-03-02 12:11:59 make run_tests -C membarrier
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647=
1641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/membarrier'
gcc -g -I../../../../usr/include/    membarrier_test.c  -o /usr/src/perf_se=
lftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f5e35/tools/test=
ing/selftests/membarrier/membarrier_test
TAP version 13
selftests: membarrier: membarrier_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1 sys_membarrier available
ok 2 sys membarrier invalid command test: command =3D -1, flags =3D 0, errn=
o =3D 22. Failed as expected
ok 3 sys membarrier MEMBARRIER_CMD_QUERY invalid flags test: flags =3D 1, e=
rrno =3D 22. Failed as expected
ok 4 sys membarrier MEMBARRIER_CMD_GLOBAL test: flags =3D 0
ok 5 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED not registered failure=
 test: flags =3D 0, errno =3D 1
ok 6 sys membarrier MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED test: flags =
=3D 0
ok 7 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED test: flags =3D 0
ok 8 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE not register=
ed failure test: flags =3D 0, errno =3D 1
ok 9 sys membarrier MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE tes=
t: flags =3D 0
ok 10 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE test: flags=
 =3D 0
ok 11 sys membarrier MEMBARRIER_CMD_GLOBAL_EXPEDITED test: flags =3D 0
ok 12 sys membarrier MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED test: flags =
=3D 0
ok 13 sys membarrier MEMBARRIER_CMD_GLOBAL_EXPEDITED test: flags =3D 0
Pass 13 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..13
ok 1..1 selftests: membarrier: membarrier_test [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471=
641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/membarrier'

2019-03-02 12:11:59 make run_tests -C memfd
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647=
1641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/memfd'
gcc -D_FILE_OFFSET_BITS=3D64 -I../../../../include/uapi/ -I../../../../incl=
ude/ -I../../../../usr/include/   -c -o common.o common.c
gcc -D_FILE_OFFSET_BITS=3D64 -I../../../../include/uapi/ -I../../../../incl=
ude/ -I../../../../usr/include/    memfd_test.c common.o  -o /usr/src/perf_=
selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f5e35/tools/te=
sting/selftests/memfd/memfd_test
memfd_test.c: In function =E2=80=98mfd_assert_get_seals=E2=80=99:
memfd_test.c:74:6: warning: implicit declaration of function =E2=80=98fcntl=
=E2=80=99 [-Wimplicit-function-declaration]
  r =3D fcntl(fd, F_GET_SEALS);
      ^~~~~
memfd_test.c: In function =E2=80=98mfd_assert_open=E2=80=99:
memfd_test.c:197:6: warning: implicit declaration of function =E2=80=98open=
=E2=80=99 [-Wimplicit-function-declaration]
  r =3D open(buf, flags, mode);
      ^~~~
memfd_test.c: In function =E2=80=98mfd_assert_write=E2=80=99:
memfd_test.c:328:6: warning: implicit declaration of function =E2=80=98fall=
ocate=E2=80=99 [-Wimplicit-function-declaration]
  r =3D fallocate(fd,
      ^~~~~~~~~
gcc -D_FILE_OFFSET_BITS=3D64 -I../../../../include/uapi/ -I../../../../incl=
ude/ -I../../../../usr/include/    fuse_mnt.c -lfuse -pthread -o /usr/src/p=
erf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f5e35/tool=
s/testing/selftests/memfd/fuse_mnt
gcc -D_FILE_OFFSET_BITS=3D64 -I../../../../include/uapi/ -I../../../../incl=
ude/ -I../../../../usr/include/    fuse_test.c common.o  -o /usr/src/perf_s=
elftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f5e35/tools/tes=
ting/selftests/memfd/fuse_test
fuse_test.c: In function =E2=80=98mfd_assert_get_seals=E2=80=99:
fuse_test.c:67:6: warning: implicit declaration of function =E2=80=98fcntl=
=E2=80=99 [-Wimplicit-function-declaration]
  r =3D fcntl(fd, F_GET_SEALS);
      ^~~~~
fuse_test.c: In function =E2=80=98main=E2=80=99:
fuse_test.c:261:7: warning: implicit declaration of function =E2=80=98open=
=E2=80=99 [-Wimplicit-function-declaration]
  fd =3D open(argv[1], O_RDONLY | O_CLOEXEC);
       ^~~~
TAP version 13
selftests: memfd: memfd_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
memfd: CREATE
memfd: BASIC
memfd: SEAL-WRITE
memfd: SEAL-SHRINK
memfd: SEAL-GROW
memfd: SEAL-RESIZE
memfd: SHARE-DUP=20
memfd: SHARE-MMAP=20
memfd: SHARE-OPEN=20
memfd: SHARE-FORK=20
memfd: SHARE-DUP (shared file-table)
memfd: SHARE-MMAP (shared file-table)
memfd: SHARE-OPEN (shared file-table)
memfd: SHARE-FORK (shared file-table)
memfd: DONE
ok 1..1 selftests: memfd: memfd_test [PASS]
selftests: memfd: run_fuse_test.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
opening: ./mnt/memfd
fuse: DONE
ok 1..2 selftests: memfd: run_fuse_test.sh [PASS]
selftests: memfd: run_hugetlbfs_test.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
memfd-hugetlb: CREATE
memfd-hugetlb: BASIC
memfd-hugetlb: SEAL-WRITE
memfd-hugetlb: SEAL-SHRINK
memfd-hugetlb: SEAL-GROW
memfd-hugetlb: SEAL-RESIZE
memfd-hugetlb: SHARE-DUP=20
memfd-hugetlb: SHARE-MMAP=20
memfd-hugetlb: SHARE-OPEN=20
memfd-hugetlb: SHARE-FORK=20
memfd-hugetlb: SHARE-DUP (shared file-table)
memfd-hugetlb: SHARE-MMAP (shared file-table)
memfd-hugetlb: SHARE-OPEN (shared file-table)
memfd-hugetlb: SHARE-FORK (shared file-table)
memfd: DONE
opening: ./mnt/memfd
fuse: DONE
ok 1..3 selftests: memfd: run_hugetlbfs_test.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471=
641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/memfd'

2019-03-02 12:12:03 make run_tests -C memory-hotplug
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647=
1641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/memory-hotplug'
TAP version 13
selftests: memory-hotplug: mem-on-off-test.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Test scope: 2% hotplug memory
	 online all hot-pluggable memory in offline state:
		 SKIPPED - no hot-pluggable memory in offline state
	 offline 2% hot-pluggable memory in online state
	 trying to offline 1 out of 14 memory block(s):
online->offline memory1
	 online all hot-pluggable memory in offline state:
offline->online memory1
	 Test with memory notifier error injection
ok 1..1 selftests: memory-hotplug: mem-on-off-test.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471=
641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/memory-hotplug'

2019-03-02 12:12:04 make run_tests -C mount
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647=
1641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/mount'
gcc -Wall -O2    unprivileged-remount-test.c  -o /usr/src/perf_selftests-x8=
6_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f5e35/tools/testing/selfte=
sts/mount/unprivileged-remount-test
TAP version 13
selftests: mount: run_tests.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..1 selftests: mount: run_tests.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471=
641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/mount'

2019-03-02 12:12:04 make run_tests -C mqueue
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647=
1641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/mqueue'
gcc -O2    mq_open_tests.c -lrt -lpthread -lpopt -o /usr/src/perf_selftests=
-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f5e35/tools/testing/sel=
ftests/mqueue/mq_open_tests
gcc -O2    mq_perf_tests.c -lrt -lpthread -lpopt -o /usr/src/perf_selftests=
-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f5e35/tools/testing/sel=
ftests/mqueue/mq_perf_tests
TAP version 13
selftests: mqueue: mq_open_tests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Using Default queue path - /test1

Initial system state:
	Using queue path:		/test1
	RLIMIT_MSGQUEUE(soft):		819200
	RLIMIT_MSGQUEUE(hard):		819200
	Maximum Message Size:		8192
	Maximum Queue Size:		10
	Default Message Size:		8192
	Default Queue Size:		10

Adjusted system state for testing:
	RLIMIT_MSGQUEUE(soft):		819200
	RLIMIT_MSGQUEUE(hard):		819200
	Maximum Message Size:		8192
	Maximum Queue Size:		10
	Default Message Size:		8192
	Default Queue Size:		10


Test series 1, behavior when no attr struct passed to mq_open:
Kernel supports setting defaults separately from maximums:		PASS
Given sane values, mq_open without an attr struct succeeds:		PASS
Kernel properly honors default setting knobs:				PASS
Kernel properly limits default values to lesser of default/max:		PASS
Kernel properly fails to create queue when defaults would
exceed rlimit:								PASS


Test series 2, behavior when attr struct is passed to mq_open:
Queue open in excess of rlimit max when euid =3D 0 failed:		PASS
Queue open with mq_maxmsg > limit when euid =3D 0 succeeded:		PASS
Queue open with mq_msgsize > limit when euid =3D 0 succeeded:		PASS
Queue open with total size > 2GB when euid =3D 0 failed:			PASS
Queue open in excess of rlimit max when euid =3D 99 failed:		PASS
Queue open with mq_maxmsg > limit when euid =3D 99 failed:		PASS
Queue open with mq_msgsize > limit when euid =3D 99 failed:		PASS
Queue open with total size > 2GB when euid =3D 99 failed:			PASS
ok 1..1 selftests: mqueue: mq_open_tests [PASS]
selftests: mqueue: mq_perf_tests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Initial system state:
	Using queue path:			/mq_perf_tests
	RLIMIT_MSGQUEUE(soft):			819200
	RLIMIT_MSGQUEUE(hard):			819200
	Maximum Message Size:			8192
	Maximum Queue Size:			10
	Nice value:				0

Adjusted system state for testing:
	RLIMIT_MSGQUEUE(soft):			(unlimited)
	RLIMIT_MSGQUEUE(hard):			(unlimited)
	Maximum Message Size:			16777216
	Maximum Queue Size:			65530
	Nice value:				-20
	Continuous mode:			(disabled)
	CPUs to pin:				1

	Queue /mq_perf_tests created:
		mq_flags:			O_NONBLOCK
		mq_maxmsg:			65530
		mq_msgsize:			16
		mq_curmsgs:			0

	Started mqueue performance test thread on CPU 1
		Max priorities:			32768
		Clock resolution:		1 nsec

	Test #1: Time send/recv message, queue empty
		(10000000 iterations)
		Send msg:			20.531927949s total time
						2053 nsec/msg
		Recv msg:			20.894450141s total time
						2089 nsec/msg

	Test #2a: Time send/recv message, queue full, constant prio
:
		(100000 iterations)
		Filling queue...done.		0.74747194s
		Testing...done.
		Send msg:			0.206763286s total time
						2067 nsec/msg
		Recv msg:			0.206895782s total time
						2068 nsec/msg
		Draining queue...done.		0.61191700s

	Test #2b: Time send/recv message, queue full, increasing prio
:
		(100000 iterations)
		Filling queue...done.		0.81945153s
		Testing...done.
		Send msg:			0.237830829s total time
						2378 nsec/msg
		Recv msg:			0.225050307s total time
						2250 nsec/msg
		Draining queue...done.		0.67745149s

	Test #2c: Time send/recv message, queue full, decreasing prio
:
		(100000 iterations)
		Filling queue...done.		0.80681722s
		Testing...done.
		Send msg:			0.225532888s total time
						2255 nsec/msg
		Recv msg:			0.217816083s total time
						2178 nsec/msg
		Draining queue...done.		0.65945561s

	Test #2d: Time send/recv message, queue full, random prio
:
		(100000 iterations)
		Filling queue...done.		0.87979278s
		Testing...done.
		Send msg:			0.230904730s total time
						2309 nsec/msg
		Recv msg:			0.215631604s total time
						2156 nsec/msg
		Draining queue...done.		0.72214322s
ok 1..2 selftests: mqueue: mq_perf_tests [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471=
641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/mqueue'

2019-03-02 12:13:04 make run_tests -C net
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647=
1641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/net'
make ARCH=3Dx86 -C ../../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9=
6471641e147cb2c33ad54284000d0f5e35'
  HOSTCC  scripts/basic/fixdep
  WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
  WRAP    arch/x86/include/generated/uapi/asm/poll.h
  SYSTBL  arch/x86/include/generated/asm/syscalls_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_64.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_x32.h
  HOSTCC  arch/x86/tools/relocs_32.o
  HOSTCC  arch/x86/tools/relocs_64.o
  HOSTCC  arch/x86/tools/relocs_common.o
  HOSTLD  arch/x86/tools/relocs
  UPD     include/generated/uapi/linux/version.h
  HOSTCC  scripts/unifdef
  INSTALL usr/include/asm-generic/ (37 files)
  INSTALL usr/include/drm/ (26 files)
  INSTALL usr/include/linux/ (503 files)
  INSTALL usr/include/linux/android/ (2 files)
  INSTALL usr/include/linux/byteorder/ (2 files)
  INSTALL usr/include/linux/caif/ (2 files)
  INSTALL usr/include/linux/can/ (6 files)
  INSTALL usr/include/linux/cifs/ (1 file)
  INSTALL usr/include/linux/dvb/ (8 files)
  INSTALL usr/include/linux/genwqe/ (1 file)
  INSTALL usr/include/linux/hdlc/ (1 file)
  INSTALL usr/include/linux/hsi/ (2 files)
  INSTALL usr/include/linux/iio/ (2 files)
  INSTALL usr/include/linux/isdn/ (1 file)
  INSTALL usr/include/linux/mmc/ (1 file)
  INSTALL usr/include/linux/netfilter/ (88 files)
  INSTALL usr/include/linux/netfilter/ipset/ (4 files)
  INSTALL usr/include/linux/netfilter_arp/ (2 files)
  INSTALL usr/include/linux/netfilter_bridge/ (17 files)
  INSTALL usr/include/linux/netfilter_ipv4/ (9 files)
  INSTALL usr/include/linux/netfilter_ipv6/ (13 files)
  INSTALL usr/include/linux/nfsd/ (5 files)
  INSTALL usr/include/linux/raid/ (2 files)
  INSTALL usr/include/linux/sched/ (1 file)
  INSTALL usr/include/linux/spi/ (1 file)
  INSTALL usr/include/linux/sunrpc/ (1 file)
  INSTALL usr/include/linux/tc_act/ (15 files)
  INSTALL usr/include/linux/tc_ematch/ (5 files)
  INSTALL usr/include/linux/usb/ (13 files)
  INSTALL usr/include/linux/wimax/ (1 file)
  INSTALL usr/include/misc/ (2 files)
  INSTALL usr/include/mtd/ (5 files)
  INSTALL usr/include/rdma/ (25 files)
  INSTALL usr/include/rdma/hfi/ (2 files)
  INSTALL usr/include/scsi/ (5 files)
  INSTALL usr/include/scsi/fc/ (4 files)
  INSTALL usr/include/sound/ (16 files)
  INSTALL usr/include/video/ (3 files)
  INSTALL usr/include/xen/ (4 files)
  INSTALL usr/include/asm/ (62 files)
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96=
471641e147cb2c33ad54284000d0f5e35'
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseport=
_bpf.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33a=
d54284000d0f5e35/tools/testing/selftests/net/reuseport_bpf
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseport=
_bpf_cpu.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2=
c33ad54284000d0f5e35/tools/testing/selftests/net/reuseport_bpf_cpu
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/  -lnuma  reu=
seport_bpf_numa.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641=
e147cb2c33ad54284000d0f5e35/tools/testing/selftests/net/reuseport_bpf_numa
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseport=
_dualstack.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147c=
b2c33ad54284000d0f5e35/tools/testing/selftests/net/reuseport_dualstack
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseaddr=
_conflict.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb=
2c33ad54284000d0f5e35/tools/testing/selftests/net/reuseaddr_conflict
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    tls.c  -o=
 /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d=
0f5e35/tools/testing/selftests/net/tls
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    socket.c =
 -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad542840=
00d0f5e35/tools/testing/selftests/net/socket
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    psock_fan=
out.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad=
54284000d0f5e35/tools/testing/selftests/net/psock_fanout
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    psock_tpa=
cket.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33a=
d54284000d0f5e35/tools/testing/selftests/net/psock_tpacket
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    msg_zeroc=
opy.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad=
54284000d0f5e35/tools/testing/selftests/net/msg_zerocopy
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseport=
_addr_any.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb=
2c33ad54284000d0f5e35/tools/testing/selftests/net/reuseport_addr_any
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/  -lpthread  =
tcp_mmap.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2=
c33ad54284000d0f5e35/tools/testing/selftests/net/tcp_mmap
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/  -lpthread  =
tcp_inq.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c=
33ad54284000d0f5e35/tools/testing/selftests/net/tcp_inq
tcp_inq.c: In function =E2=80=98main=E2=80=99:
tcp_inq.c:178:4: warning: dereferencing type-punned pointer will break stri=
ct-aliasing rules [-Wstrict-aliasing]
    inq =3D *((int *) CMSG_DATA(cm));
    ^~~
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    psock_snd=
=2Ec  -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad5=
4284000d0f5e35/tools/testing/selftests/net/psock_snd
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    txring_ov=
erwrite.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c=
33ad54284000d0f5e35/tools/testing/selftests/net/txring_overwrite
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    udpgso.c =
 -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad542840=
00d0f5e35/tools/testing/selftests/net/udpgso
udpgso.c: In function =E2=80=98send_one=E2=80=99:
udpgso.c:484:3: warning: dereferencing type-punned pointer will break stric=
t-aliasing rules [-Wstrict-aliasing]
   *((uint16_t *) CMSG_DATA(cm)) =3D gso_len;
   ^
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    udpgso_be=
nch_tx.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c3=
3ad54284000d0f5e35/tools/testing/selftests/net/udpgso_bench_tx
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    udpgso_be=
nch_rx.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c3=
3ad54284000d0f5e35/tools/testing/selftests/net/udpgso_bench_rx
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    ip_defrag=
=2Ec  -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad5=
4284000d0f5e35/tools/testing/selftests/net/ip_defrag
TAP version 13
selftests: net: reuseport_bpf
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
---- IPv4 UDP ----
Testing EBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing EBPF mod 20...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 10: 10
Socket 11: 11
Socket 12: 12
Socket 13: 13
Socket 14: 14
Socket 15: 15
Socket 16: 16
Socket 17: 17
Socket 18: 18
Socket 19: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 10: 30
Socket 11: 31
Socket 12: 32
Socket 13: 33
Socket 14: 34
Socket 15: 35
Socket 16: 36
Socket 17: 37
Socket 18: 38
Socket 19: 39
Reprograming, testing mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 0: 30
Socket 1: 31
Socket 2: 32
Socket 3: 33
Socket 4: 34
Socket 5: 35
Socket 6: 36
Socket 7: 37
Socket 8: 38
Socket 9: 39
Testing CBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing CBPF mod 20...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 10: 10
Socket 11: 11
Socket 12: 12
Socket 13: 13
Socket 14: 14
Socket 15: 15
Socket 16: 16
Socket 17: 17
Socket 18: 18
Socket 19: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 10: 30
Socket 11: 31
Socket 12: 32
Socket 13: 33
Socket 14: 34
Socket 15: 35
Socket 16: 36
Socket 17: 37
Socket 18: 38
Socket 19: 39
Reprograming, testing mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 0: 30
Socket 1: 31
Socket 2: 32
Socket 3: 33
Socket 4: 34
Socket 5: 35
Socket 6: 36
Socket 7: 37
Socket 8: 38
Socket 9: 39
Testing too many filters...
Testing filters on non-SO_REUSEPORT socket...
---- IPv6 UDP ----
Testing EBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing EBPF mod 20...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 10: 10
Socket 11: 11
Socket 12: 12
Socket 13: 13
Socket 14: 14
Socket 15: 15
Socket 16: 16
Socket 17: 17
Socket 18: 18
Socket 19: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 10: 30
Socket 11: 31
Socket 12: 32
Socket 13: 33
Socket 14: 34
Socket 15: 35
Socket 16: 36
Socket 17: 37
Socket 18: 38
Socket 19: 39
Reprograming, testing mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 0: 30
Socket 1: 31
Socket 2: 32
Socket 3: 33
Socket 4: 34
Socket 5: 35
Socket 6: 36
Socket 7: 37
Socket 8: 38
Socket 9: 39
Testing CBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing CBPF mod 20...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 10: 10
Socket 11: 11
Socket 12: 12
Socket 13: 13
Socket 14: 14
Socket 15: 15
Socket 16: 16
Socket 17: 17
Socket 18: 18
Socket 19: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 10: 30
Socket 11: 31
Socket 12: 32
Socket 13: 33
Socket 14: 34
Socket 15: 35
Socket 16: 36
Socket 17: 37
Socket 18: 38
Socket 19: 39
Reprograming, testing mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 0: 30
Socket 1: 31
Socket 2: 32
Socket 3: 33
Socket 4: 34
Socket 5: 35
Socket 6: 36
Socket 7: 37
Socket 8: 38
Socket 9: 39
Testing too many filters...
Testing filters on non-SO_REUSEPORT socket...
---- IPv6 UDP w/ mapped IPv4 ----
Testing EBPF mod 20...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 10: 10
Socket 11: 11
Socket 12: 12
Socket 13: 13
Socket 14: 14
Socket 15: 15
Socket 16: 16
Socket 17: 17
Socket 18: 18
Socket 19: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 10: 30
Socket 11: 31
Socket 12: 32
Socket 13: 33
Socket 14: 34
Socket 15: 35
Socket 16: 36
Socket 17: 37
Socket 18: 38
Socket 19: 39
Reprograming, testing mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 0: 30
Socket 1: 31
Socket 2: 32
Socket 3: 33
Socket 4: 34
Socket 5: 35
Socket 6: 36
Socket 7: 37
Socket 8: 38
Socket 9: 39
Testing EBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing CBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing CBPF mod 20...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 10: 10
Socket 11: 11
Socket 12: 12
Socket 13: 13
Socket 14: 14
Socket 15: 15
Socket 16: 16
Socket 17: 17
Socket 18: 18
Socket 19: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 10: 30
Socket 11: 31
Socket 12: 32
Socket 13: 33
Socket 14: 34
Socket 15: 35
Socket 16: 36
Socket 17: 37
Socket 18: 38
Socket 19: 39
Reprograming, testing mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 0: 30
Socket 1: 31
Socket 2: 32
Socket 3: 33
Socket 4: 34
Socket 5: 35
Socket 6: 36
Socket 7: 37
Socket 8: 38
Socket 9: 39
---- IPv4 TCP ----
Testing EBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing CBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing too many filters...
Testing filters on non-SO_REUSEPORT socket...
---- IPv6 TCP ----
Testing EBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing CBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing too many filters...
Testing filters on non-SO_REUSEPORT socket...
---- IPv6 TCP w/ mapped IPv4 ----
Testing EBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing CBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing filter add without bind...
SUCCESS
ok 1..1 selftests: net: reuseport_bpf [PASS]
selftests: net: reuseport_bpf_cpu
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
---- IPv4 UDP ----
send cpu 0, receive socket 0
send cpu 1, receive socket 1
send cpu 1, receive socket 1
send cpu 0, receive socket 0
send cpu 0, receive socket 0
send cpu 1, receive socket 1
---- IPv6 UDP ----
send cpu 0, receive socket 0
send cpu 1, receive socket 1
send cpu 1, receive socket 1
send cpu 0, receive socket 0
send cpu 0, receive socket 0
send cpu 1, receive socket 1
---- IPv4 TCP ----
send cpu 0, receive socket 0
send cpu 1, receive socket 1
send cpu 1, receive socket 1
send cpu 0, receive socket 0
send cpu 0, receive socket 0
send cpu 1, receive socket 1
---- IPv6 TCP ----
send cpu 0, receive socket 0
send cpu 1, receive socket 1
send cpu 1, receive socket 1
send cpu 0, receive socket 0
send cpu 0, receive socket 0
send cpu 1, receive socket 1
SUCCESS
ok 1..2 selftests: net: reuseport_bpf_cpu [PASS]
selftests: net: reuseport_bpf_numa
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
---- IPv4 UDP ----
send node 0, receive socket 0
send node 0, receive socket 0
---- IPv6 UDP ----
send node 0, receive socket 0
send node 0, receive socket 0
---- IPv4 TCP ----
send node 0, receive socket 0
send node 0, receive socket 0
---- IPv6 TCP ----
send node 0, receive socket 0
send node 0, receive socket 0
SUCCESS
ok 1..3 selftests: net: reuseport_bpf_numa [PASS]
selftests: net: reuseport_dualstack
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
---- UDP IPv4 created before IPv6 ----
---- UDP IPv6 created before IPv4 ----
---- UDP IPv4 created before IPv6 (large) ----
---- UDP IPv6 created before IPv4 (large) ----
---- TCP IPv4 created before IPv6 ----
---- TCP IPv6 created before IPv4 ----
SUCCESS
ok 1..4 selftests: net: reuseport_dualstack [PASS]
selftests: net: reuseaddr_conflict
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Opening 127.0.0.1:9999
Opening INADDR_ANY:9999
bind: Address already in use
Opening in6addr_any:9999
Opening INADDR_ANY:9999
bind: Address already in use
Opening INADDR_ANY:9999 after closing ipv6 socket
bind: Address already in use
Successok 1..5 selftests: net: reuseaddr_conflict [PASS]
selftests: net: tls
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] Running 29 tests from 2 test cases.
[ RUN      ] tls.sendfile
[       OK ] tls.sendfile
[ RUN      ] tls.send_then_sendfile
[       OK ] tls.send_then_sendfile
[ RUN      ] tls.recv_max
[       OK ] tls.recv_max
[ RUN      ] tls.recv_small
[       OK ] tls.recv_small
[ RUN      ] tls.msg_more
[       OK ] tls.msg_more
[ RUN      ] tls.sendmsg_single
[       OK ] tls.sendmsg_single
[ RUN      ] tls.sendmsg_large
[       OK ] tls.sendmsg_large
[ RUN      ] tls.sendmsg_multiple
[       OK ] tls.sendmsg_multiple
[ RUN      ] tls.sendmsg_multiple_stress
[       OK ] tls.sendmsg_multiple_stress
[ RUN      ] tls.splice_from_pipe
[       OK ] tls.splice_from_pipe
[ RUN      ] tls.splice_from_pipe2
[       OK ] tls.splice_from_pipe2
[ RUN      ] tls.send_and_splice
[       OK ] tls.send_and_splice
[ RUN      ] tls.splice_to_pipe
[       OK ] tls.splice_to_pipe
[ RUN      ] tls.recvmsg_single
[       OK ] tls.recvmsg_single
[ RUN      ] tls.recvmsg_single_max
[       OK ] tls.recvmsg_single_max
[ RUN      ] tls.recvmsg_multiple
[       OK ] tls.recvmsg_multiple
[ RUN      ] tls.single_send_multiple_recv
[       OK ] tls.single_send_multiple_recv
[ RUN      ] tls.multiple_send_single_recv
[       OK ] tls.multiple_send_single_recv
[ RUN      ] tls.recv_partial
[       OK ] tls.recv_partial
[ RUN      ] tls.recv_nonblock
[       OK ] tls.recv_nonblock
[ RUN      ] tls.recv_peek
[       OK ] tls.recv_peek
[ RUN      ] tls.recv_peek_multiple
[       OK ] tls.recv_peek_multiple
[ RUN      ] tls.recv_peek_multiple_records
[       OK ] tls.recv_peek_multiple_records
[ RUN      ] tls.recv_peek_large_buf_mult_recs
[       OK ] tls.recv_peek_large_buf_mult_recs
[ RUN      ] tls.pollin
[       OK ] tls.pollin
[ RUN      ] tls.poll_wait
[       OK ] tls.poll_wait
[ RUN      ] tls.blocking
[       OK ] tls.blocking
[ RUN      ] tls.nonblocking
[       OK ] tls.nonblocking
[ RUN      ] tls.control_msg
[       OK ] tls.control_msg
[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] 29 / 29 tests passed.
[  PASSED  ]
ok 1..6 selftests: net: tls [PASS]
selftests: net: run_netsocktests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--------------------
running socket test
--------------------
[PASS]
ok 1..7 selftests: net: run_netsocktests [PASS]
selftests: net: run_afpackettests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--------------------
running psock_fanout test
--------------------
test: control single socket
test: control multiple sockets
test: unique ids

test: datapath 0x0 ports 8000,8002
info: count=3D0,0, expect=3D0,0
info: count=3D0,20, expect=3D15,5
warning: incorrect queue lengths
info: count=3D0,20, expect=3D20,5
warning: incorrect queue lengths
info: trying alternate ports (20)

test: datapath 0x0 ports 8000,8003
info: count=3D0,0, expect=3D0,0
info: count=3D0,20, expect=3D15,5
warning: incorrect queue lengths
info: count=3D0,20, expect=3D20,5
warning: incorrect queue lengths
info: trying alternate ports (19)

test: datapath 0x0 ports 8000,8004
info: count=3D0,0, expect=3D0,0
info: count=3D5,15, expect=3D15,5
info: count=3D5,20, expect=3D20,5

test: datapath 0x1000 ports 8000,8004
info: count=3D0,0, expect=3D0,0
info: count=3D5,15, expect=3D15,5
info: count=3D15,20, expect=3D20,15

test: datapath 0x1 ports 8000,8004
info: count=3D0,0, expect=3D0,0
info: count=3D10,10, expect=3D10,10
info: count=3D17,18, expect=3D18,17

test: datapath 0x3 ports 8000,8004
info: count=3D0,0, expect=3D0,0
info: count=3D15,5, expect=3D15,5
info: count=3D20,15, expect=3D20,15

test: datapath 0x6 ports 8000,8004
info: count=3D0,0, expect=3D0,0
info: count=3D5,15, expect=3D15,5
info: count=3D20,15, expect=3D15,20

test: datapath 0x7 ports 8000,8004
info: count=3D0,0, expect=3D0,0
info: count=3D5,15, expect=3D15,5
info: count=3D20,15, expect=3D15,20

test: datapath 0x2 ports 8000,8004
info: count=3D0,0, expect=3D0,0
info: count=3D20,0, expect=3D20,0
info: count=3D20,0, expect=3D20,0

test: datapath 0x2 ports 8000,8004
info: count=3D0,0, expect=3D0,0
info: count=3D0,20, expect=3D0,20
info: count=3D0,20, expect=3D0,20

test: datapath 0x2000 ports 8000,8004
info: count=3D0,0, expect=3D0,0
info: count=3D20,20, expect=3D20,20
info: count=3D20,20, expect=3D20,20
OK. All tests passed
[PASS]
--------------------
running psock_tpacket test
--------------------
test: TPACKET_V1 with PACKET_RX_RING .................... 100 pkts (14200 b=
ytes)
test: TPACKET_V1 with PACKET_TX_RING .................... 100 pkts (14200 b=
ytes)
test: TPACKET_V2 with PACKET_RX_RING .................... 100 pkts (14200 b=
ytes)
test: TPACKET_V2 with PACKET_TX_RING .................... 100 pkts (14200 b=
ytes)
test: TPACKET_V3 with PACKET_RX_RING .................... 100 pkts (14200 b=
ytes)
test: TPACKET_V3 with PACKET_TX_RING .................... 100 pkts (14200 b=
ytes)
OK. All tests passed
[PASS]
--------------------
running txring_overwrite test
--------------------
read: a (0x61)
read: b (0x62)
[PASS]
ok 1..8 selftests: net: run_afpackettests [PASS]
selftests: net: test_bpf.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
test_bpf: ok
ok 1..9 selftests: net: test_bpf.sh [PASS]
selftests: net: netdevice.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
SKIP: eth0: interface already up
Cannot get device udp-fragmentation-offload settings: Operation not support=
ed
PASS: eth0: ethtool list features
PASS: eth0: ethtool dump
PASS: eth0: ethtool stats
SKIP: eth0: interface kept up
ok 1..10 selftests: net: netdevice.sh [PASS]
selftests: net: rtnetlink.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
PASS: policy routing
PASS: route get
PASS: tc htb hierarchy
PASS: gre tunnel endpoint
PASS: gretap
RTNETLINK answers: Operation not supported
Cannot find device "ip6gretap00"
Cannot find device "ip6gretap00"
Cannot find device "ip6gretap00"
RTNETLINK answers: Operation not supported
Cannot find device "ip6gretap00"
FAIL: ip6gretap
PASS: erspan
RTNETLINK answers: Operation not supported
Cannot find device "ip6erspan00"
Cannot find device "ip6erspan00"
Cannot find device "ip6erspan00"
RTNETLINK answers: Operation not supported
Cannot find device "ip6erspan00"
Cannot find device "ip6erspan00"
Cannot find device "ip6erspan00"
RTNETLINK answers: Operation not supported
Cannot find device "ip6erspan00"
FAIL: ip6erspan
PASS: bridge setup
PASS: ipv6 addrlabel
PASS: set ifalias b7e7fa9a-41cd-4559-8440-b352756687db for test-dummy0
PASS: vrf
PASS: vxlan
PASS: fou
PASS: macsec
PASS: ipsec
FAIL: ipsec_offload netdevsim doesn't support IPsec offload
SKIP: fdb get tests: iproute2 too old
SKIP: fdb get tests: iproute2 too old
ok 1..11 selftests: net: rtnetlink.sh [PASS]
selftests: net: xfrm_policy.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
PASS: policy before exception matches
PASS: ping to .254 bypassed ipsec tunnel
PASS: direct policy matches
PASS: policy matches
ok 1..12 selftests: net: xfrm_policy.sh [PASS]
selftests: net: fib_tests.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Single path route test
    Start point
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    Nexthop device deleted
    TEST: IPv4 fibmatch - no route                                      [ O=
K ]
    TEST: IPv6 fibmatch - no route                                      [ O=
K ]

Multipath route test
    Start point
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    One nexthop device deleted
    TEST: IPv4 - multipath route removed on delete                      [ O=
K ]
    TEST: IPv6 - multipath down to single path                          [ O=
K ]
    Second nexthop device deleted
    TEST: IPv6 - no route                                               [ O=
K ]

Single path, admin down
    Start point
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    Route deleted on down
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]

Admin down multipath
    Verify start point
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    One device down, one up
    TEST: IPv4 fibmatch on down device                                  [ O=
K ]
    TEST: IPv6 fibmatch on down device                                  [ O=
K ]
    TEST: IPv4 fibmatch on up device                                    [ O=
K ]
    TEST: IPv6 fibmatch on up device                                    [ O=
K ]
    TEST: IPv4 flags on down device                                     [ O=
K ]
    TEST: IPv6 flags on down device                                     [ O=
K ]
    TEST: IPv4 flags on up device                                       [ O=
K ]
    TEST: IPv6 flags on up device                                       [ O=
K ]
    Other device down and up
    TEST: IPv4 fibmatch on down device                                  [ O=
K ]
    TEST: IPv6 fibmatch on down device                                  [ O=
K ]
    TEST: IPv4 fibmatch on up device                                    [ O=
K ]
    TEST: IPv6 fibmatch on up device                                    [ O=
K ]
    TEST: IPv4 flags on down device                                     [ O=
K ]
    TEST: IPv6 flags on down device                                     [ O=
K ]
    TEST: IPv4 flags on up device                                       [ O=
K ]
    TEST: IPv6 flags on up device                                       [ O=
K ]
    Both devices down
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]

Local carrier tests - single path
    Start point
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    TEST: IPv4 - no linkdown flag                                       [ O=
K ]
    TEST: IPv6 - no linkdown flag                                       [ O=
K ]
    Carrier off on nexthop
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    TEST: IPv4 - linkdown flag set                                      [ O=
K ]
    TEST: IPv6 - linkdown flag set                                      [ O=
K ]
    Route to local address with carrier down
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    TEST: IPv4 linkdown flag set                                        [ O=
K ]
    TEST: IPv6 linkdown flag set                                        [ O=
K ]

Single path route carrier test
    Start point
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    TEST: IPv4 no linkdown flag                                         [ O=
K ]
    TEST: IPv6 no linkdown flag                                         [ O=
K ]
    Carrier down
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    TEST: IPv4 linkdown flag set                                        [ O=
K ]
    TEST: IPv6 linkdown flag set                                        [ O=
K ]
    Second address added with carrier down
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    TEST: IPv4 linkdown flag set                                        [ O=
K ]
    TEST: IPv6 linkdown flag set                                        [ O=
K ]

IPv4 nexthop tests
<<< write me >>>

IPv6 nexthop tests
    TEST: Directly connected nexthop, unicast address                   [ O=
K ]
    TEST: Directly connected nexthop, unicast address with device       [ O=
K ]
    TEST: Gateway is linklocal address                                  [ O=
K ]
    TEST: Gateway is linklocal address, no device                       [ O=
K ]
    TEST: Gateway can not be local unicast address                      [ O=
K ]
    TEST: Gateway can not be local unicast address, with device         [ O=
K ]
    TEST: Gateway can not be a local linklocal address                  [ O=
K ]
    TEST: Gateway can be local address in a VRF                         [ O=
K ]
    TEST: Gateway can be local address in a VRF, with device            [ O=
K ]
    TEST: Gateway can be local linklocal address in a VRF               [ O=
K ]
    TEST: Redirect to VRF lookup                                        [ O=
K ]
    TEST: VRF route, gateway can be local address in default VRF        [ O=
K ]
    TEST: VRF route, gateway can not be a local address                 [ O=
K ]
    TEST: VRF route, gateway can not be a local addr with device        [ O=
K ]

IPv6 route add / append tests
    TEST: Attempt to add duplicate route - gw                           [ O=
K ]
    TEST: Attempt to add duplicate route - dev only                     [ O=
K ]
    TEST: Attempt to add duplicate route - reject route                 [ O=
K ]
    TEST: Append nexthop to existing route - gw                         [ O=
K ]
    TEST: Add multipath route                                           [ O=
K ]
    TEST: Attempt to add duplicate multipath route                      [ O=
K ]
    TEST: Route add with different metrics                              [ O=
K ]
    TEST: Route delete with metric                                      [ O=
K ]

IPv6 route replace tests
    TEST: Single path with single path                                  [ O=
K ]
    TEST: Single path with multipath                                    [ O=
K ]
    TEST: Single path with single path via multipath attribute          [ O=
K ]
    TEST: Invalid nexthop                                               [ O=
K ]
    TEST: Single path - replace of non-existent route                   [ O=
K ]
    TEST: Multipath with multipath                                      [ O=
K ]
    TEST: Multipath with single path                                    [ O=
K ]
    TEST: Multipath with single path via multipath attribute            [ O=
K ]
    TEST: Multipath - invalid first nexthop                             [ O=
K ]
    TEST: Multipath - invalid second nexthop                            [ O=
K ]
    TEST: Multipath - replace of non-existent route                     [ O=
K ]

IPv4 route add / append tests
    TEST: Attempt to add duplicate route - gw                           [ O=
K ]
    TEST: Attempt to add duplicate route - dev only                     [ O=
K ]
    TEST: Attempt to add duplicate route - reject route                 [ O=
K ]
    TEST: Add new nexthop for existing prefix                           [ O=
K ]
    TEST: Append nexthop to existing route - gw                         [ O=
K ]
    TEST: Append nexthop to existing route - dev only                   [ O=
K ]
    TEST: Append nexthop to existing route - reject route               [ O=
K ]
    TEST: Append nexthop to existing reject route - gw                  [ O=
K ]
    TEST: Append nexthop to existing reject route - dev only            [ O=
K ]
    TEST: add multipath route                                           [ O=
K ]
    TEST: Attempt to add duplicate multipath route                      [ O=
K ]
    TEST: Route add with different metrics                              [ O=
K ]
    TEST: Route delete with metric                                      [ O=
K ]

IPv4 route replace tests
    TEST: Single path with single path                                  [ O=
K ]
    TEST: Single path with multipath                                    [ O=
K ]
    TEST: Single path with reject route                                 [ O=
K ]
    TEST: Single path with single path via multipath attribute          [ O=
K ]
    TEST: Invalid nexthop                                               [ O=
K ]
    TEST: Single path - replace of non-existent route                   [ O=
K ]
    TEST: Multipath with multipath                                      [ O=
K ]
    TEST: Multipath with single path                                    [ O=
K ]
    TEST: Multipath with single path via multipath attribute            [ O=
K ]
    TEST: Multipath with reject route                                   [ O=
K ]
    TEST: Multipath - invalid first nexthop                             [ O=
K ]
    TEST: Multipath - invalid second nexthop                            [ O=
K ]
    TEST: Multipath - replace of non-existent route                     [ O=
K ]

IPv6 prefix route tests
    TEST: Default metric                                                [ O=
K ]
    TEST: User specified metric on first device                         [ O=
K ]
    TEST: User specified metric on second device                        [ O=
K ]
    TEST: Delete of address on first device                             [ O=
K ]
    TEST: Modify metric of address                                      [ O=
K ]
Command line is not complete. Try option "help"
    TEST: Prefix route removed on link down                             [ O=
K ]
    TEST: Prefix route with metric on link up                           [ O=
K ]

IPv4 prefix route tests
    TEST: Default metric                                                [ O=
K ]
    TEST: User specified metric on first device                         [ O=
K ]
    TEST: User specified metric on second device                        [ O=
K ]
    TEST: Delete of address on first device                             [ O=
K ]
    TEST: Modify metric of address                                      [ O=
K ]
Command line is not complete. Try option "help"
    TEST: Prefix route removed on link down                             [ O=
K ]
    TEST: Prefix route with metric on link up                           [ O=
K ]

IPv6 routes with metrics
    TEST: Single path route with mtu metric                             [ O=
K ]
    TEST: Multipath route via 2 single routes with mtu metric on first  [ O=
K ]
    TEST: Multipath route via 2 single routes with mtu metric on 2nd    [ O=
K ]
    TEST:     MTU of second leg                                         [ O=
K ]
    TEST: Multipath route with mtu metric                               [ O=
K ]
    TEST: Using route with mtu metric                                   [ O=
K ]
    TEST: Invalid metric (fails metric_convert)                         [ O=
K ]

IPv4 route add / append tests
    TEST: Single path route with mtu metric                             [ O=
K ]
    TEST: Multipath route with mtu metric                               [ O=
K ]
    TEST: Using route with mtu metric                                   [ O=
K ]
    TEST: Invalid metric (fails metric_convert)                         [ O=
K ]

Tests passed: 141
Tests failed:   0
ok 1..13 selftests: net: fib_tests.sh [PASS]
selftests: net: fib-onlink-tests.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

########################################
Configuring interfaces
RTNETLINK answers: File exists
not ok 1..14 selftests: net: fib-onlink-tests.sh [FAIL]
selftests: net: pmtu.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
TEST: ipv4: PMTU exceptions                                         [ OK ]
connect: Cannot assign requested address
connect: Cannot assign requested address
TEST: ipv6: PMTU exceptions                                         [FAIL]
  PMTU exception wasn't created after exceeding MTU
TEST: IPv4 over vxlan4: PMTU exceptions                             [ OK ]
TEST: IPv6 over vxlan4: PMTU exceptions                             [ OK ]
TEST: IPv4 over vxlan6: PMTU exceptions                             [ OK ]
connect: Cannot assign requested address
TEST: IPv6 over vxlan6: PMTU exceptions                             [FAIL]
  PMTU exception wasn't created after exceeding link layer MTU on vxlan int=
erface
RTNETLINK answers: Operation not supported
  geneve4 not supported
TEST: IPv4 over geneve4: PMTU exceptions                            [SKIP]
RTNETLINK answers: Operation not supported
  geneve4 not supported
TEST: IPv6 over geneve4: PMTU exceptions                            [SKIP]
RTNETLINK answers: Operation not supported
  geneve6 not supported
TEST: IPv4 over geneve6: PMTU exceptions                            [SKIP]
RTNETLINK answers: Operation not supported
  geneve6 not supported
TEST: IPv6 over geneve6: PMTU exceptions                            [SKIP]
TEST: IPv4 over fou4: PMTU exceptions                               [ OK ]
TEST: IPv6 over fou4: PMTU exceptions                               [ OK ]
TEST: IPv4 over fou6: PMTU exceptions                               [FAIL]
  found PMTU exception with incorrect MTU 4944, expected 3944, after exceed=
ing link layer MTU on fou interface
TEST: IPv6 over fou6: PMTU exceptions                               [ OK ]
TEST: IPv4 over gue4: PMTU exceptions                               [ OK ]
TEST: IPv6 over gue4: PMTU exceptions                               [ OK ]
TEST: IPv4 over gue6: PMTU exceptions                               [ OK ]
TEST: IPv6 over gue6: PMTU exceptions                               [ OK ]
TEST: vti6: PMTU exceptions                                         [ OK ]
TEST: vti4: PMTU exceptions                                         [ OK ]
TEST: vti4: default MTU assignment                                  [ OK ]
TEST: vti6: default MTU assignment                                  [ OK ]
TEST: vti4: MTU setting on link creation                            [ OK ]
TEST: vti6: MTU setting on link creation                            [ OK ]
TEST: vti6: MTU changes on link changes                             [ OK ]
not ok 1..15 selftests: net: pmtu.sh [FAIL]
selftests: net: udpgso.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ipv4 cmsg
device mtu (orig): 65536
device mtu (test): 1500
ipv4 tx:1 gso:0=20
ipv4 tx:1472 gso:0=20
ipv4 tx:1473 gso:0 (fail)
ipv4 tx:1472 gso:1472 (fail)
ipv4 tx:1473 gso:1472=20
ipv4 tx:2944 gso:1472=20
ipv4 tx:2945 gso:1472=20
ipv4 tx:64768 gso:1472=20
ipv4 tx:65507 gso:1472=20
ipv4 tx:65508 gso:1472 (fail)
ipv4 tx:1 gso:1 (fail)
ipv4 tx:2 gso:1=20
ipv4 tx:5 gso:2=20
ipv4 tx:36 gso:1=20
ipv4 tx:37 gso:1 (fail)
OK
ipv4 setsockopt
device mtu (orig): 65536
device mtu (test): 1500
ipv4 tx:1 gso:0=20
ipv4 tx:1472 gso:0=20
ipv4 tx:1473 gso:0 (fail)
ipv4 tx:1472 gso:1472 (fail)
ipv4 tx:1473 gso:1472=20
ipv4 tx:2944 gso:1472=20
ipv4 tx:2945 gso:1472=20
ipv4 tx:64768 gso:1472=20
ipv4 tx:65507 gso:1472=20
ipv4 tx:65508 gso:1472 (fail)
ipv4 tx:1 gso:1 (fail)
ipv4 tx:2 gso:1=20
ipv4 tx:5 gso:2=20
ipv4 tx:36 gso:1=20
ipv4 tx:37 gso:1 (fail)
OK
ipv6 cmsg
device mtu (orig): 65536
device mtu (test): 1500
ipv6 tx:1 gso:0=20
ipv6 tx:1452 gso:0=20
ipv6 tx:1453 gso:0 (fail)
ipv6 tx:1452 gso:1452 (fail)
ipv6 tx:1453 gso:1452=20
ipv6 tx:2904 gso:1452=20
ipv6 tx:2905 gso:1452=20
ipv6 tx:65340 gso:1452=20
ipv6 tx:65527 gso:1452=20
ipv6 tx:65528 gso:1452 (fail)
ipv6 tx:1 gso:1 (fail)
ipv6 tx:2 gso:1=20
ipv6 tx:5 gso:2=20
ipv6 tx:16 gso:1=20
ipv6 tx:17 gso:1 (fail)
OK
ipv6 setsockopt
device mtu (orig): 65536
device mtu (test): 1500
ipv6 tx:1 gso:0=20
ipv6 tx:1452 gso:0=20
ipv6 tx:1453 gso:0 (fail)
ipv6 tx:1452 gso:1452 (fail)
ipv6 tx:1453 gso:1452=20
ipv6 tx:2904 gso:1452=20
ipv6 tx:2905 gso:1452=20
ipv6 tx:65340 gso:1452=20
ipv6 tx:65527 gso:1452=20
ipv6 tx:65528 gso:1452 (fail)
ipv6 tx:1 gso:1 (fail)
ipv6 tx:2 gso:1=20
ipv6 tx:5 gso:2=20
ipv6 tx:16 gso:1=20
ipv6 tx:17 gso:1 (fail)
OK
ipv4 connected
device mtu (orig): 65536
device mtu (test): 1600
route mtu (test): 1500
path mtu (read):  1500
ipv4 tx:1 gso:0=20
ipv4 tx:1472 gso:0=20
ipv4 tx:1473 gso:0 (fail)
ipv4 tx:1472 gso:1472 (fail)
ipv4 tx:1473 gso:1472=20
ipv4 tx:2944 gso:1472=20
ipv4 tx:2945 gso:1472=20
ipv4 tx:64768 gso:1472=20
ipv4 tx:65507 gso:1472=20
ipv4 tx:65508 gso:1472 (fail)
ipv4 tx:1 gso:1 (fail)
ipv4 tx:2 gso:1=20
ipv4 tx:5 gso:2=20
ipv4 tx:36 gso:1=20
ipv4 tx:37 gso:1 (fail)
OK
ipv4 msg_more
device mtu (orig): 65536
device mtu (test): 1500
ipv4 tx:1 gso:0=20
ipv4 tx:1472 gso:0=20
ipv4 tx:1473 gso:0 (fail)
ipv4 tx:1472 gso:1472 (fail)
ipv4 tx:1473 gso:1472=20
ipv4 tx:2944 gso:1472=20
ipv4 tx:2945 gso:1472=20
ipv4 tx:64768 gso:1472=20
ipv4 tx:65507 gso:1472=20
ipv4 tx:65508 gso:1472 (fail)
ipv4 tx:1 gso:1 (fail)
ipv4 tx:2 gso:1=20
ipv4 tx:5 gso:2=20
ipv4 tx:36 gso:1=20
ipv4 tx:37 gso:1 (fail)
OK
ipv6 msg_more
device mtu (orig): 65536
device mtu (test): 1500
ipv6 tx:1 gso:0=20
ipv6 tx:1452 gso:0=20
ipv6 tx:1453 gso:0 (fail)
ipv6 tx:1452 gso:1452 (fail)
ipv6 tx:1453 gso:1452=20
ipv6 tx:2904 gso:1452=20
ipv6 tx:2905 gso:1452=20
ipv6 tx:65340 gso:1452=20
ipv6 tx:65527 gso:1452=20
ipv6 tx:65528 gso:1452 (fail)
ipv6 tx:1 gso:1 (fail)
ipv6 tx:2 gso:1=20
ipv6 tx:5 gso:2=20
ipv6 tx:16 gso:1=20
ipv6 tx:17 gso:1 (fail)
OK
ok 1..16 selftests: net: udpgso.sh [PASS]
selftests: net: ip_defrag.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ipv4 defrag
seed =3D 1551500132
=2E/ip_defrag: recv: payload_len =3D 34609 max_frag_len =3D 8: Resource tem=
porarily unavailable
not ok 1..17 selftests: net: ip_defrag.sh [FAIL]
selftests: net: udpgso_bench.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ipv4
tcp
=2E/udpgso_bench_tx: connect: Connection refused
tcp zerocopy
tcp tx:   1500 MB/s    25453 calls/s  25453 msg/s
tcp rx:   1504 MB/s    14695 calls/s
tcp tx:   1291 MB/s    21913 calls/s  21913 msg/s
tcp rx:   1305 MB/s    13507 calls/s
tcp tx:   1840 MB/s    31212 calls/s  31212 msg/s
tcp rx:   1956 MB/s    19253 calls/s
udp
udp rx:    213 MB/s   152316 calls/s
udp tx:    308 MB/s   219702 calls/s   5231 msg/s
udp rx:    249 MB/s   177420 calls/s
udp tx:    313 MB/s   223398 calls/s   5319 msg/s
udp rx:    326 MB/s   232591 calls/s
udp tx:    378 MB/s   269766 calls/s   6423 msg/s
udp rx:    233 MB/s   166352 calls/s
udp gso
=2E/udpgso_bench_tx: sendmsg: Connection refused
udp gso zerocopy
udp rx:    331 MB/s   236225 calls/s
udp tx:    640 MB/s    10861 calls/s  10861 msg/s
udp tx:    633 MB/s    10740 calls/s  10740 msg/s
udp rx:    466 MB/s   332430 calls/s
udp tx:    632 MB/s    10722 calls/s  10722 msg/s
udp rx:    399 MB/s   284544 calls/s
ipv6
tcp
=2E/udpgso_bench_tx: connect: Connection refused
tcp zerocopy
tcp tx:   1212 MB/s    20562 calls/s  20562 msg/s
tcp rx:   1214 MB/s    12744 calls/s
tcp tx:   2046 MB/s    34710 calls/s  34710 msg/s
tcp rx:   2058 MB/s    26724 calls/s
tcp tx:   2491 MB/s    42264 calls/s  42264 msg/s
tcp rx:   2479 MB/s    29525 calls/s
udp
udp rx:    265 MB/s   193601 calls/s
udp tx:    297 MB/s   217193 calls/s   5051 msg/s
udp rx:    190 MB/s   139173 calls/s
udp tx:    240 MB/s   175569 calls/s   4083 msg/s
udp rx:    231 MB/s   168705 calls/s
udp tx:    266 MB/s   194661 calls/s   4527 msg/s
udp rx:    241 MB/s   175841 calls/s
udp gso
udp rx:    574 MB/s   419113 calls/s
udp tx:    729 MB/s    12368 calls/s  12368 msg/s
udp rx:    465 MB/s   339457 calls/s
udp tx:    780 MB/s    13230 calls/s  13230 msg/s
udp tx:    849 MB/s    14401 calls/s  14401 msg/s
udp rx:    435 MB/s   317461 calls/s
udp gso zerocopy
udp rx:    587 MB/s   428634 calls/s
udp tx:    639 MB/s    10844 calls/s  10844 msg/s
udp rx:    581 MB/s   424139 calls/s
udp tx:    600 MB/s    10178 calls/s  10178 msg/s
udp tx:    567 MB/s     9630 calls/s   9630 msg/s
udp rx:    507 MB/s   370134 calls/s
ok 1..18 selftests: net: udpgso_bench.sh [PASS]
selftests: net: fib_rule_tests.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

######################################################################
TEST SECTION: IPv4 fib rule
######################################################################

    TEST: rule4 check: oif dummy0                             [ OK ]

    TEST: rule4 del by pref: oif dummy0                       [ OK ]
RTNETLINK answers: No route to host

    TEST: rule4 check: from 192.51.100.3 iif dummy0           [FAIL]

    TEST: rule4 del by pref: from 192.51.100.3 iif dummy0     [ OK ]

    TEST: rule4 check: tos 0x10                               [ OK ]

    TEST: rule4 del by pref: tos 0x10                         [ OK ]

    TEST: rule4 check: fwmark 0x64                            [ OK ]

    TEST: rule4 del by pref: fwmark 0x64                      [ OK ]

    TEST: rule4 check: uidrange 100-100                       [ OK ]

    TEST: rule4 del by pref: uidrange 100-100                 [ OK ]

    TEST: rule4 check: sport 666 dport 777                    [ OK ]

    TEST: rule4 del by pref: sport 666 dport 777              [ OK ]

    TEST: rule4 check: ipproto tcp                            [ OK ]

    TEST: rule4 del by pref: ipproto tcp                      [ OK ]

    TEST: rule4 check: ipproto icmp                           [ OK ]

    TEST: rule4 del by pref: ipproto icmp                     [ OK ]

######################################################################
TEST SECTION: IPv6 fib rule
######################################################################

    TEST: rule6 check: oif dummy0                             [ OK ]

    TEST: rule6 del by pref: oif dummy0                       [ OK ]

    TEST: rule6 check: from 2001:db8:1::3 iif dummy0          [ OK ]

    TEST: rule6 del by pref: from 2001:db8:1::3 iif dummy0    [ OK ]

    TEST: rule6 check: tos 0x10                               [ OK ]

    TEST: rule6 del by pref: tos 0x10                         [ OK ]

    TEST: rule6 check: fwmark 0x64                            [ OK ]

    TEST: rule6 del by pref: fwmark 0x64                      [ OK ]

    TEST: rule6 check: uidrange 100-100                       [ OK ]

    TEST: rule6 del by pref: uidrange 100-100                 [ OK ]

    TEST: rule6 check: sport 666 dport 777                    [ OK ]

    TEST: rule6 del by pref: sport 666 dport 777              [ OK ]

    TEST: rule6 check: ipproto tcp                            [ OK ]

    TEST: rule6 del by pref: ipproto tcp                      [ OK ]

    TEST: rule6 check: ipproto icmp                           [ OK ]

    TEST: rule6 del by pref: ipproto icmp                     [ OK ]
ok 1..19 selftests: net: fib_rule_tests.sh [PASS]
selftests: net: msg_zerocopy.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ipv4 tcp -t 1
=2E/msg_zerocopy: setaffinity 2
=2E/msg_zerocopy: setaffinity 3
not ok 1..20 selftests: net: msg_zerocopy.sh [FAIL]
selftests: net: psock_snd.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
dgram
tx: 128
rx: 142
rx: 100
OK

dgram bind
tx: 128
rx: 142
rx: 100
OK

raw
tx: 142
rx: 142
rx: 100
OK

raw bind
tx: 142
rx: 142
rx: 100
OK

raw qdisc bypass
tx: 142
rx: 142
rx: 100
OK

raw vlan
tx: 146
rx: 100
OK

raw vnet hdr
tx: 152
rx: 142
rx: 100
OK

raw csum_off
tx: 152
rx: 142
rx: 100
OK

raw csum_off with bad offset (fails)
=2E/psock_snd: write: Invalid argument
raw min size
tx: 42
rx: 0
OK

raw mtu size
tx: 1514
rx: 1472
OK

raw mtu size + 1 (fails)
=2E/psock_snd: write: Message too long
raw vlan mtu size + 1 (fails)
=2E/psock_snd: write: Message too long
dgram mtu size
tx: 1500
rx: 1472
OK

dgram mtu size + 1 (fails)
=2E/psock_snd: write: Message too long
raw truncate hlen (fails: does not arrive)
tx: 14
=2E/psock_snd: recv: Resource temporarily unavailable
raw truncate hlen - 1 (fails: EINVAL)
=2E/psock_snd: write: Invalid argument
raw gso min size
tx: 1525
rx: 1473
OK

raw gso min size - 1 (fails)
tx: 1524
=2E/psock_snd: recv: Resource temporarily unavailable
raw gso max size
tx: 65559
rx: 65507
OK

raw gso max size + 1 (fails)
tx: 65560
=2E/psock_snd: recv: Resource temporarily unavailable
OK. All tests passed
ok 1..21 selftests: net: psock_snd.sh [PASS]
selftests: net: udpgro_bench.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Missing xdp_dummy helper. Build bpf selftest first
not ok 1..22 selftests: net: udpgro_bench.sh [FAIL]
selftests: net: udpgro.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Missing xdp_dummy helper. Build bpf selftest first
not ok 1..23 selftests: net: udpgro.sh [FAIL]
selftests: net: test_vxlan_under_vrf.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Checking HV connectivity                                           [ OK ]
Check VM connectivity through VXLAN (underlay in the default VRF)  [ OK ]
Check VM connectivity through VXLAN (underlay in a VRF)            [FAIL]
not ok 1..24 selftests: net: test_vxlan_under_vrf.sh [FAIL]
selftests: net: reuseport_addr_any.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
UDP IPv4 ... pass
UDP IPv6 ... pass
UDP IPv4 mapped to IPv6 ... pass
TCP IPv4 ... pass
TCP IPv6 ... pass
TCP IPv4 mapped to IPv6 ... pass
DCCP IPv4 ... pass
DCCP IPv6 ... pass
DCCP IPv4 mapped to IPv6 ... pass
SUCCESS
ok 1..25 selftests: net: reuseport_addr_any.sh [PASS]
selftests: net: test_vxlan_fdb_changelink.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
expected two remotes after fdb append	[ OK ]
expected two remotes after link set	[ OK ]
ok 1..26 selftests: net: test_vxlan_fdb_changelink.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471=
641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/net'

2019-03-02 12:16:06 make run_tests -C netfilter
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647=
1641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/netfilter'
TAP version 13
selftests: netfilter: nft_trans_stress.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
SKIP: Could not run test without nft tool
not ok 1..1 selftests: netfilter: nft_trans_stress.sh [SKIP]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471=
641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/netfilter'

2019-03-02 12:16:06 make run_tests -C nsfs
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647=
1641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/nsfs'
gcc -Wall -Werror    owner.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-99=
7dd96471641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/nsfs/owner
gcc -Wall -Werror    pidns.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-99=
7dd96471641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/nsfs/pidns
TAP version 13
selftests: nsfs: owner
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..1 selftests: nsfs: owner [PASS]
selftests: nsfs: pidns
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..2 selftests: nsfs: pidns [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471=
641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/nsfs'
ignored_by_lkp powerpc test
prctl test: not in Makefile
2019-03-02 12:16:06 make TARGETS=3Dprctl
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9=
6471641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/prctl'
Makefile:14: warning: overriding recipe for target 'clean'
=2E./lib.mk:137: warning: ignoring old recipe for target 'clean'
gcc     disable-tsc-ctxt-sw-stress-test.c   -o disable-tsc-ctxt-sw-stress-t=
est
gcc     disable-tsc-on-off-stress-test.c   -o disable-tsc-on-off-stress-test
gcc     disable-tsc-test.c   -o disable-tsc-test
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96=
471641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/prctl'

2019-03-02 12:16:07 make run_tests -C prctl
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647=
1641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/prctl'
Makefile:14: warning: overriding recipe for target 'clean'
=2E./lib.mk:137: warning: ignoring old recipe for target 'clean'
TAP version 13
selftests: prctl: disable-tsc-ctxt-sw-stress-test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[No further output means we're allright]
ok 1..1 selftests: prctl: disable-tsc-ctxt-sw-stress-test [PASS]
selftests: prctl: disable-tsc-on-off-stress-test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[No further output means we're allright]
ok 1..2 selftests: prctl: disable-tsc-on-off-stress-test [PASS]
selftests: prctl: disable-tsc-test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
rdtsc() =3D=3D 806481955101
prctl(PR_GET_TSC, &tsc_val); tsc_val =3D=3D PR_TSC_ENABLE
rdtsc() =3D=3D 806482186353
prctl(PR_SET_TSC, PR_TSC_ENABLE)
rdtsc() =3D=3D 806482221903
prctl(PR_SET_TSC, PR_TSC_SIGSEGV)
rdtsc() =3D=3D [ SIG_SEGV ]
prctl(PR_GET_TSC, &tsc_val); tsc_val =3D=3D PR_TSC_SIGSEGV
prctl(PR_SET_TSC, PR_TSC_ENABLE)
rdtsc() =3D=3D 806482358487
ok 1..3 selftests: prctl: disable-tsc-test [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471=
641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/prctl'

2019-03-02 12:16:27 make run_tests -C proc
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647=
1641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/proc'
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    fd-001-lookup.c  -o /us=
r/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f5e=
35/tools/testing/selftests/proc/fd-001-lookup
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    fd-002-posix-eq.c  -o /=
usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f=
5e35/tools/testing/selftests/proc/fd-002-posix-eq
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    fd-003-kthread.c  -o /u=
sr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f5=
e35/tools/testing/selftests/proc/fd-003-kthread
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-loadavg-001.c  -o =
/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0=
f5e35/tools/testing/selftests/proc/proc-loadavg-001
proc-loadavg-001.c:17:0: warning: "_GNU_SOURCE" redefined
 #define _GNU_SOURCE
=20
<command-line>:0:0: note: this is the location of the previous definition
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-self-map-files-001=
=2Ec  -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad5=
4284000d0f5e35/tools/testing/selftests/proc/proc-self-map-files-001
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-self-map-files-002=
=2Ec  -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad5=
4284000d0f5e35/tools/testing/selftests/proc/proc-self-map-files-002
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-self-syscall.c  -o=
 /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d=
0f5e35/tools/testing/selftests/proc/proc-self-syscall
proc-self-syscall.c:16:0: warning: "_GNU_SOURCE" redefined
 #define _GNU_SOURCE
=20
<command-line>:0:0: note: this is the location of the previous definition
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-self-wchan.c  -o /=
usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f=
5e35/tools/testing/selftests/proc/proc-self-wchan
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-uptime-001.c  -o /=
usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f=
5e35/tools/testing/selftests/proc/proc-uptime-001
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-uptime-002.c  -o /=
usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f=
5e35/tools/testing/selftests/proc/proc-uptime-002
proc-uptime-002.c:18:0: warning: "_GNU_SOURCE" redefined
 #define _GNU_SOURCE
=20
<command-line>:0:0: note: this is the location of the previous definition
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    read.c  -o /usr/src/per=
f_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f5e35/tools/=
testing/selftests/proc/read
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    self.c  -o /usr/src/per=
f_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f5e35/tools/=
testing/selftests/proc/self
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    thread-self.c  -o /usr/=
src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f5e35=
/tools/testing/selftests/proc/thread-self
TAP version 13
selftests: proc: fd-001-lookup
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..1 selftests: proc: fd-001-lookup [PASS]
selftests: proc: fd-002-posix-eq
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..2 selftests: proc: fd-002-posix-eq [PASS]
selftests: proc: fd-003-kthread
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..3 selftests: proc: fd-003-kthread [PASS]
selftests: proc: proc-loadavg-001
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..4 selftests: proc: proc-loadavg-001 [PASS]
selftests: proc: proc-self-map-files-001
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..5 selftests: proc: proc-self-map-files-001 [PASS]
selftests: proc: proc-self-map-files-002
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..6 selftests: proc: proc-self-map-files-002 [PASS]
selftests: proc: proc-self-syscall
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..7 selftests: proc: proc-self-syscall [PASS]
selftests: proc: proc-self-wchan
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..8 selftests: proc: proc-self-wchan [PASS]
selftests: proc: proc-uptime-001
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..9 selftests: proc: proc-uptime-001 [PASS]
selftests: proc: proc-uptime-002
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..10 selftests: proc: proc-uptime-002 [PASS]
selftests: proc: read
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..11 selftests: proc: read [PASS]
selftests: proc: self
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..12 selftests: proc: self [PASS]
selftests: proc: thread-self
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..13 selftests: proc: thread-self [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471=
641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/proc'

2019-03-02 12:16:33 make run_tests -C pstore
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647=
1641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/pstore'
TAP version 13
selftests: pstore: pstore_tests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D Pstore unit tests (pstore_tests) =3D=3D=3D
UUID=3D8057524d-7e21-4f7b-9c33-55d90daef23c
Checking pstore backend is registered ... ok
	backend=3Dramoops
	cmdline=3Dip=3D::::vm-snb-4G-1019::dhcp root=3D/dev/ram0 user=3Dlkp job=3D=
/lkp/jobs/scheduled/vm-snb-4G-1019/kernel_selftests-kselftests-02-debian-x8=
6_64-2018-04-03.cgz-997dd9647-20190302-13226-yk1d47-4.yaml ARCH=3Dx86_64 kc=
onfig=3Dx86_64-rhel-7.2 branch=3Dlinux-devel/devel-hourly-2019022709 commit=
=3D997dd96471641e147cb2c33ad54284000d0f5e35 BOOT_IMAGE=3D/pkg/linux/x86_64-=
rhel-7.2/gcc-7/997dd96471641e147cb2c33ad54284000d0f5e35/vmlinuz-5.0.0-rc3-0=
0325-g997dd964 erst_disable max_uptime=3D3600 RESULT_ROOT=3D/result/kernel_=
selftests/kselftests-02/vm-snb-4G/debian-x86_64-2018-04-03.cgz/x86_64-rhel-=
7.2/gcc-7/997dd96471641e147cb2c33ad54284000d0f5e35/4 LKP_SERVER=3Dinn debug=
 apic=3Ddebug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=3D100 net=
=2Eifnames=3D0 printk.devkmsg=3Don panic=3D-1 softlockup_panic=3D1 nmi_watc=
hdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 drbd.minor_co=
unt=3D8 systemd.log_level=3Derr ignore_loglevel console=3Dtty0 earlyprintk=
=3DttyS0,115200 console=3DttyS0,115200 vga=3Dnormal rw rcuperf.shutdown=3D0
Checking pstore console is registered ... ok
Checking /dev/pmsg0 exists ... ok
Writing unique string to /dev/pmsg0 ... ok
ok 1..1 selftests: pstore: pstore_tests [PASS]
selftests: pstore: pstore_post_reboot_tests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D Pstore unit tests (pstore_post_reboot_tests) =3D=3D=3D
UUID=3De3401c7a-d241-4caf-874d-a86e33421241
Checking pstore backend is registered ... ok
	backend=3Dramoops
	cmdline=3Dip=3D::::vm-snb-4G-1019::dhcp root=3D/dev/ram0 user=3Dlkp job=3D=
/lkp/jobs/scheduled/vm-snb-4G-1019/kernel_selftests-kselftests-02-debian-x8=
6_64-2018-04-03.cgz-997dd9647-20190302-13226-yk1d47-4.yaml ARCH=3Dx86_64 kc=
onfig=3Dx86_64-rhel-7.2 branch=3Dlinux-devel/devel-hourly-2019022709 commit=
=3D997dd96471641e147cb2c33ad54284000d0f5e35 BOOT_IMAGE=3D/pkg/linux/x86_64-=
rhel-7.2/gcc-7/997dd96471641e147cb2c33ad54284000d0f5e35/vmlinuz-5.0.0-rc3-0=
0325-g997dd964 erst_disable max_uptime=3D3600 RESULT_ROOT=3D/result/kernel_=
selftests/kselftests-02/vm-snb-4G/debian-x86_64-2018-04-03.cgz/x86_64-rhel-=
7.2/gcc-7/997dd96471641e147cb2c33ad54284000d0f5e35/4 LKP_SERVER=3Dinn debug=
 apic=3Ddebug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=3D100 net=
=2Eifnames=3D0 printk.devkmsg=3Don panic=3D-1 softlockup_panic=3D1 nmi_watc=
hdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 drbd.minor_co=
unt=3D8 systemd.log_level=3Derr ignore_loglevel console=3Dtty0 earlyprintk=
=3DttyS0,115200 console=3DttyS0,115200 vga=3Dnormal rw rcuperf.shutdown=3D0
pstore_crash_test has not been executed yet. we skip further tests.
not ok 1..2 selftests: pstore: pstore_post_reboot_tests [SKIP]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471=
641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/pstore'
ptp test: not in Makefile
2019-03-02 12:16:33 make TARGETS=3Dptp
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9=
6471641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/ptp'
Makefile:10: warning: overriding recipe for target 'clean'
=2E./lib.mk:137: warning: ignoring old recipe for target 'clean'
gcc -I../../../../usr/include/    testptp.c  -lrt -o testptp
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96=
471641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/ptp'

2019-03-02 12:16:33 make run_tests -C ptp
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647=
1641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/ptp'
Makefile:10: warning: overriding recipe for target 'clean'
=2E./lib.mk:137: warning: ignoring old recipe for target 'clean'
TAP version 13
selftests: ptp: testptp
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..1 selftests: ptp: testptp [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471=
641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/ptp'

2019-03-02 12:16:33 make run_tests -C ptrace
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647=
1641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/ptrace'
gcc -iquote../../../../include/uapi -Wall    peeksiginfo.c  -o /usr/src/per=
f_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f5e35/tools/=
testing/selftests/ptrace/peeksiginfo
TAP version 13
selftests: ptrace: peeksiginfo
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
PASS
ok 1..1 selftests: ptrace: peeksiginfo [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471=
641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/ptrace'

2019-03-02 12:16:34 make run_tests -C rtc
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647=
1641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/rtc'
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  rtctest.c  -o /usr/src=
/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f5e35/to=
ols/testing/selftests/rtc/rtctest
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  setdate.c  -o /usr/src=
/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f5e35/to=
ols/testing/selftests/rtc/setdate
TAP version 13
selftests: rtc: rtctest
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
rtctest.c:49:rtc.date_read:Current RTC date/time is 02/03/2019 12:16:35.
rtctest.c:137:rtc.alarm_alm_set:Alarm time now set to 12:16:44.
rtctest.c:198:rtc.alarm_wkalm_set:Alarm time now set to 02/03/2019 12:16:47.
[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] Running 5 tests from 2 test cases.
[ RUN      ] rtc.date_read
[       OK ] rtc.date_read
[ RUN      ] rtc.uie_read
[       OK ] rtc.uie_read
[ RUN      ] rtc.uie_select
[       OK ] rtc.uie_select
[ RUN      ] rtc.alarm_alm_set
[       OK ] rtc.alarm_alm_set
[ RUN      ] rtc.alarm_wkalm_set
[       OK ] rtc.alarm_wkalm_set
[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] 5 / 5 tests passed.
[  PASSED  ]
ok 1..1 selftests: rtc: rtctest [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471=
641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/rtc'

2019-03-02 12:16:46 make run_tests -C seccomp
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647=
1641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/seccomp'
gcc -Wl,-no-as-needed -Wall  -lpthread seccomp_bpf.c -o seccomp_bpf
gcc -Wl,-no-as-needed -Wall    seccomp_benchmark.c   -o seccomp_benchmark
TAP version 13
selftests: seccomp: seccomp_bpf
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] Running 72 tests from 1 test cases.
[ RUN      ] global.mode_strict_support
[       OK ] global.mode_strict_support
[ RUN      ] global.mode_strict_cannot_call_prctl
[       OK ] global.mode_strict_cannot_call_prctl
[ RUN      ] global.no_new_privs_support
[       OK ] global.no_new_privs_support
[ RUN      ] global.mode_filter_support
[       OK ] global.mode_filter_support
[ RUN      ] global.mode_filter_without_nnp
[       OK ] global.mode_filter_without_nnp
[ RUN      ] global.filter_size_limits
[       OK ] global.filter_size_limits
[ RUN      ] global.filter_chain_limits
[       OK ] global.filter_chain_limits
[ RUN      ] global.mode_filter_cannot_move_to_strict
[       OK ] global.mode_filter_cannot_move_to_strict
[ RUN      ] global.mode_filter_get_seccomp
[       OK ] global.mode_filter_get_seccomp
[ RUN      ] global.ALLOW_all
[       OK ] global.ALLOW_all
[ RUN      ] global.empty_prog
[       OK ] global.empty_prog
[ RUN      ] global.log_all
[       OK ] global.log_all
[ RUN      ] global.unknown_ret_is_kill_inside
[       OK ] global.unknown_ret_is_kill_inside
[ RUN      ] global.unknown_ret_is_kill_above_allow
[       OK ] global.unknown_ret_is_kill_above_allow
[ RUN      ] global.KILL_all
[       OK ] global.KILL_all
[ RUN      ] global.KILL_one
[       OK ] global.KILL_one
[ RUN      ] global.KILL_one_arg_one
[       OK ] global.KILL_one_arg_one
[ RUN      ] global.KILL_one_arg_six
[       OK ] global.KILL_one_arg_six
[ RUN      ] global.KILL_thread
[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] Running 72 tests from 1 test cases.
[ RUN      ] global.mode_strict_support
[       OK ] global.mode_strict_support
[ RUN      ] global.mode_strict_cannot_call_prctl
[       OK ] global.mode_strict_cannot_call_prctl
[ RUN      ] global.no_new_privs_support
[       OK ] global.no_new_privs_support
[ RUN      ] global.mode_filter_support
[       OK ] global.mode_filter_support
[ RUN      ] global.mode_filter_without_nnp
[       OK ] global.mode_filter_without_nnp
[ RUN      ] global.filter_size_limits
[       OK ] global.filter_size_limits
[ RUN      ] global.filter_chain_limits
[       OK ] global.filter_chain_limits
[ RUN      ] global.mode_filter_cannot_move_to_strict
[       OK ] global.mode_filter_cannot_move_to_strict
[ RUN      ] global.mode_filter_get_seccomp
[       OK ] global.mode_filter_get_seccomp
[ RUN      ] global.ALLOW_all
[       OK ] global.ALLOW_all
[ RUN      ] global.empty_prog
[       OK ] global.empty_prog
[ RUN      ] global.log_all
[       OK ] global.log_all
[ RUN      ] global.unknown_ret_is_kill_inside
[       OK ] global.unknown_ret_is_kill_inside
[ RUN      ] global.unknown_ret_is_kill_above_allow
[       OK ] global.unknown_ret_is_kill_above_allow
[ RUN      ] global.KILL_all
[       OK ] global.KILL_all
[ RUN      ] global.KILL_one
[       OK ] global.KILL_one
[ RUN      ] global.KILL_one_arg_one
[       OK ] global.KILL_one_arg_one
[ RUN      ] global.KILL_one_arg_six
[       OK ] global.KILL_one_arg_six
[ RUN      ] global.KILL_thread
[       OK ] global.KILL_thread
[ RUN      ] global.KILL_process
[       OK ] global.KILL_process
[ RUN      ] global.arg_out_of_range
[       OK ] global.arg_out_of_range
[ RUN      ] global.ERRNO_valid
[       OK ] global.ERRNO_valid
[ RUN      ] global.ERRNO_zero
[       OK ] global.ERRNO_zero
[ RUN      ] global.ERRNO_capped
[       OK ] global.ERRNO_capped
[ RUN      ] global.ERRNO_order
[       OK ] global.ERRNO_order
[ RUN      ] TRAP.dfl
[       OK ] TRAP.dfl
[ RUN      ] TRAP.ign
[       OK ] TRAP.ign
[ RUN      ] TRAP.handler
[       OK ] TRAP.handler
[ RUN      ] precedence.allow_ok
[       OK ] precedence.allow_ok
[ RUN      ] precedence.kill_is_highest
[       OK ] precedence.kill_is_highest
[ RUN      ] precedence.kill_is_highest_in_any_order
[       OK ] precedence.kill_is_highest_in_any_order
[ RUN      ] precedence.trap_is_second
[       OK ] precedence.trap_is_second
[ RUN      ] precedence.trap_is_second_in_any_order
[       OK ] precedence.trap_is_second_in_any_order
[ RUN      ] precedence.errno_is_third
[       OK ] precedence.errno_is_third
[ RUN      ] precedence.errno_is_third_in_any_order
[       OK ] precedence.errno_is_third_in_any_order
[ RUN      ] precedence.trace_is_fourth
[       OK ] precedence.trace_is_fourth
[ RUN      ] precedence.trace_is_fourth_in_any_order
[       OK ] precedence.trace_is_fourth_in_any_order
[ RUN      ] precedence.log_is_fifth
[       OK ] precedence.log_is_fifth
[ RUN      ] precedence.log_is_fifth_in_any_order
[       OK ] precedence.log_is_fifth_in_any_order
[ RUN      ] TRACE_poke.read_has_side_effects
[       OK ] TRACE_poke.read_has_side_effects
[ RUN      ] TRACE_poke.getpid_runs_normally
[       OK ] TRACE_poke.getpid_runs_normally
[ RUN      ] TRACE_syscall.ptrace_syscall_redirected
[       OK ] TRACE_syscall.ptrace_syscall_redirected
[ RUN      ] TRACE_syscall.ptrace_syscall_dropped
[       OK ] TRACE_syscall.ptrace_syscall_dropped
[ RUN      ] TRACE_syscall.syscall_allowed
[       OK ] TRACE_syscall.syscall_allowed
[ RUN      ] TRACE_syscall.syscall_redirected
[       OK ] TRACE_syscall.syscall_redirected
[ RUN      ] TRACE_syscall.syscall_dropped
[       OK ] TRACE_syscall.syscall_dropped
[ RUN      ] TRACE_syscall.skip_after_RET_TRACE
[       OK ] TRACE_syscall.skip_after_RET_TRACE
[ RUN      ] TRACE_syscall.kill_after_RET_TRACE
[       OK ] TRACE_syscall.kill_after_RET_TRACE
[ RUN      ] TRACE_syscall.skip_after_ptrace
[       OK ] TRACE_syscall.skip_after_ptrace
[ RUN      ] TRACE_syscall.kill_after_ptrace
[       OK ] TRACE_syscall.kill_after_ptrace
[ RUN      ] global.seccomp_syscall
[       OK ] global.seccomp_syscall
[ RUN      ] global.seccomp_syscall_mode_lock
[       OK ] global.seccomp_syscall_mode_lock
[ RUN      ] global.detect_seccomp_filter_flags
[       OK ] global.detect_seccomp_filter_flags
[ RUN      ] global.TSYNC_first
[       OK ] global.TSYNC_first
[ RUN      ] TSYNC.siblings_fail_prctl
[       OK ] TSYNC.siblings_fail_prctl
[ RUN      ] TSYNC.two_siblings_with_ancestor
[       OK ] TSYNC.two_siblings_with_ancestor
[ RUN      ] TSYNC.two_sibling_want_nnp
[       OK ] TSYNC.two_sibling_want_nnp
[ RUN      ] TSYNC.two_siblings_with_no_filter
[       OK ] TSYNC.two_siblings_with_no_filter
[ RUN      ] TSYNC.two_siblings_with_one_divergence
[       OK ] TSYNC.two_siblings_with_one_divergence
[ RUN      ] TSYNC.two_siblings_not_under_filter
[       OK ] TSYNC.two_siblings_not_under_filter
[ RUN      ] global.syscall_restart
[       OK ] global.syscall_restart
[ RUN      ] global.filter_flag_log
[       OK ] global.filter_flag_log
[ RUN      ] global.get_action_avail
[       OK ] global.get_action_avail
[ RUN      ] global.get_metadata
[       OK ] global.get_metadata
[ RUN      ] global.user_notification_basic
comp_syscall
[       OK ] global.seccomp_syscall
[ RUN      ] global.seccomp_syscall_mode_lock
[       OK ] global.seccomp_syscall_mode_lock
[ RUN      ] global.detect_seccomp_filter_flags
[       OK ] global.detect_seccomp_filter_flags
[ RUN      ] global.TSYNC_first
[       OK ] global.TSYNC_first
[ RUN      ] TSYNC.siblings_fail_prctl
[       OK ] TSYNC.siblings_fail_prctl
[ RUN      ] TSYNC.two_siblings_with_ancestor
[       OK ] TSYNC.two_siblings_with_ancestor
[ RUN      ] TSYNC.two_sibling_want_nnp
[       OK ] TSYNC.two_sibling_want_nnp
[ RUN      ] TSYNC.two_siblings_with_no_filter
[       OK ] TSYNC.two_siblings_with_no_filter
[ RUN      ] TSYNC.two_siblings_with_one_divergence
[       OK ] TSYNC.two_siblings_with_one_divergence
[ RUN      ] TSYNC.two_siblings_not_under_filter
[       OK ] TSYNC.two_siblings_not_under_filter
[ RUN      ] global.syscall_restart
[       OK ] global.syscall_restart
[ RUN      ] global.filter_flag_log
[       OK ] global.filter_flag_log
[ RUN      ] global.get_action_avail
[       OK ] global.get_action_avail
[ RUN      ] global.get_metadata
[       OK ] global.get_metadata
[ RUN      ] global.user_notification_basic
comp_syscall
[       OK ] global.seccomp_syscall
[ RUN      ] global.seccomp_syscall_mode_lock
[       OK ] global.seccomp_syscall_mode_lock
[ RUN      ] global.detect_seccomp_filter_flags
[       OK ] global.detect_seccomp_filter_flags
[ RUN      ] global.TSYNC_first
[       OK ] global.TSYNC_first
[ RUN      ] TSYNC.siblings_fail_prctl
[       OK ] TSYNC.siblings_fail_prctl
[ RUN      ] TSYNC.two_siblings_with_ancestor
[       OK ] TSYNC.two_siblings_with_ancestor
[ RUN      ] TSYNC.two_sibling_want_nnp
[       OK ] TSYNC.two_sibling_want_nnp
[ RUN      ] TSYNC.two_siblings_with_no_filter
[       OK ] TSYNC.two_siblings_with_no_filter
[ RUN      ] TSYNC.two_siblings_with_one_divergence
[       OK ] TSYNC.two_siblings_with_one_divergence
[ RUN      ] TSYNC.two_siblings_not_under_filter
[       OK ] TSYNC.two_siblings_not_under_filter
[ RUN      ] global.syscall_restart
[       OK ] global.syscall_restart
[ RUN      ] global.filter_flag_log
[       OK ] global.filter_flag_log
[ RUN      ] global.get_action_avail
[       OK ] global.get_action_avail
[ RUN      ] global.get_metadata
[       OK ] global.get_metadata
[ RUN      ] global.user_notification_basic
[       OK ] global.user_notification_basic
[ RUN      ] global.user_notification_kill_in_middle
[       OK ] global.user_notification_kill_in_middle
[ RUN      ] global.user_notification_signal
comp_syscall
[       OK ] global.seccomp_syscall
[ RUN      ] global.seccomp_syscall_mode_lock
[       OK ] global.seccomp_syscall_mode_lock
[ RUN      ] global.detect_seccomp_filter_flags
[       OK ] global.detect_seccomp_filter_flags
[ RUN      ] global.TSYNC_first
[       OK ] global.TSYNC_first
[ RUN      ] TSYNC.siblings_fail_prctl
[       OK ] TSYNC.siblings_fail_prctl
[ RUN      ] TSYNC.two_siblings_with_ancestor
[       OK ] TSYNC.two_siblings_with_ancestor
[ RUN      ] TSYNC.two_sibling_want_nnp
[       OK ] TSYNC.two_sibling_want_nnp
[ RUN      ] TSYNC.two_siblings_with_no_filter
[       OK ] TSYNC.two_siblings_with_no_filter
[ RUN      ] TSYNC.two_siblings_with_one_divergence
[       OK ] TSYNC.two_siblings_with_one_divergence
[ RUN      ] TSYNC.two_siblings_not_under_filter
[       OK ] TSYNC.two_siblings_not_under_filter
[ RUN      ] global.syscall_restart
[       OK ] global.syscall_restart
[ RUN      ] global.filter_flag_log
[       OK ] global.filter_flag_log
[ RUN      ] global.get_action_avail
[       OK ] global.get_action_avail
[ RUN      ] global.get_metadata
[       OK ] global.get_metadata
[ RUN      ] global.user_notification_basic
[       OK ] global.user_notification_basic
[ RUN      ] global.user_notification_kill_in_middle
[       OK ] global.user_notification_kill_in_middle
[ RUN      ] global.user_notification_signal
[       OK ] global.user_notification_signal
[ RUN      ] global.user_notification_closed_listener
comp_syscall
[       OK ] global.seccomp_syscall
[ RUN      ] global.seccomp_syscall_mode_lock
[       OK ] global.seccomp_syscall_mode_lock
[ RUN      ] global.detect_seccomp_filter_flags
[       OK ] global.detect_seccomp_filter_flags
[ RUN      ] global.TSYNC_first
[       OK ] global.TSYNC_first
[ RUN      ] TSYNC.siblings_fail_prctl
[       OK ] TSYNC.siblings_fail_prctl
[ RUN      ] TSYNC.two_siblings_with_ancestor
[       OK ] TSYNC.two_siblings_with_ancestor
[ RUN      ] TSYNC.two_sibling_want_nnp
[       OK ] TSYNC.two_sibling_want_nnp
[ RUN      ] TSYNC.two_siblings_with_no_filter
[       OK ] TSYNC.two_siblings_with_no_filter
[ RUN      ] TSYNC.two_siblings_with_one_divergence
[       OK ] TSYNC.two_siblings_with_one_divergence
[ RUN      ] TSYNC.two_siblings_not_under_filter
[       OK ] TSYNC.two_siblings_not_under_filter
[ RUN      ] global.syscall_restart
[       OK ] global.syscall_restart
[ RUN      ] global.filter_flag_log
[       OK ] global.filter_flag_log
[ RUN      ] global.get_action_avail
[       OK ] global.get_action_avail
[ RUN      ] global.get_metadata
[       OK ] global.get_metadata
[ RUN      ] global.user_notification_basic
[       OK ] global.user_notification_basic
[ RUN      ] global.user_notification_kill_in_middle
[       OK ] global.user_notification_kill_in_middle
[ RUN      ] global.user_notification_signal
[       OK ] global.user_notification_signal
[ RUN      ] global.user_notification_closed_listener
[       OK ] global.user_notification_closed_listener
[ RUN      ] global.user_notification_child_pid_ns
comp_syscall
[       OK ] global.seccomp_syscall
[ RUN      ] global.seccomp_syscall_mode_lock
[       OK ] global.seccomp_syscall_mode_lock
[ RUN      ] global.detect_seccomp_filter_flags
[       OK ] global.detect_seccomp_filter_flags
[ RUN      ] global.TSYNC_first
[       OK ] global.TSYNC_first
[ RUN      ] TSYNC.siblings_fail_prctl
[       OK ] TSYNC.siblings_fail_prctl
[ RUN      ] TSYNC.two_siblings_with_ancestor
[       OK ] TSYNC.two_siblings_with_ancestor
[ RUN      ] TSYNC.two_sibling_want_nnp
[       OK ] TSYNC.two_sibling_want_nnp
[ RUN      ] TSYNC.two_siblings_with_no_filter
[       OK ] TSYNC.two_siblings_with_no_filter
[ RUN      ] TSYNC.two_siblings_with_one_divergence
[       OK ] TSYNC.two_siblings_with_one_divergence
[ RUN      ] TSYNC.two_siblings_not_under_filter
[       OK ] TSYNC.two_siblings_not_under_filter
[ RUN      ] global.syscall_restart
[       OK ] global.syscall_restart
[ RUN      ] global.filter_flag_log
[       OK ] global.filter_flag_log
[ RUN      ] global.get_action_avail
[       OK ] global.get_action_avail
[ RUN      ] global.get_metadata
[       OK ] global.get_metadata
[ RUN      ] global.user_notification_basic
[       OK ] global.user_notification_basic
[ RUN      ] global.user_notification_kill_in_middle
[       OK ] global.user_notification_kill_in_middle
[ RUN      ] global.user_notification_signal
[       OK ] global.user_notification_signal
[ RUN      ] global.user_notification_closed_listener
[       OK ] global.user_notification_closed_listener
[ RUN      ] global.user_notification_child_pid_ns
[       OK ] global.user_notification_child_pid_ns
[ RUN      ] global.user_notification_sibling_pid_ns
comp_syscall
[       OK ] global.seccomp_syscall
[ RUN      ] global.seccomp_syscall_mode_lock
[       OK ] global.seccomp_syscall_mode_lock
[ RUN      ] global.detect_seccomp_filter_flags
[       OK ] global.detect_seccomp_filter_flags
[ RUN      ] global.TSYNC_first
[       OK ] global.TSYNC_first
[ RUN      ] TSYNC.siblings_fail_prctl
[       OK ] TSYNC.siblings_fail_prctl
[ RUN      ] TSYNC.two_siblings_with_ancestor
[       OK ] TSYNC.two_siblings_with_ancestor
[ RUN      ] TSYNC.two_sibling_want_nnp
[       OK ] TSYNC.two_sibling_want_nnp
[ RUN      ] TSYNC.two_siblings_with_no_filter
[       OK ] TSYNC.two_siblings_with_no_filter
[ RUN      ] TSYNC.two_siblings_with_one_divergence
[       OK ] TSYNC.two_siblings_with_one_divergence
[ RUN      ] TSYNC.two_siblings_not_under_filter
[       OK ] TSYNC.two_siblings_not_under_filter
[ RUN      ] global.syscall_restart
[       OK ] global.syscall_restart
[ RUN      ] global.filter_flag_log
[       OK ] global.filter_flag_log
[ RUN      ] global.get_action_avail
[       OK ] global.get_action_avail
[ RUN      ] global.get_metadata
[       OK ] global.get_metadata
[ RUN      ] global.user_notification_basic
[       OK ] global.user_notification_basic
[ RUN      ] global.user_notification_kill_in_middle
[       OK ] global.user_notification_kill_in_middle
[ RUN      ] global.user_notification_signal
[       OK ] global.user_notification_signal
[ RUN      ] global.user_notification_closed_listener
[       OK ] global.user_notification_closed_listener
[ RUN      ] global.user_notification_child_pid_ns
[       OK ] global.user_notification_child_pid_ns
[ RUN      ] global.user_notification_sibling_pid_ns
comp_syscall
[       OK ] global.seccomp_syscall
[ RUN      ] global.seccomp_syscall_mode_lock
[       OK ] global.seccomp_syscall_mode_lock
[ RUN      ] global.detect_seccomp_filter_flags
[       OK ] global.detect_seccomp_filter_flags
[ RUN      ] global.TSYNC_first
[       OK ] global.TSYNC_first
[ RUN      ] TSYNC.siblings_fail_prctl
[       OK ] TSYNC.siblings_fail_prctl
[ RUN      ] TSYNC.two_siblings_with_ancestor
[       OK ] TSYNC.two_siblings_with_ancestor
[ RUN      ] TSYNC.two_sibling_want_nnp
[       OK ] TSYNC.two_sibling_want_nnp
[ RUN      ] TSYNC.two_siblings_with_no_filter
[       OK ] TSYNC.two_siblings_with_no_filter
[ RUN      ] TSYNC.two_siblings_with_one_divergence
[       OK ] TSYNC.two_siblings_with_one_divergence
[ RUN      ] TSYNC.two_siblings_not_under_filter
[       OK ] TSYNC.two_siblings_not_under_filter
[ RUN      ] global.syscall_restart
[       OK ] global.syscall_restart
[ RUN      ] global.filter_flag_log
[       OK ] global.filter_flag_log
[ RUN      ] global.get_action_avail
[       OK ] global.get_action_avail
[ RUN      ] global.get_metadata
[       OK ] global.get_metadata
[ RUN      ] global.user_notification_basic
[       OK ] global.user_notification_basic
[ RUN      ] global.user_notification_kill_in_middle
[       OK ] global.user_notification_kill_in_middle
[ RUN      ] global.user_notification_signal
[       OK ] global.user_notification_signal
[ RUN      ] global.user_notification_closed_listener
[       OK ] global.user_notification_closed_listener
[ RUN      ] global.user_notification_child_pid_ns
[       OK ] global.user_notification_child_pid_ns
[ RUN      ] global.user_notification_sibling_pid_ns
comp_syscall
[       OK ] global.seccomp_syscall
[ RUN      ] global.seccomp_syscall_mode_lock
[       OK ] global.seccomp_syscall_mode_lock
[ RUN      ] global.detect_seccomp_filter_flags
[       OK ] global.detect_seccomp_filter_flags
[ RUN      ] global.TSYNC_first
[       OK ] global.TSYNC_first
[ RUN      ] TSYNC.siblings_fail_prctl
[       OK ] TSYNC.siblings_fail_prctl
[ RUN      ] TSYNC.two_siblings_with_ancestor
[       OK ] TSYNC.two_siblings_with_ancestor
[ RUN      ] TSYNC.two_sibling_want_nnp
[       OK ] TSYNC.two_sibling_want_nnp
[ RUN      ] TSYNC.two_siblings_with_no_filter
[       OK ] TSYNC.two_siblings_with_no_filter
[ RUN      ] TSYNC.two_siblings_with_one_divergence
[       OK ] TSYNC.two_siblings_with_one_divergence
[ RUN      ] TSYNC.two_siblings_not_under_filter
[       OK ] TSYNC.two_siblings_not_under_filter
[ RUN      ] global.syscall_restart
[       OK ] global.syscall_restart
[ RUN      ] global.filter_flag_log
[       OK ] global.filter_flag_log
[ RUN      ] global.get_action_avail
[       OK ] global.get_action_avail
[ RUN      ] global.get_metadata
[       OK ] global.get_metadata
[ RUN      ] global.user_notification_basic
[       OK ] global.user_notification_basic
[ RUN      ] global.user_notification_kill_in_middle
[       OK ] global.user_notification_kill_in_middle
[ RUN      ] global.user_notification_signal
[       OK ] global.user_notification_signal
[ RUN      ] global.user_notification_closed_listener
[       OK ] global.user_notification_closed_listener
[ RUN      ] global.user_notification_child_pid_ns
[       OK ] global.user_notification_child_pid_ns
[ RUN      ] global.user_notification_sibling_pid_ns
[       OK ] global.user_notification_sibling_pid_ns
[ RUN      ] global.user_notification_fault_recv
comp_syscall
[       OK ] global.seccomp_syscall
[ RUN      ] global.seccomp_syscall_mode_lock
[       OK ] global.seccomp_syscall_mode_lock
[ RUN      ] global.detect_seccomp_filter_flags
[       OK ] global.detect_seccomp_filter_flags
[ RUN      ] global.TSYNC_first
[       OK ] global.TSYNC_first
[ RUN      ] TSYNC.siblings_fail_prctl
[       OK ] TSYNC.siblings_fail_prctl
[ RUN      ] TSYNC.two_siblings_with_ancestor
[       OK ] TSYNC.two_siblings_with_ancestor
[ RUN      ] TSYNC.two_sibling_want_nnp
[       OK ] TSYNC.two_sibling_want_nnp
[ RUN      ] TSYNC.two_siblings_with_no_filter
[       OK ] TSYNC.two_siblings_with_no_filter
[ RUN      ] TSYNC.two_siblings_with_one_divergence
[       OK ] TSYNC.two_siblings_with_one_divergence
[ RUN      ] TSYNC.two_siblings_not_under_filter
[       OK ] TSYNC.two_siblings_not_under_filter
[ RUN      ] global.syscall_restart
[       OK ] global.syscall_restart
[ RUN      ] global.filter_flag_log
[       OK ] global.filter_flag_log
[ RUN      ] global.get_action_avail
[       OK ] global.get_action_avail
[ RUN      ] global.get_metadata
[       OK ] global.get_metadata
[ RUN      ] global.user_notification_basic
[       OK ] global.user_notification_basic
[ RUN      ] global.user_notification_kill_in_middle
[       OK ] global.user_notification_kill_in_middle
[ RUN      ] global.user_notification_signal
[       OK ] global.user_notification_signal
[ RUN      ] global.user_notification_closed_listener
[       OK ] global.user_notification_closed_listener
[ RUN      ] global.user_notification_child_pid_ns
[       OK ] global.user_notification_child_pid_ns
[ RUN      ] global.user_notification_sibling_pid_ns
[       OK ] global.user_notification_sibling_pid_ns
[ RUN      ] global.user_notification_fault_recv
[       OK ] global.user_notification_fault_recv
[ RUN      ] global.seccomp_get_notif_sizes
[       OK ] global.seccomp_get_notif_sizes
[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] 72 / 72 tests passed.
[  PASSED  ]
ok 1..1 selftests: seccomp: seccomp_bpf [PASS]
selftests: seccomp: seccomp_benchmark
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Calibrating reasonable sample size...
1551500209.437535461 - 1551500209.437518589 =3D 16872
1551500209.437588771 - 1551500209.437546726 =3D 42045
1551500209.437653943 - 1551500209.437591153 =3D 62790
1551500209.439971623 - 1551500209.437655789 =3D 2315834
1551500209.440228787 - 1551500209.439975220 =3D 253567
1551500209.440786341 - 1551500209.440231590 =3D 554751
1551500209.444106498 - 1551500209.440789172 =3D 3317326
1551500209.453270343 - 1551500209.444112283 =3D 9158060
1551500209.470761541 - 1551500209.453277760 =3D 17483781
1551500209.479659272 - 1551500209.470770205 =3D 8889067
1551500209.496162685 - 1551500209.479665982 =3D 16496703
1551500209.528526731 - 1551500209.496169999 =3D 32356732
1551500209.596893011 - 1551500209.528533528 =3D 68359483
1551500209.727380093 - 1551500209.596900390 =3D 130479703
1551500209.985417772 - 1551500209.727387460 =3D 258030312
1551500210.725693794 - 1551500209.985425040 =3D 740268754
1551500212.057371101 - 1551500210.725701579 =3D 1331669522
1551500214.133055315 - 1551500212.057379959 =3D 2075675356
1551500218.442781923 - 1551500214.133062951 =3D 4309718972
1551500227.647919681 - 1551500218.442789596 =3D 9205130085
Benchmarking 16777216 samples...
25.617469420 - 16.876335086 =3D 8741134334
getpid native: 521 ns
37.507159568 - 25.617567429 =3D 11889592139
getpid RET_ALLOW: 708 ns
Estimated seccomp overhead per syscall: 187 ns
ok 1..2 selftests: seccomp: seccomp_benchmark [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471=
641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/seccomp'

2019-03-02 12:17:29 make run_tests -C sigaltstack
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647=
1641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/sigaltstack'
gcc -Wall    sas.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647164=
1e147cb2c33ad54284000d0f5e35/tools/testing/selftests/sigaltstack/sas
TAP version 13
selftests: sigaltstack: sas
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1 Initial sigaltstack state was SS_DISABLE
# [RUN]	signal USR1
ok 2 sigaltstack is disabled in sighandler
# [RUN]	switched to user ctx
# [RUN]	signal USR2
# [OK]	Stack preserved
ok 3 sigaltstack is still SS_AUTODISARM after signal
Pass 3 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..3
ok 1..1 selftests: sigaltstack: sas [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471=
641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/sigaltstack'

2019-03-02 12:17:29 make run_tests -C size
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647=
1641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/size'
gcc -static -ffreestanding -nostartfiles -s    get_size.c  -o /usr/src/perf=
_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f5e35/tools/t=
esting/selftests/size/get_size
TAP version 13
selftests: size: get_size
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
TAP version 13
# Testing system size.
ok 1 get runtime memory use
# System runtime memory report (units in Kilobytes):
 ---
 Total:  4033180
 Free:   1877908
 Buffer: 0
 In use: 2155272
 ...
1..1
ok 1..1 selftests: size: get_size [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471=
641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/size'

2019-03-02 12:17:30 make run_tests -C sparc64
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647=
1641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/sparc64'
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471=
641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/sparc64'

2019-03-02 12:17:30 make run_tests -C splice
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647=
1641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/splice'
gcc     default_file_splice_read.c  -o /usr/src/perf_selftests-x86_64-rhel-=
7.2-997dd96471641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/splice=
/default_file_splice_read
TAP version 13
selftests: splice: default_file_splice_read.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..1 selftests: splice: default_file_splice_read.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471=
641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/splice'

2019-03-02 12:17:30 make run_tests -C static_keys
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647=
1641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/static_keys'
TAP version 13
selftests: static_keys: test_static_keys.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
static_key: ok
ok 1..1 selftests: static_keys: test_static_keys.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471=
641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/static_keys'

2019-03-02 12:17:30 make run_tests -C sync
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647=
1641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/sync'
gcc -c sync_alloc.c -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647164=
1e147cb2c33ad54284000d0f5e35/tools/testing/selftests/sync/sync_alloc.o
gcc -c sync_fence.c -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647164=
1e147cb2c33ad54284000d0f5e35/tools/testing/selftests/sync/sync_fence.o
gcc -c sync_merge.c -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647164=
1e147cb2c33ad54284000d0f5e35/tools/testing/selftests/sync/sync_merge.o
gcc -c sync_wait.c -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641=
e147cb2c33ad54284000d0f5e35/tools/testing/selftests/sync/sync_wait.o
gcc -c sync_stress_parallelism.c -o /usr/src/perf_selftests-x86_64-rhel-7.2=
-997dd96471641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/sync/sync=
_stress_parallelism.o
gcc -c sync_stress_consumer.c -o /usr/src/perf_selftests-x86_64-rhel-7.2-99=
7dd96471641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/sync/sync_st=
ress_consumer.o
gcc -c sync_stress_merge.c -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd=
96471641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/sync/sync_stres=
s_merge.o
gcc -c sync_test.c -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641=
e147cb2c33ad54284000d0f5e35/tools/testing/selftests/sync/sync_test.o -O2 -g=
 -std=3Dgnu89 -pthread -Wall -Wextra -I../../../../usr/include/
gcc -c sync.c -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147c=
b2c33ad54284000d0f5e35/tools/testing/selftests/sync/sync.o -O2 -g -std=3Dgn=
u89 -pthread -Wall -Wextra -I../../../../usr/include/
gcc -o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad542=
84000d0f5e35/tools/testing/selftests/sync/sync_test /usr/src/perf_selftests=
-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f5e35/tools/testing/sel=
ftests/sync/sync_test.o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd964716=
41e147cb2c33ad54284000d0f5e35/tools/testing/selftests/sync/sync.o /usr/src/=
perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f5e35/too=
ls/testing/selftests/sync/sync_alloc.o /usr/src/perf_selftests-x86_64-rhel-=
7.2-997dd96471641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/sync/s=
ync_fence.o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33=
ad54284000d0f5e35/tools/testing/selftests/sync/sync_merge.o /usr/src/perf_s=
elftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d0f5e35/tools/tes=
ting/selftests/sync/sync_wait.o /usr/src/perf_selftests-x86_64-rhel-7.2-997=
dd96471641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/sync/sync_str=
ess_parallelism.o /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147=
cb2c33ad54284000d0f5e35/tools/testing/selftests/sync/sync_stress_consumer.o=
 /usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471641e147cb2c33ad54284000d=
0f5e35/tools/testing/selftests/sync/sync_stress_merge.o -O2 -g -std=3Dgnu89=
 -pthread -Wall -Wextra -I../../../../usr/include/ -pthread
TAP version 13
selftests: sync: sync_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
# [RUN]	Testing sync framework
ok 1 [RUN]	test_alloc_timeline
ok 2 [RUN]	test_alloc_fence
ok 3 [RUN]	test_alloc_fence_negative
ok 4 [RUN]	test_fence_one_timeline_wait
ok 5 [RUN]	test_fence_one_timeline_merge
ok 6 [RUN]	test_fence_merge_same_fence
ok 7 [RUN]	test_fence_multi_timeline_wait
ok 8 [RUN]	test_stress_two_threads_shared_timeline
ok 9 [RUN]	test_consumer_stress_multi_producer_single_consumer
ok 10 [RUN]	test_merge_stress_random_merge
Pass 10 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..10
ok 1..1 selftests: sync: sync_test [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471=
641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/sync'

2019-03-02 12:17:34 make run_tests -C sysctl
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd9647=
1641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/sysctl'
TAP version 13
selftests: sysctl: sysctl.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Checking production write strict setting ... ok
Sat Mar  2 12:17:34 CST 2019
Running test: sysctl_test_0001 - run #0
=3D=3D Testing sysctl behavior against /proc/sys/debug/test_sysctl/int_0001=
 =3D=3D
Writing test file ... ok
Checking sysctl is not set to test value ... ok
Writing sysctl from shell ... ok
Resetting sysctl to original value ... ok
Writing entire sysctl in single write ... ok
Writing middle of sysctl after synchronized seek ... ok
Writing beyond end of sysctl ... ok
Writing sysctl with multiple long writes ... ok
Checking ignoring spaces up to PAGE_SIZE works on write ...ok
Checking passing PAGE_SIZE of spaces fails on write ...ok
Sat Mar  2 12:17:35 CST 2019
Running test: sysctl_test_0002 - run #0
=3D=3D Testing sysctl behavior against /proc/sys/debug/test_sysctl/string_0=
001 =3D=3D
Writing test file ... ok
Checking sysctl is not set to test value ... ok
Writing sysctl from shell ... ok
Resetting sysctl to original value ... ok
Writing entire sysctl in single write ... ok
Writing middle of sysctl after synchronized seek ... ok
Writing beyond end of sysctl ... ok
Writing sysctl with multiple long writes ... ok
Writing entire sysctl in short writes ... ok
Writing middle of sysctl after unsynchronized seek ... ok
Checking sysctl maxlen is at least 65 ... ok
Checking sysctl keeps original string on overflow append ... ok
Checking sysctl stays NULL terminated on write ... ok
Checking sysctl stays NULL terminated on overwrite ... ok
Sat Mar  2 12:17:35 CST 2019
Running test: sysctl_test_0003 - run #0
=3D=3D Testing sysctl behavior against /proc/sys/debug/test_sysctl/int_0002=
 =3D=3D
Writing test file ... ok
Checking sysctl is not set to test value ... ok
Writing sysctl from shell ... ok
Resetting sysctl to original value ... ok
Writing entire sysctl in single write ... ok
Writing middle of sysctl after synchronized seek ... ok
Writing beyond end of sysctl ... ok
Writing sysctl with multiple long writes ... ok
Checking ignoring spaces up to PAGE_SIZE works on write ...ok
Checking passing PAGE_SIZE of spaces fails on write ...ok
Testing INT_MAX works ...ok
Testing INT_MAX + 1 will fail as expected...ok
Testing negative values will work as expected...ok
Sat Mar  2 12:17:35 CST 2019
Running test: sysctl_test_0004 - run #0
=3D=3D Testing sysctl behavior against /proc/sys/debug/test_sysctl/uint_000=
1 =3D=3D
Writing test file ... ok
Checking sysctl is not set to test value ... ok
Writing sysctl from shell ... ok
Resetting sysctl to original value ... ok
Writing entire sysctl in single write ... ok
Writing middle of sysctl after synchronized seek ... ok
Writing beyond end of sysctl ... ok
Writing sysctl with multiple long writes ... ok
Checking ignoring spaces up to PAGE_SIZE works on write ...ok
Checking passing PAGE_SIZE of spaces fails on write ...ok
Testing UINT_MAX works ...ok
Testing UINT_MAX + 1 will fail as expected...ok
Testing negative values will not work as expected ...ok
Sat Mar  2 12:17:35 CST 2019
Running test: sysctl_test_0005 - run #0
Testing array works as expected ... ok
Testing skipping trailing array elements works ... ok
Testing PAGE_SIZE limit on array works ... ok
Testing exceeding PAGE_SIZE limit fails as expected ... Files - and /proc/s=
ys/debug/test_sysctl/int_0003 differ
ok
Sat Mar  2 12:17:35 CST 2019
Running test: sysctl_test_0005 - run #1
Testing array works as expected ... ok
Testing skipping trailing array elements works ... ok
Testing PAGE_SIZE limit on array works ... ok
Testing exceeding PAGE_SIZE limit fails as expected ... Files - and /proc/s=
ys/debug/test_sysctl/int_0003 differ
ok
Sat Mar  2 12:17:35 CST 2019
Running test: sysctl_test_0005 - run #2
Testing array works as expected ... ok
Testing skipping trailing array elements works ... ok
Testing PAGE_SIZE limit on array works ... ok
Testing exceeding PAGE_SIZE limit fails as expected ... Files - and /proc/s=
ys/debug/test_sysctl/int_0003 differ
ok
ok 1..1 selftests: sysctl: sysctl.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-997dd96471=
641e147cb2c33ad54284000d0f5e35/tools/testing/selftests/sysctl'

--Lb0e7rgc7IsuDeGj--
