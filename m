Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLACK,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67A5C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 04:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE892087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 04:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbfCAESD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 23:18:03 -0500
Received: from mga17.intel.com ([192.55.52.151]:51683 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfCAESC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 23:18:02 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2019 20:17:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,425,1544515200"; 
   d="xz'?scan'208";a="323099510"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.107])
  by fmsmga006.fm.intel.com with ESMTP; 28 Feb 2019 20:17:54 -0800
Date:   Fri, 1 Mar 2019 12:18:08 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Tadeusz Struk <tadeusz.struk@intel.com>,
        Joey Pabalinas <joeypabalinas@gmail.com>,
        Petr Vorel <petr.vorel@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@01.org
Subject: [LKP] [selftests]  6ea3dfe1e0:
 kernel_selftests.tpm2.test_smoke.sh.fail
Message-ID: <20190301041808.GC22104@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="4ZLFUWh1odzi/v6L"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

FYI, we noticed the following commit (built with gcc-7):

commit: 6ea3dfe1e0732c5bd3be1e073690b06a83c03c25 ("selftests: add TPM 2.0 tests")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

in testcase: kernel_selftests
with following parameters:

	group: kselftests-03

test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
test-url: https://www.kernel.org/doc/Documentation/kselftest.txt


on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):




KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25
2019-02-27 15:15:21 ln -sf /usr/bin/clang-7 /usr/bin/clang
2019-02-27 15:15:21 ln -sf /usr/bin/llc-7 /usr/bin/llc

2019-02-27 15:15:21 make run_tests -C timers
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers'
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  posix_timers.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers/posix_timers
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  nanosleep.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers/nanosleep
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  nsleep-lat.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers/nsleep-lat
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  set-timer-lat.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers/set-timer-lat
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  mqueue-lat.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers/mqueue-lat
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  inconsistency-check.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers/inconsistency-check
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  raw_skew.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers/raw_skew
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  threadtest.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers/threadtest
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  rtcpie.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers/rtcpie
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  alarmtimer-suspend.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers/alarmtimer-suspend
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  valid-adjtimex.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers/valid-adjtimex
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  adjtick.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers/adjtick
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  change_skew.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers/change_skew
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  skew_consistency.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers/skew_consistency
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  clocksource-switch.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers/clocksource-switch
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  freq-step.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers/freq-step
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  leap-a-day.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers/leap-a-day
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  leapcrash.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers/leapcrash
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  set-tai.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers/set-tai
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  set-2038.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers/set-2038
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  set-tz.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers/set-tz
TAP version 13
selftests: timers: posix_timers
========================================
Testing posix timers. False negative may happen on CPU execution 
based timers if other threads run on the CPU...
Check itimer virtual... [OK]
Check itimer prof... [OK]
Check itimer real... [OK]
Check timer_create() per thread... [OK]
Check timer_create() per process... [OK]
Pass 0 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..0
ok 1..1 selftests: timers: posix_timers [PASS]
selftests: timers: nanosleep
========================================
Nanosleep CLOCK_REALTIME                  [OK]
Nanosleep CLOCK_MONOTONIC                 [OK]
Nanosleep CLOCK_MONOTONIC_RAW             [UNSUPPORTED]
Nanosleep CLOCK_REALTIME_COARSE           [UNSUPPORTED]
Nanosleep CLOCK_MONOTONIC_COARSE          [UNSUPPORTED]
Nanosleep CLOCK_BOOTTIME                  [OK]
Nanosleep CLOCK_REALTIME_ALARM            [OK]
Nanosleep CLOCK_BOOTTIME_ALARM            [OK]
Nanosleep CLOCK_TAI                       [OK]
Pass 0 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..0
ok 1..2 selftests: timers: nanosleep [PASS]
selftests: timers: nsleep-lat
========================================
nsleep latency CLOCK_REALTIME             [OK]
nsleep latency CLOCK_MONOTONIC            [OK]
nsleep latency CLOCK_MONOTONIC_RAW        [UNSUPPORTED]
nsleep latency CLOCK_REALTIME_COARSE      [UNSUPPORTED]
nsleep latency CLOCK_MONOTONIC_COARSE     [UNSUPPORTED]
nsleep latency CLOCK_BOOTTIME             [OK]
nsleep latency CLOCK_REALTIME_ALARM       [OK]
nsleep latency CLOCK_BOOTTIME_ALARM       [OK]
nsleep latency CLOCK_TAI                  [OK]
Pass 0 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..0
ok 1..3 selftests: timers: nsleep-lat [PASS]
selftests: timers: set-timer-lat
========================================
Setting timers for every 1 seconds
CLOCK_REALTIME         ABSTIME PERIODIC timer fired early:       0 : [OK]
CLOCK_REALTIME         ABSTIME PERIODIC max latency:     112099 ns : [OK]
CLOCK_REALTIME         RELTIME PERIODIC timer fired early:       0 : [OK]
CLOCK_REALTIME         RELTIME PERIODIC max latency:      82088 ns : [OK]
CLOCK_REALTIME         ABSTIME ONE-SHOT timer fired early:       0 : [OK]
CLOCK_REALTIME         ABSTIME ONE-SHOT max latency:      56827 ns : [OK]
CLOCK_REALTIME         ABSTIME ONE-SHOT count:                   1 : [OK]
CLOCK_REALTIME         RELTIME ONE-SHOT timer fired early:       0 : [OK]
CLOCK_REALTIME         RELTIME ONE-SHOT max latency:      73434 ns : [OK]
CLOCK_REALTIME         RELTIME ONE-SHOT count:                   1 : [OK]
CLOCK_MONOTONIC        ABSTIME PERIODIC timer fired early:       0 : [OK]
CLOCK_MONOTONIC        ABSTIME PERIODIC max latency:      90264 ns : [OK]
CLOCK_MONOTONIC        RELTIME PERIODIC timer fired early:       0 : [OK]
CLOCK_MONOTONIC        RELTIME PERIODIC max latency:      90327 ns : [OK]
CLOCK_MONOTONIC        ABSTIME ONE-SHOT timer fired early:       0 : [OK]
CLOCK_MONOTONIC        ABSTIME ONE-SHOT max latency:      75888 ns : [OK]
CLOCK_MONOTONIC        ABSTIME ONE-SHOT count:                   1 : [OK]
CLOCK_MONOTONIC        RELTIME ONE-SHOT timer fired early:       0 : [OK]
CLOCK_MONOTONIC        RELTIME ONE-SHOT max latency:      64950 ns : [OK]
CLOCK_MONOTONIC        RELTIME ONE-SHOT count:                   1 : [OK]
CLOCK_BOOTTIME         ABSTIME PERIODIC timer fired early:       0 : [OK]
CLOCK_BOOTTIME         ABSTIME PERIODIC max latency:      83457 ns : [OK]
CLOCK_BOOTTIME         RELTIME PERIODIC timer fired early:       0 : [OK]
CLOCK_BOOTTIME         RELTIME PERIODIC max latency:     118242 ns : [OK]
CLOCK_BOOTTIME         ABSTIME ONE-SHOT timer fired early:       0 : [OK]
CLOCK_BOOTTIME         ABSTIME ONE-SHOT max latency:     101604 ns : [OK]
CLOCK_BOOTTIME         ABSTIME ONE-SHOT count:                   1 : [OK]
CLOCK_BOOTTIME         RELTIME ONE-SHOT timer fired early:       0 : [OK]
CLOCK_BOOTTIME         RELTIME ONE-SHOT max latency:      64288 ns : [OK]
CLOCK_BOOTTIME         RELTIME ONE-SHOT count:                   1 : [OK]
CLOCK_REALTIME_ALARM   ABSTIME PERIODIC timer fired early:       0 : [OK]
CLOCK_REALTIME_ALARM   ABSTIME PERIODIC max latency:      88942 ns : [OK]
CLOCK_REALTIME_ALARM   RELTIME PERIODIC timer fired early:       0 : [OK]
CLOCK_REALTIME_ALARM   RELTIME PERIODIC max latency:      92606 ns : [OK]
CLOCK_REALTIME_ALARM   ABSTIME ONE-SHOT timer fired early:       0 : [OK]
CLOCK_REALTIME_ALARM   ABSTIME ONE-SHOT max latency:      79689 ns : [OK]
CLOCK_REALTIME_ALARM   ABSTIME ONE-SHOT count:                   1 : [OK]
CLOCK_REALTIME_ALARM   RELTIME ONE-SHOT timer fired early:       0 : [OK]
CLOCK_REALTIME_ALARM   RELTIME ONE-SHOT max latency:      73682 ns : [OK]
CLOCK_REALTIME_ALARM   RELTIME ONE-SHOT count:                   1 : [OK]
CLOCK_BOOTTIME_ALARM   ABSTIME PERIODIC timer fired early:       0 : [OK]
CLOCK_BOOTTIME_ALARM   ABSTIME PERIODIC max latency:     111494 ns : [OK]
CLOCK_BOOTTIME_ALARM   RELTIME PERIODIC timer fired early:       0 : [OK]
CLOCK_BOOTTIME_ALARM   RELTIME PERIODIC max latency:     106944 ns : [OK]
CLOCK_BOOTTIME_ALARM   ABSTIME ONE-SHOT timer fired early:       0 : [OK]
CLOCK_BOOTTIME_ALARM   ABSTIME ONE-SHOT max latency:      96530 ns : [OK]
CLOCK_BOOTTIME_ALARM   ABSTIME ONE-SHOT count:                   1 : [OK]
CLOCK_BOOTTIME_ALARM   RELTIME ONE-SHOT timer fired early:       0 : [OK]
CLOCK_BOOTTIME_ALARM   RELTIME ONE-SHOT max latency:      84931 ns : [OK]
CLOCK_BOOTTIME_ALARM   RELTIME ONE-SHOT count:                   1 : [OK]
CLOCK_TAI              ABSTIME PERIODIC timer fired early:       0 : [OK]
CLOCK_TAI              ABSTIME PERIODIC max latency:      96775 ns : [OK]
CLOCK_TAI              RELTIME PERIODIC timer fired early:       0 : [OK]
CLOCK_TAI              RELTIME PERIODIC max latency:      84091 ns : [OK]
CLOCK_TAI              ABSTIME ONE-SHOT timer fired early:       0 : [OK]
CLOCK_TAI              ABSTIME ONE-SHOT max latency:      82905 ns : [OK]
CLOCK_TAI              ABSTIME ONE-SHOT count:                   1 : [OK]
CLOCK_TAI              RELTIME ONE-SHOT timer fired early:       0 : [OK]
CLOCK_TAI              RELTIME ONE-SHOT max latency:     147295 ns : [OK]
CLOCK_TAI              RELTIME ONE-SHOT count:                   1 : [OK]
Pass 0 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..0
ok 1..4 selftests: timers: set-timer-lat [PASS]
selftests: timers: mqueue-lat
========================================
Mqueue latency :                          [OK]
Pass 0 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..0
ok 1..5 selftests: timers: mqueue-lat [PASS]
selftests: timers: inconsistency-check
========================================
Consistent CLOCK_REALTIME                 [OK]
Consistent CLOCK_MONOTONIC                [OK]
Consistent CLOCK_PROCESS_CPUTIME_ID       [OK]
Consistent CLOCK_THREAD_CPUTIME_ID        [OK]
Consistent CLOCK_MONOTONIC_RAW            [OK]
Consistent CLOCK_REALTIME_COARSE          [OK]
Consistent CLOCK_MONOTONIC_COARSE         [OK]
Consistent CLOCK_BOOTTIME                 [OK]
Consistent CLOCK_REALTIME_ALARM           [OK]
Consistent CLOCK_BOOTTIME_ALARM           [OK]
Consistent CLOCK_TAI                      [OK]
Pass 0 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..0
ok 1..6 selftests: timers: inconsistency-check [PASS]
selftests: timers: raw_skew
========================================
Estimating clock drift: 0.0(est) 0.0(act)	[OK]
Pass 0 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..0
ok 1..7 selftests: timers: raw_skew [PASS]
selftests: timers: threadtest
========================================
Wed, 27 Feb 2019 15:23:51 +0800
Testing consistency with 8 threads for 30 seconds: [OK]
Pass 0 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..0
ok 1..8 selftests: timers: threadtest [PASS]
selftests: timers: rtcpie
========================================

Periodic IRQ rate is 1024Hz.
Counting 20 interrupts at:
2Hz:	 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
4Hz:	 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
8Hz:	 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
16Hz:	 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
32Hz:	 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
64Hz:	
PIE delta error: 0.017446 should be close to 0.015625
not ok 1..9 selftests: timers: rtcpie [FAIL]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers'

2019-02-27 15:24:40 make run_tests -C tpm2
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/tpm2'
TAP version 13
selftests: tpm2: test_smoke.sh
========================================
test_seal_with_auth (tpm2_tests.SmokeTest) ... ERROR
test_seal_with_policy (tpm2_tests.SmokeTest) ... ERROR
test_seal_with_too_long_auth (tpm2_tests.SmokeTest) ... ERROR
test_too_short_cmd (tpm2_tests.SmokeTest) ... ERROR
test_unseal_with_wrong_auth (tpm2_tests.SmokeTest) ... ERROR
test_unseal_with_wrong_policy (tpm2_tests.SmokeTest) ... ERROR

======================================================================
ERROR: test_seal_with_auth (tpm2_tests.SmokeTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "tpm2_tests.py", line 15, in setUp
    self.client = tpm2.Client()
  File "tpm2.py", line 360, in __init__
    self.tpm = open('/dev/tpm0', 'r+b')
IOError: [Errno 2] No such file or directory: '/dev/tpm0'

======================================================================
ERROR: test_seal_with_policy (tpm2_tests.SmokeTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "tpm2_tests.py", line 15, in setUp
    self.client = tpm2.Client()
  File "tpm2.py", line 360, in __init__
    self.tpm = open('/dev/tpm0', 'r+b')
IOError: [Errno 2] No such file or directory: '/dev/tpm0'

======================================================================
ERROR: test_seal_with_too_long_auth (tpm2_tests.SmokeTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "tpm2_tests.py", line 15, in setUp
    self.client = tpm2.Client()
  File "tpm2.py", line 360, in __init__
    self.tpm = open('/dev/tpm0', 'r+b')
IOError: [Errno 2] No such file or directory: '/dev/tpm0'

======================================================================
ERROR: test_too_short_cmd (tpm2_tests.SmokeTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "tpm2_tests.py", line 15, in setUp
    self.client = tpm2.Client()
  File "tpm2.py", line 360, in __init__
    self.tpm = open('/dev/tpm0', 'r+b')
IOError: [Errno 2] No such file or directory: '/dev/tpm0'

======================================================================
ERROR: test_unseal_with_wrong_auth (tpm2_tests.SmokeTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "tpm2_tests.py", line 15, in setUp
    self.client = tpm2.Client()
  File "tpm2.py", line 360, in __init__
    self.tpm = open('/dev/tpm0', 'r+b')
IOError: [Errno 2] No such file or directory: '/dev/tpm0'

======================================================================
ERROR: test_unseal_with_wrong_policy (tpm2_tests.SmokeTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "tpm2_tests.py", line 15, in setUp
    self.client = tpm2.Client()
  File "tpm2.py", line 360, in __init__
    self.tpm = open('/dev/tpm0', 'r+b')
IOError: [Errno 2] No such file or directory: '/dev/tpm0'

----------------------------------------------------------------------
Ran 6 tests in 0.001s

FAILED (errors=6)
not ok 1..1 selftests: tpm2: test_smoke.sh [FAIL]
selftests: tpm2: test_space.sh
========================================
test_flush_context (tpm2_tests.SpaceTest) ... ERROR
test_get_handles (tpm2_tests.SpaceTest) ... ERROR
test_invalid_cc (tpm2_tests.SpaceTest) ... ERROR
test_make_two_spaces (tpm2_tests.SpaceTest) ... ERROR

======================================================================
ERROR: test_flush_context (tpm2_tests.SpaceTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "tpm2_tests.py", line 183, in test_flush_context
    space1 = tpm2.Client(tpm2.Client.FLAG_SPACE)
  File "tpm2.py", line 362, in __init__
    self.tpm = open('/dev/tpmrm0', 'r+b')
IOError: [Errno 2] No such file or directory: '/dev/tpmrm0'

======================================================================
ERROR: test_get_handles (tpm2_tests.SpaceTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "tpm2_tests.py", line 193, in test_get_handles
    space1 = tpm2.Client(tpm2.Client.FLAG_SPACE)
  File "tpm2.py", line 362, in __init__
    self.tpm = open('/dev/tpmrm0', 'r+b')
IOError: [Errno 2] No such file or directory: '/dev/tpmrm0'

======================================================================
ERROR: test_invalid_cc (tpm2_tests.SpaceTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "tpm2_tests.py", line 212, in test_invalid_cc
    space1 = tpm2.Client(tpm2.Client.FLAG_SPACE)
  File "tpm2.py", line 362, in __init__
    self.tpm = open('/dev/tpmrm0', 'r+b')
IOError: [Errno 2] No such file or directory: '/dev/tpmrm0'

======================================================================
ERROR: test_make_two_spaces (tpm2_tests.SpaceTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "tpm2_tests.py", line 169, in test_make_two_spaces
    space1 = tpm2.Client(tpm2.Client.FLAG_SPACE)
  File "tpm2.py", line 362, in __init__
    self.tpm = open('/dev/tpmrm0', 'r+b')
IOError: [Errno 2] No such file or directory: '/dev/tpmrm0'

----------------------------------------------------------------------
Ran 4 tests in 0.002s

FAILED (errors=4)
not ok 1..2 selftests: tpm2: test_space.sh [FAIL]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/tpm2'
uevent test: not in Makefile
2019-02-27 15:24:40 make TARGETS=uevent
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/uevent'
gcc -Wl,-no-as-needed -Wall uevent_filtering.c -o uevent_filtering
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/uevent'

2019-02-27 15:24:41 make run_tests -C uevent
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/uevent'
TAP version 13
selftests: uevent: uevent_filtering
========================================
add@/devices/virtual/mem/fullACTION=addDEVPATH=/devices/virtual/mem/fullSUBSYSTEM=memSYNTH_UUID=0MAJOR=1MINOR=7DEVNAME=fullDEVMODE=0666SEQNUM=1697
add@/devices/virtual/mem/fullACTION=addDEVPATH=/devices/virtual/mem/fullSUBSYSTEM=memSYNTH_UUID=0MAJOR=1MINOR=7DEVNAME=fullDEVMODE=0666SEQNUM=1710
No buffer space available - Failed to receive uevent
add@/devices/virtual/mem/fullACTION=addDEVPATH=/devices/virtual/mem/fullSUBSYSTEM=memSYNTH_UUID=0MAJOR=1MINOR=7DEVNAME=fullDEVMODE=0666SEQNUM=1746
add@/devices/virtual/mem/fullACTION=addDEVPATH=/devices/virtual/mem/fullSUBSYSTEM=memSYNTH_UUID=0MAJOR=1MINOR=7DEVNAME=fullDEVMODE=0666SEQNUM=1756
add@/devices/virtual/mem/fullACTION=addDEVPATH=/devices/virtual/mem/fullSUBSYSTEM=memSYNTH_UUID=0MAJOR=1MINOR=7DEVNAME=fullDEVMODE=0666SEQNUM=1769
[==========] Running 1 tests from 1 test cases.
[ RUN      ] global.uevent_filtering
[       OK ] global.uevent_filtering
[==========] 1 / 1 tests passed.
[  PASSED  ]
ok 1..1 selftests: uevent: uevent_filtering [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/uevent'

2019-02-27 15:24:43 make run_tests -C user
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/user'
TAP version 13
selftests: user: test_user_copy.sh
========================================
user_copy: ok
ok 1..1 selftests: user: test_user_copy.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/user'
vDSO test: not in Makefile
2019-02-27 15:24:43 make TARGETS=vDSO
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vDSO'
gcc -std=gnu99    vdso_test.c parse_vdso.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vDSO/vdso_test
gcc -std=gnu99 -nostdlib -fno-asynchronous-unwind-tables -fno-stack-protector \
	vdso_standalone_test_x86.c parse_vdso.c \
	-o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vDSO/vdso_standalone_test_x86
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vDSO'

2019-02-27 15:24:43 make run_tests -C vDSO
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vDSO'
TAP version 13
selftests: vDSO: vdso_test
========================================
The time is 1551252283.583175
ok 1..1 selftests: vDSO: vdso_test [PASS]
selftests: vDSO: vdso_standalone_test_x86
========================================
The time is           1551252283.593524
ok 1..2 selftests: vDSO: vdso_standalone_test_x86 [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vDSO'

2019-02-27 15:24:43 make run_tests -C vm
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vm'
make ARCH=x86 -C ../../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25'
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
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25'
gcc -Wall -I ../../../../usr/include     compaction_test.c -lrt -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vm/compaction_test
gcc -Wall -I ../../../../usr/include     gup_benchmark.c -lrt -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vm/gup_benchmark
gcc -Wall -I ../../../../usr/include     hugepage-mmap.c -lrt -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vm/hugepage-mmap
gcc -Wall -I ../../../../usr/include     hugepage-shm.c -lrt -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vm/hugepage-shm
gcc -Wall -I ../../../../usr/include     map_hugetlb.c -lrt -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vm/map_hugetlb
gcc -Wall -I ../../../../usr/include     map_fixed_noreplace.c -lrt -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vm/map_fixed_noreplace
gcc -Wall -I ../../../../usr/include     map_populate.c -lrt -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vm/map_populate
gcc -Wall -I ../../../../usr/include     mlock-random-test.c -lrt -lcap -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vm/mlock-random-test
gcc -Wall -I ../../../../usr/include     mlock2-tests.c -lrt -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vm/mlock2-tests
gcc -Wall -I ../../../../usr/include     on-fault-limit.c -lrt -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vm/on-fault-limit
gcc -Wall -I ../../../../usr/include     thuge-gen.c -lrt -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vm/thuge-gen
gcc -Wall -I ../../../../usr/include     transhuge-stress.c -lrt -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vm/transhuge-stress
gcc -Wall -I ../../../../usr/include     userfaultfd.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vm/userfaultfd
gcc -Wall -I ../../../../usr/include     va_128TBswitch.c -lrt -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vm/va_128TBswitch
gcc -Wall -I ../../../../usr/include     virtual_address_range.c -lrt -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vm/virtual_address_range
TAP version 13
selftests: vm: run_vmtests
========================================
---------------------
running hugepage-mmap
---------------------
Returned address is 0x7ff0b7a00000
First hex is 0
First hex is 3020100
[PASS]
--------------------
running hugepage-shm
--------------------
shmid: 0x0
shmaddr: 0x7f5d81800000
Starting the writes:
................................................................................................................................................................................................................................................................
Starting the Check...Done.
[PASS]
-------------------
running map_hugetlb
-------------------
Returned address is 0x7ff874000000
First hex is 0
First hex is 3020100
[PASS]
NOTE: The above hugetlb tests provide minimal coverage.  Use
      https://github.com/libhugetlbfs/libhugetlbfs.git for
      hugetlb regression testing.
-------------------
running userfaultfd
-------------------
nr_pages: 32768, nr_pages_per_cpu: 16384
bounces: 31, mode: rnd racing ver poll, userfaults: 2703 2888
bounces: 30, mode: racing ver poll, userfaults: 5001 2425
bounces: 29, mode: rnd ver poll, userfaults: 4419 4637
bounces: 28, mode: ver poll, userfaults: 15930 6292
bounces: 27, mode: rnd racing poll, userfaults: 4262 2689
bounces: 26, mode: racing poll, userfaults: 8537 3080
bounces: 25, mode: rnd poll, userfaults: 6019 4104
bounces: 24, mode: poll, userfaults: 8587 5465
bounces: 23, mode: rnd racing ver, userfaults: 1721 7204
bounces: 22, mode: racing ver, userfaults: 2549 2129
bounces: 21, mode: rnd ver, userfaults: 4066 3737
bounces: 20, mode: ver, userfaults: 6170 5100
bounces: 19, mode: rnd racing, userfaults: 4268 4094
bounces: 18, mode: racing, userfaults: 2870 2494
bounces: 17, mode: rnd, userfaults: 6824 6297
bounces: 16, mode:, userfaults: 6829 6360
bounces: 15, mode: rnd racing ver poll, userfaults: 3115 2918
bounces: 14, mode: racing ver poll, userfaults: 6667 1434
bounces: 13, mode: rnd ver poll, userfaults: 4019 5395
bounces: 12, mode: ver poll, userfaults: 2491 4733
bounces: 11, mode: rnd racing poll, userfaults: 3615 3008
bounces: 10, mode: racing poll, userfaults: 2960 4775
bounces: 9, mode: rnd poll, userfaults: 4541 4587
bounces: 8, mode: poll, userfaults: 6640 6258
bounces: 7, mode: rnd racing ver, userfaults: 4449 3356
bounces: 6, mode: racing ver, userfaults: 5784 5127
bounces: 5, mode: rnd ver, userfaults: 6475 5466
bounces: 4, mode: ver, userfaults: 7559 7026
bounces: 3, mode: rnd racing, userfaults: 1727 5211
bounces: 2, mode: racing, userfaults: 4792 4723
bounces: 1, mode: rnd, userfaults: 5464 5139
bounces: 0, mode:, userfaults: 8359 8239
testing UFFDIO_ZEROPAGE: done.
testing signal delivery: done.
testing events (fork, remap, remove): userfaults: 32768
[PASS]
---------------------------
running userfaultfd_hugetlb
---------------------------
nr_pages: 64, nr_pages_per_cpu: 32
bounces: 31, mode: rnd racing ver poll, userfaults: 11 14
bounces: 30, mode: racing ver poll, userfaults: 12 13
bounces: 29, mode: rnd ver poll, userfaults: 16 7
bounces: 28, mode: ver poll, userfaults: 5 2
bounces: 27, mode: rnd racing poll, userfaults: 17 10
bounces: 26, mode: racing poll, userfaults: 10 17
bounces: 25, mode: rnd poll, userfaults: 18 13
bounces: 24, mode: poll, userfaults: 16 4
bounces: 23, mode: rnd racing ver, userfaults: 30 5
bounces: 22, mode: racing ver, userfaults: 25 15
bounces: 21, mode: rnd ver, userfaults: 19 19
bounces: 20, mode: ver, userfaults: 18 11
bounces: 19, mode: rnd racing, userfaults: 24 6
bounces: 18, mode: racing, userfaults: 15 9
bounces: 17, mode: rnd, userfaults: 21 10
bounces: 16, mode:, userfaults: 14 13
bounces: 15, mode: rnd racing ver poll, userfaults: 23 8
bounces: 14, mode: racing ver poll, userfaults: 17 7
bounces: 13, mode: rnd ver poll, userfaults: 19 12
bounces: 12, mode: ver poll, userfaults: 18 12
bounces: 11, mode: rnd racing poll, userfaults: 17 10
bounces: 10, mode: racing poll, userfaults: 16 3
bounces: 9, mode: rnd poll, userfaults: 14 7
bounces: 8, mode: poll, userfaults: 19 13
bounces: 7, mode: rnd racing ver, userfaults: 19 11
bounces: 6, mode: racing ver, userfaults: 21 5
bounces: 5, mode: rnd ver, userfaults: 18 18
bounces: 4, mode: ver, userfaults: 19 11
bounces: 3, mode: rnd racing, userfaults: 17 11
bounces: 2, mode: racing, userfaults: 13 10
bounces: 1, mode: rnd, userfaults: 22 15
bounces: 0, mode:, userfaults: 17 12
testing UFFDIO_ZEROPAGE: done.
testing signal delivery: done.
testing events (fork, remap, remove): userfaults: 64
[PASS]
-------------------------
running userfaultfd_shmem
-------------------------
nr_pages: 32768, nr_pages_per_cpu: 16384
bounces: 31, mode: rnd racing ver poll, userfaults: 4874 832
bounces: 30, mode: racing ver poll, userfaults: 4198 3987
bounces: 29, mode: rnd ver poll, userfaults: 4214 4832
bounces: 28, mode: ver poll, userfaults: 6352 6804
bounces: 27, mode: rnd racing poll, userfaults: 3565 2613
bounces: 26, mode: racing poll, userfaults: 5095 2547
bounces: 25, mode: rnd poll, userfaults: 4706 5501
bounces: 24, mode: poll, userfaults: 5077 5306
bounces: 23, mode: rnd racing ver, userfaults: 3660 3855
bounces: 22, mode: racing ver, userfaults: 3990 1906
bounces: 21, mode: rnd ver, userfaults: 6546 6123
bounces: 20, mode: ver, userfaults: 4790 4657
bounces: 19, mode: rnd racing, userfaults: 4831 4642
bounces: 18, mode: racing, userfaults: 3696 2936
bounces: 17, mode: rnd, userfaults: 6943 5752
bounces: 16, mode:, userfaults: 6531 6499
bounces: 15, mode: rnd racing ver poll, userfaults: 4303 3680
bounces: 14, mode: racing ver poll, userfaults: 3082 4979
bounces: 13, mode: rnd ver poll, userfaults: 5504 9595
bounces: 12, mode: ver poll, userfaults: 6365 6848
bounces: 11, mode: rnd racing poll, userfaults: 4572 4120
bounces: 10, mode: racing poll, userfaults: 3318 5788
bounces: 9, mode: rnd poll, userfaults: 4396 4692
bounces: 8, mode: poll, userfaults: 6163 6676
bounces: 7, mode: rnd racing ver, userfaults: 3148 3606
bounces: 6, mode: racing ver, userfaults: 3530 3421
bounces: 5, mode: rnd ver, userfaults: 5903 5757
bounces: 4, mode: ver, userfaults: 4970 4901
bounces: 3, mode: rnd racing, userfaults: 3964 3317
bounces: 2, mode: racing, userfaults: 4445 4453
bounces: 1, mode: rnd, userfaults: 5309 6216
bounces: 0, mode:, userfaults: 5058 4684
testing UFFDIO_ZEROPAGE: done.
testing signal delivery: done.
testing events (fork, remap, remove): userfaults: 32768
[PASS]
-----------------------
running compaction_test
-----------------------
[ignored_by_lkp]
[PASS]
----------------------
running on-fault-limit
----------------------
[PASS]
--------------------
running map_populate
--------------------
[PASS]
--------------------
running mlock2-tests
--------------------
Failed to make faulted page unevictable
Failed to make faulted page unevictable
Failed to make present page unevictable
[FAIL]
-----------------------------
running virtual_address_range
-----------------------------
[PASS]
-----------------------------
running virtual address 128TB switch test
-----------------------------
[ignored_by_lkp]
[PASS]
not ok 1..1 selftests: vm: run_vmtests [FAIL]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vm'
watchdog test: not in Makefile
2019-02-27 15:25:16 make TARGETS=watchdog
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/watchdog'
gcc     watchdog-test.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/watchdog/watchdog-test
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/watchdog'
ignored_by_lkp watchdog test
ignored_by_lkp x86.mov_ss_trap test

2019-02-27 15:25:16 make run_tests -C x86
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86'
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/single_step_syscall_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 single_step_syscall.c -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/sysret_ss_attrs_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 sysret_ss_attrs.c -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/syscall_nt_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 syscall_nt.c -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/test_mremap_vdso_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 test_mremap_vdso.c -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/check_initial_reg_state_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -Wl,-ereal_start -static -DCAN_BUILD_32 -DCAN_BUILD_64 check_initial_reg_state.c -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/sigreturn_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 sigreturn.c -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/iopl_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 iopl.c -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/mpx-mini-test_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 mpx-mini-test.c -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/ioperm_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 ioperm.c -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/protection_keys_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 protection_keys.c -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/test_vdso_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 test_vdso.c -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/test_vsyscall_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 test_vsyscall.c -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/entry_from_vm86_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 entry_from_vm86.c -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/syscall_arg_fault_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 syscall_arg_fault.c -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/test_syscall_vdso_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 test_syscall_vdso.c thunks_32.S -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/unwind_vdso_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 unwind_vdso.c -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/test_FCMOV_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 test_FCMOV.c -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/test_FCOMI_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 test_FCOMI.c -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/test_FISTTP_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 test_FISTTP.c -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/vdso_restorer_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 vdso_restorer.c -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/ldt_gdt_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 ldt_gdt.c -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/ptrace_syscall_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 ptrace_syscall.c raw_syscall_helper_32.S -lrt -ldl -lm
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/single_step_syscall_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 single_step_syscall.c -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/sysret_ss_attrs_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 sysret_ss_attrs.c thunks.S -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/syscall_nt_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 syscall_nt.c -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/test_mremap_vdso_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 test_mremap_vdso.c -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/check_initial_reg_state_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -Wl,-ereal_start -static -DCAN_BUILD_32 -DCAN_BUILD_64 check_initial_reg_state.c -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/sigreturn_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 sigreturn.c -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/iopl_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 iopl.c -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/mpx-mini-test_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 mpx-mini-test.c -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/ioperm_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 ioperm.c -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/protection_keys_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 protection_keys.c -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/test_vdso_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 test_vdso.c -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/test_vsyscall_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 test_vsyscall.c -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/fsgsbase_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 fsgsbase.c -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/sysret_rip_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 sysret_rip.c -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/ldt_gdt_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 ldt_gdt.c -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/ptrace_syscall_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 ptrace_syscall.c -lrt -ldl
TAP version 13
selftests: x86: single_step_syscall_32
========================================
[RUN]	Set TF and check nop
[OK]	Survived with TF set and 14 traps
[RUN]	Set TF and check int80
[OK]	Survived with TF set and 14 traps
[RUN]	Set TF and check a fast syscall
[OK]	Survived with TF set and 43 traps
[RUN]	Fast syscall with TF cleared
[OK]	Nothing unexpected happened
ok 1..1 selftests: x86: single_step_syscall_32 [PASS]
selftests: x86: sysret_ss_attrs_32
========================================
[RUN]	Syscalls followed by SS validation
[OK]	We survived
ok 1..2 selftests: x86: sysret_ss_attrs_32 [PASS]
selftests: x86: syscall_nt_32
========================================
[RUN]	Set NT and issue a syscall
[OK]	The syscall worked and flags are still set
[RUN]	Set NT|TF and issue a syscall
[OK]	The syscall worked and flags are still set
ok 1..3 selftests: x86: syscall_nt_32 [PASS]
selftests: x86: test_mremap_vdso_32
========================================
	AT_SYSINFO_EHDR is 0xf7ee7000
[NOTE]	Moving vDSO: [0xf7ee7000, 0xf7ee8000] -> [0xf7f0f000, 0xf7f10000]
[OK]
ok 1..4 selftests: x86: test_mremap_vdso_32 [PASS]
selftests: x86: check_initial_reg_state_32
========================================
[OK]	All GPRs except SP are 0
[OK]	FLAGS is 0x202
ok 1..5 selftests: x86: check_initial_reg_state_32 [PASS]
selftests: x86: sigreturn_32
========================================
[OK]	set_thread_area refused 16-bit data
[OK]	set_thread_area refused 16-bit data
[RUN]	Valid sigreturn: 64-bit CS (33), 32-bit SS (2b, GDT)
[OK]	all registers okay
[RUN]	Valid sigreturn: 32-bit CS (23), 32-bit SS (2b, GDT)
[OK]	all registers okay
[RUN]	Valid sigreturn: 16-bit CS (37), 32-bit SS (2b, GDT)
[OK]	all registers okay
[RUN]	Valid sigreturn: 64-bit CS (33), 16-bit SS (3f)
[OK]	all registers okay
[RUN]	Valid sigreturn: 32-bit CS (23), 16-bit SS (3f)
[OK]	all registers okay
[RUN]	Valid sigreturn: 16-bit CS (37), 16-bit SS (3f)
[OK]	all registers okay
[RUN]	64-bit CS (33), bogus SS (47)
[OK]	Got #GP(0x0) (i.e. Segmentation fault)
[RUN]	32-bit CS (23), bogus SS (47)
[OK]	Got #GP(0x0) (i.e. Segmentation fault)
[RUN]	16-bit CS (37), bogus SS (47)
[OK]	Got #GP(0x0) (i.e. Segmentation fault)
[RUN]	64-bit CS (33), bogus SS (23)
[OK]	Got #GP(0x20) (i.e. GDT index 4, Segmentation fault)
[RUN]	32-bit CS (23), bogus SS (23)
[OK]	Got #GP(0x20) (i.e. GDT index 4, Segmentation fault)
[RUN]	16-bit CS (37), bogus SS (23)
[OK]	Got #GP(0x20) (i.e. GDT index 4, Segmentation fault)
[RUN]	32-bit CS (4f), bogus SS (2b)
[OK]	Got #NP(0x4c) (i.e. LDT index 9, Bus error)
[RUN]	32-bit CS (23), bogus SS (57)
[OK]	Got #GP(0x0) (i.e. Segmentation fault)
ok 1..6 selftests: x86: sigreturn_32 [PASS]
selftests: x86: iopl_32
========================================
	child: set IOPL to 3
[RUN]	child: write to 0x80
[OK]	Child succeeded
[RUN]	parent: write to 0x80 (should fail)
[OK]	write was denied
	iopl(3)
	Drop privileges
[RUN]	iopl(3) unprivileged but with IOPL==3
[RUN]	iopl(0) unprivileged
[RUN]	iopl(3) unprivileged
[OK]	Failed as expected
ok 1..7 selftests: x86: iopl_32 [PASS]
selftests: x86: mpx-mini-test_32
========================================
processor lacks MPX XSTATE(s), can not run MPX tests
XSAVE is supported by HW & OS
XSAVE processor supported state mask: 0x7
XSAVE OS supported state mask: 0x7
ok 1..8 selftests: x86: mpx-mini-test_32 [PASS]
selftests: x86: ioperm_32
========================================
[OK]	outb to 0x80 failed
[OK]	outb to 0xed failed
[RUN]	enable 0x80
[OK]	outb to 0x80 worked
[OK]	outb to 0xed failed
[RUN]	disable 0x80
[OK]	outb to 0x80 failed
[OK]	outb to 0xed failed
[RUN]	child: check that we inherited permissions
[OK]	outb to 0x80 worked
[OK]	outb to 0xed failed
[OK]	outb to 0x80 failed
[OK]	outb to 0xed failed
[RUN]	enable 0x80
[OK]	outb to 0x80 worked
[OK]	outb to 0xed failed
[RUN]	disable 0x80
[OK]	outb to 0x80 failed
[OK]	outb to 0xed failed
[OK]	Child succeeded
	Drop privileges
[RUN]	disable 0x80
[OK]	it worked
[RUN]	enable 0x80 again
[OK]	it failed
ok 1..9 selftests: x86: ioperm_32 [PASS]
selftests: x86: protection_keys_32
========================================
has pku: 0
running PKEY tests for unsupported CPU/OS
ok 1..10 selftests: x86: protection_keys_32 [PASS]
selftests: x86: test_vdso_32
========================================
Warning: failed to find getcpu in vDSO
[RUN]	Testing clock_gettime for clock CLOCK_REALTIME (0)...
	1551252325.597246296 1551252325.597252343 1551252325.597252973
[RUN]	Testing clock_gettime for clock CLOCK_MONOTONIC (1)...
	632.985155857 632.985156269 632.985156737
[RUN]	Testing clock_gettime for clock CLOCK_PROCESS_CPUTIME_ID (2)...
	0.001371749 0.001372886 0.001373730
[RUN]	Testing clock_gettime for clock CLOCK_THREAD_CPUTIME_ID (3)...
	0.001376964 0.001377806 0.001378641
[RUN]	Testing clock_gettime for clock CLOCK_MONOTONIC_RAW (4)...
	632.577313626 632.577314342 632.577315071
[RUN]	Testing clock_gettime for clock CLOCK_REALTIME_COARSE (5)...
	1551252325.596853650 1551252325.596853650 1551252325.596853650
[RUN]	Testing clock_gettime for clock CLOCK_MONOTONIC_COARSE (6)...
	632.984752162 632.984752162 632.984752162
[RUN]	Testing clock_gettime for clock CLOCK_BOOTTIME (7)...
	632.985178930 632.985179662 632.985180406
[RUN]	Testing clock_gettime for clock CLOCK_REALTIME_ALARM (8)...
	1551252325.597284486 1551252325.597285249 1551252325.597286030
[RUN]	Testing clock_gettime for clock CLOCK_BOOTTIME_ALARM (9)...
	632.985187015 632.985187786 632.985188568
[RUN]	Testing clock_gettime for clock CLOCK_SGI_CYCLE (10)...
[OK]	No such clock.
[RUN]	Testing clock_gettime for clock CLOCK_TAI (11)...
	1551252325.597295127 1551252325.597295489 1551252325.597295966
[RUN]	Testing clock_gettime for clock invalid (-1)...
[OK]	No such clock.
[RUN]	Testing clock_gettime for clock invalid (-2147483648)...
[OK]	No such clock.
[RUN]	Testing clock_gettime for clock invalid (2147483647)...
[OK]	No such clock.
[RUN]	Testing gettimeofday...
	1551252325.597304 1551252325.597304 1551252325.597305
[OK]	timezones match: minuteswest=-480, dsttime=0
[RUN]	Testing getcpu...
[OK]	CPU 0: syscall: cpu 0, node 0
[OK]	CPU 1: syscall: cpu 1, node 0
ok 1..11 selftests: x86: test_vdso_32 [PASS]
selftests: x86: test_vsyscall_32
========================================
[NOTE]	failed to find getcpu in vDSO
[RUN]	test gettimeofday()
	vDSO time offsets: 0.000005 0.000000
[OK]	vDSO gettimeofday()'s timeval was okay
[RUN]	test time()
[OK]	vDSO time() is okay
[RUN]	getcpu() on CPU 0
[RUN]	getcpu() on CPU 1
ok 1..12 selftests: x86: test_vsyscall_32 [PASS]
selftests: x86: entry_from_vm86_32
========================================
[RUN]	#BR from vm86 mode
[SKIP]	vm86 not supported
[RUN]	SYSENTER from vm86 mode
[SKIP]	vm86 not supported
[RUN]	SYSCALL from vm86 mode
[SKIP]	vm86 not supported
[RUN]	STI with VIP set from vm86 mode
[SKIP]	vm86 not supported
[RUN]	POPF with VIP set and IF clear from vm86 mode
[SKIP]	vm86 not supported
[RUN]	POPF with VIP and IF set from vm86 mode
[SKIP]	vm86 not supported
[RUN]	POPF with VIP clear and IF set from vm86 mode
[SKIP]	vm86 not supported
[RUN]	INT3 from vm86 mode
[SKIP]	vm86 not supported
[RUN]	int80 from vm86 mode
[SKIP]	vm86 not supported
[RUN]	UMIP tests from vm86 mode
[SKIP]	vm86 not supported
[INFO]	Result from SMSW:[0x0000]
[INFO]	Result from SIDT: limit[0x0000]base[0x00000000]
[INFO]	Result from SGDT: limit[0x0000]base[0x00000000]
[PASS]	All the results from SMSW are identical.
[PASS]	All the results from SGDT are identical.
[PASS]	All the results from SIDT are identical.
[RUN]	STR instruction from vm86 mode
[SKIP]	vm86 not supported
[RUN]	SLDT instruction from vm86 mode
[SKIP]	vm86 not supported
[RUN]	Execute null pointer from vm86 mode
[SKIP]	vm86 not supported
ok 1..13 selftests: x86: entry_from_vm86_32 [PASS]
[RUN]	#BR from vm86 mode
[SKIP]	vm86 not supported
[RUN]	SYSENTER from vm86 mode
[SKIP]	vm86 not supported
[RUN]	SYSCALL from vm86 mode
[SKIP]	vm86 not supported
[RUN]	STI with VIP set from vm86 mode
[SKIP]	vm86 not supported
[RUN]	POPF with VIP set and IF clear from vm86 mode
[SKIP]	vm86 not supported
[RUN]	POPF with VIP and IF set from vm86 mode
[SKIP]	vm86 not supported
[RUN]	POPF with VIP clear and IF set from vm86 mode
[SKIP]	vm86 not supported
[RUN]	INT3 from vm86 mode
[SKIP]	vm86 not supported
[RUN]	int80 from vm86 mode
[SKIP]	vm86 not supported
[RUN]	UMIP tests from vm86 mode
[SKIP]	vm86 not supported
[INFO]	Result from SMSW:[0x0000]
[INFO]	Result from SIDT: limit[0x0000]base[0x00000000]
[INFO]	Result from SGDT: limit[0x0000]base[0x00000000]
[PASS]	All the results from SMSW are identical.
[PASS]	All the results from SGDT are identical.
[PASS]	All the results from SIDT are identical.
[RUN]	STR instruction from vm86 mode
[SKIP]	vm86 not supported
[RUN]	SLDT instruction from vm86 mode
[SKIP]	vm86 not supported
[RUN]	Execute null pointer from vm86 mode
[SKIP]	vm86 not supported
selftests: x86: syscall_arg_fault_32
========================================
[RUN]	SYSENTER with invalid state
[OK]	Seems okay
[RUN]	SYSCALL with invalid state
[SKIP]	Illegal instruction
ok 1..14 selftests: x86: syscall_arg_fault_32 [PASS]
selftests: x86: test_syscall_vdso_32
========================================
[RUN]	Executing 6-argument 32-bit syscall via VDSO
[WARN]	Flags before=0000000000200ed7 id 0 00 o d i s z 0 a 0 p 1 c
[WARN]	Flags  after=0000000000200606 id 0 00 d i 0 0 p 1 
[WARN]	Flags change=00000000000008d1 0 00 o s z 0 a 0 0 c
[OK]	Arguments are preserved across syscall
[NOTE]	R11 has changed:0000000000200606 - assuming clobbered by SYSRET insn
[OK]	R8..R15 did not leak kernel data
[RUN]	Executing 6-argument 32-bit syscall via INT 80
[OK]	Arguments are preserved across syscall
[OK]	R8..R15 did not leak kernel data
[RUN]	Executing 6-argument 32-bit syscall via VDSO
[WARN]	Flags before=0000000000200ed7 id 0 00 o d i s z 0 a 0 p 1 c
[WARN]	Flags  after=0000000000200606 id 0 00 d i 0 0 p 1 
[WARN]	Flags change=00000000000008d1 0 00 o s z 0 a 0 0 c
[OK]	Arguments are preserved across syscall
[NOTE]	R11 has changed:0000000000200606 - assuming clobbered by SYSRET insn
[OK]	R8..R15 did not leak kernel data
[RUN]	Executing 6-argument 32-bit syscall via INT 80
[OK]	Arguments are preserved across syscall
[OK]	R8..R15 did not leak kernel data
[RUN]	Running tests under ptrace
ok 1..15 selftests: x86: test_syscall_vdso_32 [PASS]
selftests: x86: unwind_vdso_32
========================================
	AT_SYSINFO is 0xf7fbd940
[OK]	AT_SYSINFO maps to linux-gate.so.1, loaded at 0x0xf7fbd000
[RUN]	Set TF and check a fast syscall
	In vsyscall at 0xf7fbd940, returning to 0xf7da9877
	SIGTRAP at 0xf7fbd940
	  0xf7fbd940
	  0xf7da9877
[OK]	  NR = 20, args = 1, 2, 3, 4, 5, 6
	SIGTRAP at 0xf7fbd941
	  0xf7fbd941
	  0xf7da9877
[OK]	  NR = 20, args = 1, 2, 3, 4, 5, 6
	SIGTRAP at 0xf7fbd942
	  0xf7fbd942
	  0xf7da9877
[OK]	  NR = 20, args = 1, 2, 3, 4, 5, 6
	SIGTRAP at 0xf7fbd943
	  0xf7fbd943
	  0xf7da9877
[OK]	  NR = 20, args = 1, 2, 3, 4, 5, 6
	SIGTRAP at 0xf7fbd945
	  0xf7fbd945
	  0xf7da9877
[OK]	  NR = 20, args = 1, 2, 3, 4, 5, 6
	SIGTRAP at 0xf7fbd94a
	  0xf7fbd94a
	  0xf7da9877
[OK]	  NR = 10002, args = 1, 2, 3, 4, 5, 6
	SIGTRAP at 0xf7fbd94b
	  0xf7fbd94b
	  0xf7da9877
[OK]	  NR = 10002, args = 1, 2, 3, 4, 5, 6
	SIGTRAP at 0xf7fbd94c
	  0xf7fbd94c
	  0xf7da9877
[OK]	  NR = 10002, args = 1, 2, 3, 4, 5, 6
	Vsyscall is done
[OK]	All is well
ok 1..16 selftests: x86: unwind_vdso_32 [PASS]
selftests: x86: test_FCMOV_32
========================================
[RUN]	Testing fcmovCC instructions
[OK]	fcmovCC
ok 1..17 selftests: x86: test_FCMOV_32 [PASS]
selftests: x86: test_FCOMI_32
========================================
[RUN]	Testing f[u]comi[p] instructions
[OK]	f[u]comi[p]
ok 1..18 selftests: x86: test_FCOMI_32 [PASS]
selftests: x86: test_FISTTP_32
========================================
[RUN]	Testing fisttp instructions
[OK]	fisttp
ok 1..19 selftests: x86: test_FISTTP_32 [PASS]
selftests: x86: vdso_restorer_32
========================================
[OK]	SA_SIGINFO handler returned successfully
[OK]	!SA_SIGINFO handler returned successfully
ok 1..20 selftests: x86: vdso_restorer_32 [PASS]
selftests: x86: ldt_gdt_32
========================================
[NOTE]	set_thread_area is available; will use GDT index 13
[OK]	LDT entry 0 has AR 0x0040FB00 and limit 0x0000000A
[OK]	LDT entry 0 has AR 0x00C0FB00 and limit 0x0000AFFF
[OK]	LDT entry 1 is invalid
[OK]	LDT entry 2 has AR 0x00C0FB00 and limit 0x0000AFFF
[OK]	LDT entry 1 is invalid
[OK]	LDT entry 2 has AR 0x00C0FB00 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D0FB00 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D07B00 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00907B00 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D07300 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D07100 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D07500 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00507700 and limit 0x0000000A
[OK]	LDT entry 2 has AR 0x00507F00 and limit 0x0000000A
[OK]	LDT entry 2 has AR 0x00507D00 and limit 0x0000000A
[OK]	LDT entry 2 has AR 0x00507B00 and limit 0x0000000A
[OK]	LDT entry 2 has AR 0x00507900 and limit 0x0000000A
[RUN]	Test fork
[OK]	LDT entry 2 has AR 0x00507900 and limit 0x0000000A
[OK]	LDT entry 1 is invalid
[OK]	LDT entry 0 is invalid
[NOTE]	set_thread_area is available; will use GDT index 13
[OK]	LDT entry 0 has AR 0x0040FB00 and limit 0x0000000A
[OK]	LDT entry 0 has AR 0x00C0FB00 and limit 0x0000AFFF
[OK]	LDT entry 1 is invalid
[OK]	LDT entry 2 has AR 0x00C0FB00 and limit 0x0000AFFF
[OK]	LDT entry 1 is invalid
[OK]	LDT entry 2 has AR 0x00C0FB00 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D0FB00 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D07B00 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00907B00 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D07300 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D07100 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D07500 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00507700 and limit 0x0000000A
[OK]	LDT entry 2 has AR 0x00507F00 and limit 0x0000000A
[OK]	LDT entry 2 has AR 0x00507D00 and limit 0x0000000A
[OK]	LDT entry 2 has AR 0x00507B00 and limit 0x0000000A
[OK]	LDT entry 2 has AR 0x00507900 and limit 0x0000000A
[RUN]	Test fork
[OK]	Child succeeded
[RUN]	Test size
[DONE]	Size test
[OK]	modify_ldt failure 22
[OK]	LDT entry 0 has AR 0x0000F300 and limit 0x00000000
[OK]	LDT entry 0 has AR 0x00007300 and limit 0x00000000
[OK]	LDT entry 0 has AR 0x0000F100 and limit 0x00000000
[OK]	LDT entry 0 has AR 0x00007300 and limit 0x00000000
[OK]	LDT entry 0 has AR 0x00007100 and limit 0x00000001
[OK]	LDT entry 0 has AR 0x00007100 and limit 0x00000000
[OK]	LDT entry 0 is invalid
[OK]	LDT entry 0 has AR 0x0040F300 and limit 0x000FFFFF
[OK]	GDT entry 13 has AR 0x0040F300 and limit 0x000FFFFF
[OK]	LDT entry 0 has AR 0x00C0F300 and limit 0xFFFFFFFF
[OK]	GDT entry 13 has AR 0x00C0F300 and limit 0xFFFFFFFF
[OK]	LDT entry 0 has AR 0x00C0F100 and limit 0xFFFFFFFF
[OK]	GDT entry 13 has AR 0x00C0F100 and limit 0xFFFFFFFF
[OK]	LDT entry 0 has AR 0x00C0F700 and limit 0xFFFFFFFF
[OK]	GDT entry 13 has AR 0x00C0F700 and limit 0xFFFFFFFF
[OK]	LDT entry 0 has AR 0x00C0F500 and limit 0xFFFFFFFF
[OK]	GDT entry 13 has AR 0x00C0F500 and limit 0xFFFFFFFF
[OK]	LDT entry 0 is invalid
[RUN]	Cross-CPU LDT invalidation
[OK]	All 5 iterations succeeded
[RUN]	Test exec
[OK]	LDT entry 0 has AR 0x0040FB00 and limit 0x0000002A
[OK]	Child succeeded
[OK]	Invalidate DS with set_thread_area: new DS = 0x0
[OK]	Invalidate ES with set_thread_area: new ES = 0x0
[OK]	Invalidate FS with set_thread_area: new FS = 0x0
[OK]	Invalidate GS with set_thread_area: new GS = 0x0
ok 1..21 selftests: x86: ldt_gdt_32 [PASS]
selftests: x86: ptrace_syscall_32
========================================
[RUN]	Check int80 return regs
[OK]	getpid() preserves regs
[OK]	kill(getpid(), SIGUSR1) preserves regs
[RUN]	Check AT_SYSINFO return regs
[OK]	getpid() preserves regs
[OK]	kill(getpid(), SIGUSR1) preserves regs
[RUN]	ptrace-induced syscall restart
[RUN]	SYSEMU
[OK]	Initial nr and args are correct
[RUN]	Restart the syscall (ip = 0xf7f0b949)
[OK]	Restarted nr and args are correct
[RUN]	Change nr and args and restart the syscall (ip = 0xf7f0b949)
[OK]	Replacement nr and args are correct
[OK]	Child exited cleanly
[RUN]	kernel syscall restart under ptrace
[RUN]	SYSCALL
[OK]	Initial nr and args are correct
[RUN]	SYSCALL
[OK]	Args after SIGUSR1 are correct (ax = -514)
[OK]	Child got SIGUSR1
[RUN]	Step again
[OK]	pause(2) restarted correctly
ok 1..22 selftests: x86: ptrace_syscall_32 [PASS]
selftests: x86: single_step_syscall_64
========================================
[RUN]	Set TF and check nop
[OK]	Survived with TF set and 9 traps
[RUN]	Set TF and check syscall-less opportunistic sysret
[OK]	Survived with TF set and 12 traps
[RUN]	Set TF and check int80
[OK]	Survived with TF set and 9 traps
[RUN]	Set TF and check a fast syscall
[OK]	Survived with TF set and 22 traps
[RUN]	Fast syscall with TF cleared
[OK]	Nothing unexpected happened
ok 1..23 selftests: x86: single_step_syscall_64 [PASS]
selftests: x86: sysret_ss_attrs_64
========================================
[RUN]	Syscalls followed by SS validation
[OK]	We survived
ok 1..24 selftests: x86: sysret_ss_attrs_64 [PASS]
selftests: x86: syscall_nt_64
========================================
[RUN]	Set NT and issue a syscall
[OK]	The syscall worked and flags are still set
[RUN]	Set NT|TF and issue a syscall
[OK]	The syscall worked and flags are still set
ok 1..25 selftests: x86: syscall_nt_64 [PASS]
selftests: x86: test_mremap_vdso_64
========================================
	AT_SYSINFO_EHDR is 0x7ffe44b92000
[NOTE]	Moving vDSO: [0x7ffe44b92000, 0x7ffe44b93000] -> [0x7fb552928000, 0x7fb552929000]
[OK]
ok 1..26 selftests: x86: test_mremap_vdso_64 [PASS]
selftests: x86: check_initial_reg_state_64
========================================
[OK]	All GPRs except SP are 0
[OK]	FLAGS is 0x202
ok 1..27 selftests: x86: check_initial_reg_state_64 [PASS]
selftests: x86: sigreturn_64
========================================
[OK]	set_thread_area refused 16-bit data
[OK]	set_thread_area refused 16-bit data
[RUN]	Valid sigreturn: 64-bit CS (33), 32-bit SS (2b, GDT)
[OK]	all registers okay
[RUN]	Valid sigreturn: 32-bit CS (23), 32-bit SS (2b, GDT)
[NOTE]	SP: 8badf00d5aadc0de -> 5aadc0de
[OK]	all registers okay
[RUN]	Valid sigreturn: 16-bit CS (37), 32-bit SS (2b, GDT)
[NOTE]	SP: 8badf00d5aadc0de -> 5aadc0de
[OK]	all registers okay
[RUN]	Valid sigreturn: 64-bit CS (33), 16-bit SS (3f)
[OK]	all registers okay
[RUN]	Valid sigreturn: 32-bit CS (23), 16-bit SS (3f)
[NOTE]	SP: 8badf00d5aadc0de -> 5aadc0de
[OK]	all registers okay
[RUN]	Valid sigreturn: 16-bit CS (37), 16-bit SS (3f)
[NOTE]	SP: 8badf00d5aadc0de -> 5aadc0de
[OK]	all registers okay
[RUN]	Valid sigreturn: 32-bit CS (23), 32-bit SS (2b, GDT)
	Corrupting SS on return to 64-bit mode
[NOTE]	SP: 8badf00d5aadc0de -> 5aadc0de
[OK]	all registers okay
[RUN]	Valid sigreturn: 32-bit CS (23), 16-bit SS (3f)
	Corrupting SS on return to 64-bit mode
[NOTE]	SP: 8badf00d5aadc0de -> 5aadc0de
[OK]	all registers okay
[RUN]	64-bit CS (33), bogus SS (47)
[OK]	Got #GP(0x0) (i.e. Segmentation fault)
[RUN]	32-bit CS (23), bogus SS (47)
[OK]	Got #GP(0x0) (i.e. Segmentation fault)
[RUN]	16-bit CS (37), bogus SS (47)
[OK]	Got #GP(0x0) (i.e. Segmentation fault)
[RUN]	64-bit CS (33), bogus SS (33)
[OK]	Got #GP(0x30) (i.e. GDT index 6, Segmentation fault)
[RUN]	32-bit CS (23), bogus SS (33)
[OK]	Got #GP(0x30) (i.e. GDT index 6, Segmentation fault)
[RUN]	16-bit CS (37), bogus SS (33)
[OK]	Got #GP(0x30) (i.e. GDT index 6, Segmentation fault)
[RUN]	32-bit CS (4f), bogus SS (2b)
[OK]	Got #NP(0x4c) (i.e. LDT index 9, Bus error)
[RUN]	32-bit CS (23), bogus SS (57)
[OK]	Got #GP(0x0) (i.e. Segmentation fault)
[RUN]	Clear UC_STRICT_RESTORE_SS and corrupt SS
[OK]	It worked
ok 1..28 selftests: x86: sigreturn_64 [PASS]
selftests: x86: iopl_64
========================================
	child: set IOPL to 3
[RUN]	child: write to 0x80
[OK]	Child succeeded
[RUN]	parent: write to 0x80 (should fail)
[OK]	write was denied
	iopl(3)
	Drop privileges
[RUN]	iopl(3) unprivileged but with IOPL==3
[RUN]	iopl(0) unprivileged
[RUN]	iopl(3) unprivileged
[OK]	Failed as expected
ok 1..29 selftests: x86: iopl_64 [PASS]
selftests: x86: mpx-mini-test_64
========================================
processor lacks MPX XSTATE(s), can not run MPX tests
XSAVE is supported by HW & OS
XSAVE processor supported state mask: 0x7
XSAVE OS supported state mask: 0x7
ok 1..30 selftests: x86: mpx-mini-test_64 [PASS]
selftests: x86: ioperm_64
========================================
[OK]	outb to 0x80 failed
[OK]	outb to 0xed failed
[RUN]	enable 0x80
[OK]	outb to 0x80 worked
[OK]	outb to 0xed failed
[RUN]	disable 0x80
[OK]	outb to 0x80 failed
[OK]	outb to 0xed failed
[RUN]	child: check that we inherited permissions
[OK]	outb to 0x80 worked
[OK]	outb to 0xed failed
[OK]	outb to 0x80 failed
[OK]	outb to 0xed failed
[RUN]	enable 0x80
[OK]	outb to 0x80 worked
[OK]	outb to 0xed failed
[RUN]	disable 0x80
[OK]	outb to 0x80 failed
[OK]	outb to 0xed failed
[OK]	Child succeeded
	Drop privileges
[RUN]	disable 0x80
[OK]	it worked
[RUN]	enable 0x80 again
[OK]	it failed
ok 1..31 selftests: x86: ioperm_64 [PASS]
selftests: x86: protection_keys_64
========================================
has pku: 0
running PKEY tests for unsupported CPU/OS
ok 1..32 selftests: x86: protection_keys_64 [PASS]
selftests: x86: test_vdso_64
========================================
[RUN]	Testing clock_gettime for clock CLOCK_REALTIME (0)...
	1551252326.064454763 1551252326.064460618 1551252326.064461264
[RUN]	Testing clock_gettime for clock CLOCK_MONOTONIC (1)...
	633.452362833 633.452363285 633.452363750
[RUN]	Testing clock_gettime for clock CLOCK_PROCESS_CPUTIME_ID (2)...
	0.000703738 0.000705015 0.000705910
[RUN]	Testing clock_gettime for clock CLOCK_THREAD_CPUTIME_ID (3)...
	0.000708187 0.000709083 0.000709956
[RUN]	Testing clock_gettime for clock CLOCK_MONOTONIC_RAW (4)...
	633.044519105 633.044519915 633.044520670
[RUN]	Testing clock_gettime for clock CLOCK_REALTIME_COARSE (5)...
	1551252326.061853650 1551252326.061853650 1551252326.061853650
[RUN]	Testing clock_gettime for clock CLOCK_MONOTONIC_COARSE (6)...
	633.449752162 633.449752162 633.449752162
[RUN]	Testing clock_gettime for clock CLOCK_BOOTTIME (7)...
	633.452383428 633.452384219 633.452385002
[RUN]	Testing clock_gettime for clock CLOCK_REALTIME_ALARM (8)...
	1551252326.064488798 1551252326.064489620 1551252326.064490434
[RUN]	Testing clock_gettime for clock CLOCK_BOOTTIME_ALARM (9)...
	633.452390937 633.452391757 633.452392569
[RUN]	Testing clock_gettime for clock CLOCK_SGI_CYCLE (10)...
[OK]	No such clock.
[RUN]	Testing clock_gettime for clock CLOCK_TAI (11)...
	1551252326.064499465 1551252326.064499907 1551252326.064500337
[RUN]	Testing clock_gettime for clock invalid (-1)...
[OK]	No such clock.
[RUN]	Testing clock_gettime for clock invalid (-2147483648)...
[OK]	No such clock.
[RUN]	Testing clock_gettime for clock invalid (2147483647)...
[OK]	No such clock.
[RUN]	Testing gettimeofday...
	1551252326.064508 1551252326.064508 1551252326.064509
[OK]	timezones match: minuteswest=-480, dsttime=0
[RUN]	Testing getcpu...
[OK]	CPU 0: syscall: cpu 0, node 0 vdso: cpu 0, node 0 vsyscall: cpu 0, node 0
[OK]	CPU 1: syscall: cpu 1, node 0 vdso: cpu 1, node 0 vsyscall: cpu 1, node 0
ok 1..33 selftests: x86: test_vdso_64 [PASS]
selftests: x86: test_vsyscall_64
========================================
	vsyscall map: ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0                  [vsyscall]
	vsyscall permissions are r-x
[RUN]	test gettimeofday()
	vDSO time offsets: 0.000005 0.000002
[OK]	vDSO gettimeofday()'s timeval was okay
	vsyscall time offsets: 0.000006 0.000001
[OK]	vsyscall gettimeofday()'s timeval was okay
[RUN]	test time()
[OK]	vDSO time() is okay
[OK]	vsyscall time() is okay
[RUN]	getcpu() on CPU 0
[OK]	vDSO reported correct CPU
[OK]	vDSO reported correct node
[OK]	vsyscall reported correct CPU
[OK]	vsyscall reported correct node
[RUN]	getcpu() on CPU 1
[OK]	vDSO reported correct CPU
[OK]	vDSO reported correct node
[OK]	vsyscall reported correct CPU
[OK]	vsyscall reported correct node
[RUN]	Checking read access to the vsyscall page
[OK]	got expected result
[RUN]	checking that vsyscalls are emulated
[OK]	vsyscalls are emulated (1 instructions in vsyscall page)
ok 1..34 selftests: x86: test_vsyscall_64 [PASS]
selftests: x86: fsgsbase_64
========================================
[RUN]	ARCH_SET_GS to 0x0
[OK]	GSBASE was set as expected (selector 0x0)
[OK]	ARCH_GET_GS worked as expected (selector 0x0)
[RUN]	ARCH_SET_GS to 0x1
[OK]	GSBASE was set as expected (selector 0x0)
[OK]	ARCH_GET_GS worked as expected (selector 0x0)
[RUN]	ARCH_SET_GS to 0x200000000
[OK]	GSBASE was set as expected (selector 0x0)
[OK]	ARCH_GET_GS worked as expected (selector 0x0)
[RUN]	ARCH_SET_GS to 0x0
[OK]	GSBASE was set as expected (selector 0x0)
[OK]	ARCH_GET_GS worked as expected (selector 0x0)
[RUN]	ARCH_SET_GS to 0x200000000
[OK]	GSBASE was set as expected (selector 0x0)
[OK]	ARCH_GET_GS worked as expected (selector 0x0)
[RUN]	ARCH_SET_GS to 0x1
[OK]	GSBASE was set as expected (selector 0x0)
[OK]	ARCH_GET_GS worked as expected (selector 0x0)
[RUN]	ARCH_SET_GS to 0x0 then mov 0 to %gs
[OK]	GSBASE is 0x0
[RUN]	ARCH_SET_GS to 0x1 then mov 0 to %gs
[OK]	GSBASE is 0x0
[RUN]	ARCH_SET_GS to 0x200000000 then mov 0 to %gs
[OK]	GSBASE is 0x0
[RUN]	ARCH_SET_GS to 0x0 then mov 0 to %gs and schedule 
[OK]	GSBASE is 0x0
[RUN]	ARCH_SET_GS to 0x1 then mov 0 to %gs and schedule 
[OK]	GSBASE is 0x0
[RUN]	ARCH_SET_GS to 0x200000000 then mov 0 to %gs and schedule 
[OK]	GSBASE is 0x0
[RUN]	ARCH_SET_GS(0x0), then schedule to 0x0
	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
[OK]	GS/BASE remained 0x0/0x0
[RUN]	ARCH_SET_GS(0x0), then schedule to 0x0
	Before schedule, set selector to 0x1
	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
[OK]	GS/BASE remained 0x1/0x0
[RUN]	ARCH_SET_GS(0x0), then schedule to 0x0
	Before schedule, set selector to 0x2
	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
[OK]	GS/BASE remained 0x2/0x0
[RUN]	ARCH_SET_GS(0x0), then schedule to 0x0
	Before schedule, set selector to 0x3
	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
[OK]	GS/BASE remained 0x3/0x0
[RUN]	ARCH_SET_GS(0x0), then schedule to 0x0
	Before schedule, set selector to 0x2b
	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
[OK]	GS/BASE remained 0x2b/0x0
[RUN]	ARCH_SET_GS(0x0), then schedule to 0xa1fa5f343cb85fa4
	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
[OK]	GS/BASE remained 0x0/0x0
[RUN]	ARCH_SET_GS(0x0), then schedule to 0xa1fa5f343cb85fa4
	Before schedule, set selector to 0x1
	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
[OK]	GS/BASE remained 0x1/0x0
[RUN]	ARCH_SET_GS(0x0), then schedule to 0xa1fa5f343cb85fa4
	Before schedule, set selector to 0x2
	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
[OK]	GS/BASE remained 0x2/0x0
[RUN]	ARCH_SET_GS(0x0), then schedule to 0xa1fa5f343cb85fa4
	Before schedule, set selector to 0x3
	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
[OK]	GS/BASE remained 0x3/0x0
[RUN]	ARCH_SET_GS(0x0), then schedule to 0xa1fa5f343cb85fa4
	Before schedule, set selector to 0x2b
	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
[OK]	GS/BASE remained 0x2b/0x0
[RUN]	ARCH_SET_GS(0x0), then schedule to 0x1
	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
[OK]	GS/BASE remained 0x0/0x0
[RUN]	ARCH_SET_GS(0x0), then schedule to 0x1
	Before schedule, set selector to 0x1
	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
[OK]	GS/BASE remained 0x1/0x0
[RUN]	ARCH_SET_GS(0x0), then schedule to 0x1
	Before schedule, set selector to 0x2
	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
[OK]	GS/BASE remained 0x2/0x0
[RUN]	ARCH_SET_GS(0x0), then schedule to 0x1
	Before schedule, set selector to 0x3
	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
[OK]	GS/BASE remained 0x3/0x0
[RUN]	ARCH_SET_GS(0x0), then schedule to 0x1
	Before schedule, set selector to 0x2b
	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
[OK]	GS/BASE remained 0x2b/0x0
[RUN]	ARCH_SET_GS(0x0), then schedule to 0x200000000
	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
[OK]	GS/BASE remained 0x0/0x0
[RUN]	ARCH_SET_GS(0x0), then schedule to 0x200000000
	Before schedule, set selector to 0x1
	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
[OK]	GS/BASE remained 0x1/0x0
[RUN]	ARCH_SET_GS(0x0), then schedule to 0x200000000
	Before schedule, set selector to 0x2
	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
[OK]	GS/BASE remained 0x2/0x0
[RUN]	ARCH_SET_GS(0x0), then schedule to 0x200000000
	Before schedule, set selector to 0x3
	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
[OK]	GS/BASE remained 0x3/0x0
[RUN]	ARCH_SET_GS(0x0), then schedule to 0x200000000
	Before schedule, set selector to 0x2b
	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
[OK]	GS/BASE remained 0x2b/0x0
[RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x0
	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
[OK]	GS/BASE remained 0x0/0x0
[RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x0
	Before schedule, set selector to 0x1
	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
[OK]	GS/BASE remained 0x1/0x0
[RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x0
	Before schedule, set selector to 0x2
	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
[OK]	GS/BASE remained 0x2/0x0
[RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x0
	Before schedule, set selector to 0x3
	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
[OK]	GS/BASE remained 0x3/0x0
[RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x0
	Before schedule, set selector to 0x2b
	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
[OK]	GS/BASE remained 0x2b/0x0
[RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0xa1fa5f343cb85fa4
	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
[OK]	GS/BASE remained 0x0/0x0
[RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0xa1fa5f343cb85fa4
	Before schedule, set selector to 0x1
	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
[OK]	GS/BASE remained 0x1/0x0
[RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0xa1fa5f343cb85fa4
	Before schedule, set selector to 0x2
	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
[OK]	GS/BASE remained 0x2/0x0
[RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0xa1fa5f343cb85fa4
	Before schedule, set selector to 0x3
	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
[OK]	GS/BASE remained 0x3/0x0
[RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0xa1fa5f343cb85fa4
	Before schedule, set selector to 0x2b
	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
[OK]	GS/BASE remained 0x2b/0x0
[RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x1
	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
[OK]	GS/BASE remained 0x0/0x0
[RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x1
	Before schedule, set selector to 0x1
	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
[OK]	GS/BASE remained 0x1/0x0
[RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x1
	Before schedule, set selector to 0x2
	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
[OK]	GS/BASE remained 0x2/0x0
[RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x1
	Before schedule, set selector to 0x3
	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
[OK]	GS/BASE remained 0x3/0x0
[RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x1
	Before schedule, set selector to 0x2b
	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
[OK]	GS/BASE remained 0x2b/0x0
[RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x200000000
	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
[OK]	GS/BASE remained 0x0/0x0
[RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x200000000
	Before schedule, set selector to 0x1
	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
[OK]	GS/BASE remained 0x1/0x0
[RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x200000000
	Before schedule, set selector to 0x2
	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
[OK]	GS/BASE remained 0x2/0x0
[RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x200000000
	Before schedule, set selector to 0x3
	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
[OK]	GS/BASE remained 0x3/0x0
[RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x200000000
	Before schedule, set selector to 0x2b
	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
[OK]	GS/BASE remained 0x2b/0x0
[RUN]	ARCH_SET_GS(0x1), then schedule to 0x0
	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
[OK]	GS/BASE remained 0x0/0x1
[RUN]	ARCH_SET_GS(0x1), then schedule to 0x0
	Before schedule, set selector to 0x1
	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
[OK]	GS/BASE remained 0x1/0x0
[RUN]	ARCH_SET_GS(0x1), then schedule to 0x0
	Before schedule, set selector to 0x2
	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
[OK]	GS/BASE remained 0x2/0x0
[RUN]	ARCH_SET_GS(0x1), then schedule to 0x0
	Before schedule, set selector to 0x3
	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
[OK]	GS/BASE remained 0x3/0x0
[RUN]	ARCH_SET_GS(0x1), then schedule to 0x0
	Before schedule, set selector to 0x2b
	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
[OK]	GS/BASE remained 0x2b/0x0
[RUN]	ARCH_SET_GS(0x1), then schedule to 0xa1fa5f343cb85fa4
	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
[OK]	GS/BASE remained 0x0/0x1
[RUN]	ARCH_SET_GS(0x1), then schedule to 0xa1fa5f343cb85fa4
	Before schedule, set selector to 0x1
	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
[OK]	GS/BASE remained 0x1/0x0
[RUN]	ARCH_SET_GS(0x1), then schedule to 0xa1fa5f343cb85fa4
	Before schedule, set selector to 0x2
	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
[OK]	GS/BASE remained 0x2/0x0
[RUN]	ARCH_SET_GS(0x1), then schedule to 0xa1fa5f343cb85fa4
	Before schedule, set selector to 0x3
	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
[OK]	GS/BASE remained 0x3/0x0
[RUN]	ARCH_SET_GS(0x1), then schedule to 0xa1fa5f343cb85fa4
	Before schedule, set selector to 0x2b
	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
[OK]	GS/BASE remained 0x2b/0x0
[RUN]	ARCH_SET_GS(0x1), then schedule to 0x1
	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
[OK]	GS/BASE remained 0x0/0x1
[RUN]	ARCH_SET_GS(0x1), then schedule to 0x1
	Before schedule, set selector to 0x1
	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
[OK]	GS/BASE remained 0x1/0x0
[RUN]	ARCH_SET_GS(0x1), then schedule to 0x1
	Before schedule, set selector to 0x2
	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
[OK]	GS/BASE remained 0x2/0x0
[RUN]	ARCH_SET_GS(0x1), then schedule to 0x1
	Before schedule, set selector to 0x3
	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
[OK]	GS/BASE remained 0x3/0x0
[RUN]	ARCH_SET_GS(0x1), then schedule to 0x1
	Before schedule, set selector to 0x2b
	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
[OK]	GS/BASE remained 0x2b/0x0
[RUN]	ARCH_SET_GS(0x1), then schedule to 0x200000000
	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
[OK]	GS/BASE remained 0x0/0x1
[RUN]	ARCH_SET_GS(0x1), then schedule to 0x200000000
	Before schedule, set selector to 0x1
	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
[OK]	GS/BASE remained 0x1/0x0
[RUN]	ARCH_SET_GS(0x1), then schedule to 0x200000000
	Before schedule, set selector to 0x2
	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
[OK]	GS/BASE remained 0x2/0x0
[RUN]	ARCH_SET_GS(0x1), then schedule to 0x200000000
	Before schedule, set selector to 0x3
	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
[OK]	GS/BASE remained 0x3/0x0
[RUN]	ARCH_SET_GS(0x1), then schedule to 0x200000000
	Before schedule, set selector to 0x2b
	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
[OK]	GS/BASE remained 0x2b/0x0
[RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x0
	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
[OK]	GS/BASE remained 0x0/0x200000000
[RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x0
	Before schedule, set selector to 0x1
	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
[OK]	GS/BASE remained 0x1/0x0
[RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x0
	Before schedule, set selector to 0x2
	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
[OK]	GS/BASE remained 0x2/0x0
[RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x0
	Before schedule, set selector to 0x3
	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
[OK]	GS/BASE remained 0x3/0x0
[RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x0
	Before schedule, set selector to 0x2b
	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
[OK]	GS/BASE remained 0x2b/0x0
[RUN]	ARCH_SET_GS(0x200000000), then schedule to 0xa1fa5f343cb85fa4
	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
[OK]	GS/BASE remained 0x0/0x200000000
[RUN]	ARCH_SET_GS(0x200000000), then schedule to 0xa1fa5f343cb85fa4
	Before schedule, set selector to 0x1
	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
[OK]	GS/BASE remained 0x1/0x0
[RUN]	ARCH_SET_GS(0x200000000), then schedule to 0xa1fa5f343cb85fa4
	Before schedule, set selector to 0x2
	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
[OK]	GS/BASE remained 0x2/0x0
[RUN]	ARCH_SET_GS(0x200000000), then schedule to 0xa1fa5f343cb85fa4
	Before schedule, set selector to 0x3
	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
[OK]	GS/BASE remained 0x3/0x0
[RUN]	ARCH_SET_GS(0x200000000), then schedule to 0xa1fa5f343cb85fa4
	Before schedule, set selector to 0x2b
	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
[OK]	GS/BASE remained 0x2b/0x0
[RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x1
	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
[OK]	GS/BASE remained 0x0/0x200000000
[RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x1
	Before schedule, set selector to 0x1
	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
[OK]	GS/BASE remained 0x1/0x0
[RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x1
	Before schedule, set selector to 0x2
	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
[OK]	GS/BASE remained 0x2/0x0
[RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x1
	Before schedule, set selector to 0x3
	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
[OK]	GS/BASE remained 0x3/0x0
[RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x1
	Before schedule, set selector to 0x2b
	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
[OK]	GS/BASE remained 0x2b/0x0
[RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x200000000
	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
[OK]	GS/BASE remained 0x0/0x200000000
[RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x200000000
	Before schedule, set selector to 0x1
	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
[OK]	GS/BASE remained 0x1/0x0
[RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x200000000
	Before schedule, set selector to 0x2
	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
[OK]	GS/BASE remained 0x2/0x0
[RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x200000000
	Before schedule, set selector to 0x3
	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
[OK]	GS/BASE remained 0x3/0x0
[RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x200000000
	Before schedule, set selector to 0x2b
	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
[OK]	GS/BASE remained 0x2b/0x0
[RUN]	ARCH_SET_GS(0), clear gs, then manipulate GSBASE in a different thread
	other thread: using LDT slot 0
[OK]	GSBASE remained 0
ok 1..35 selftests: x86: fsgsbase_64 [PASS]
selftests: x86: sysret_rip_64
========================================
[RUN]	sigreturn to 0x800000000000
[OK]	Got SIGSEGV at RIP=0x800000000000
[RUN]	sigreturn to 0x1000000000000
[OK]	Got SIGSEGV at RIP=0x1000000000000
[RUN]	sigreturn to 0x2000000000000
[OK]	Got SIGSEGV at RIP=0x2000000000000
[RUN]	sigreturn to 0x4000000000000
[OK]	Got SIGSEGV at RIP=0x4000000000000
[RUN]	sigreturn to 0x8000000000000
[OK]	Got SIGSEGV at RIP=0x8000000000000
[RUN]	sigreturn to 0x10000000000000
[OK]	Got SIGSEGV at RIP=0x10000000000000
[RUN]	sigreturn to 0x20000000000000
[OK]	Got SIGSEGV at RIP=0x20000000000000
[RUN]	sigreturn to 0x40000000000000
[OK]	Got SIGSEGV at RIP=0x40000000000000
[RUN]	sigreturn to 0x80000000000000
[OK]	Got SIGSEGV at RIP=0x80000000000000
[RUN]	sigreturn to 0x100000000000000
[OK]	Got SIGSEGV at RIP=0x100000000000000
[RUN]	sigreturn to 0x200000000000000
[OK]	Got SIGSEGV at RIP=0x200000000000000
[RUN]	sigreturn to 0x400000000000000
[OK]	Got SIGSEGV at RIP=0x400000000000000
[RUN]	sigreturn to 0x800000000000000
[OK]	Got SIGSEGV at RIP=0x800000000000000
[RUN]	sigreturn to 0x1000000000000000
[OK]	Got SIGSEGV at RIP=0x1000000000000000
[RUN]	sigreturn to 0x2000000000000000
[OK]	Got SIGSEGV at RIP=0x2000000000000000
[RUN]	sigreturn to 0x4000000000000000
[OK]	Got SIGSEGV at RIP=0x4000000000000000
[RUN]	sigreturn to 0x8000000000000000
[OK]	Got SIGSEGV at RIP=0x8000000000000000
[RUN]	Trying a SYSCALL that falls through to 0x7fffffffe000
[OK]	We survived
[RUN]	Trying a SYSCALL that falls through to 0x7ffffffff000
[OK]	We survived
[RUN]	Trying a SYSCALL that falls through to 0x800000000000
[OK]	mremap to 0x7ffffffff000 failed
[RUN]	Trying a SYSCALL that falls through to 0xfffffffff000
[OK]	mremap to 0xffffffffe000 failed
[RUN]	Trying a SYSCALL that falls through to 0x1000000000000
[OK]	mremap to 0xfffffffff000 failed
[RUN]	Trying a SYSCALL that falls through to 0x1fffffffff000
[OK]	mremap to 0x1ffffffffe000 failed
[RUN]	Trying a SYSCALL that falls through to 0x2000000000000
[OK]	mremap to 0x1fffffffff000 failed
[RUN]	Trying a SYSCALL that falls through to 0x3fffffffff000
[OK]	mremap to 0x3ffffffffe000 failed
[RUN]	Trying a SYSCALL that falls through to 0x4000000000000
[OK]	mremap to 0x3fffffffff000 failed
[RUN]	Trying a SYSCALL that falls through to 0x7fffffffff000
[OK]	mremap to 0x7ffffffffe000 failed
[RUN]	Trying a SYSCALL that falls through to 0x8000000000000
[OK]	mremap to 0x7fffffffff000 failed
[RUN]	Trying a SYSCALL that falls through to 0xffffffffff000
[OK]	mremap to 0xfffffffffe000 failed
[RUN]	Trying a SYSCALL that falls through to 0x10000000000000
[OK]	mremap to 0xffffffffff000 failed
[RUN]	Trying a SYSCALL that falls through to 0x1ffffffffff000
[OK]	mremap to 0x1fffffffffe000 failed
[RUN]	Trying a SYSCALL that falls through to 0x20000000000000
[OK]	mremap to 0x1ffffffffff000 failed
[RUN]	Trying a SYSCALL that falls through to 0x3ffffffffff000
[OK]	mremap to 0x3fffffffffe000 failed
[RUN]	Trying a SYSCALL that falls through to 0x40000000000000
[OK]	mremap to 0x3ffffffffff000 failed
[RUN]	Trying a SYSCALL that falls through to 0x7ffffffffff000
[OK]	mremap to 0x7fffffffffe000 failed
[RUN]	Trying a SYSCALL that falls through to 0x80000000000000
[OK]	mremap to 0x7ffffffffff000 failed
[RUN]	Trying a SYSCALL that falls through to 0xfffffffffff000
[OK]	mremap to 0xffffffffffe000 failed
[RUN]	Trying a SYSCALL that falls through to 0x100000000000000
[OK]	mremap to 0xfffffffffff000 failed
[RUN]	Trying a SYSCALL that falls through to 0x1fffffffffff000
[OK]	mremap to 0x1ffffffffffe000 failed
[RUN]	Trying a SYSCALL that falls through to 0x200000000000000
[OK]	mremap to 0x1fffffffffff000 failed
[RUN]	Trying a SYSCALL that falls through to 0x3fffffffffff000
[OK]	mremap to 0x3ffffffffffe000 failed
[RUN]	Trying a SYSCALL that falls through to 0x400000000000000
[OK]	mremap to 0x3fffffffffff000 failed
[RUN]	Trying a SYSCALL that falls through to 0x7fffffffffff000
[OK]	mremap to 0x7ffffffffffe000 failed
[RUN]	Trying a SYSCALL that falls through to 0x800000000000000
[OK]	mremap to 0x7fffffffffff000 failed
[RUN]	Trying a SYSCALL that falls through to 0xffffffffffff000
[OK]	mremap to 0xfffffffffffe000 failed
[RUN]	Trying a SYSCALL that falls through to 0x1000000000000000
[OK]	mremap to 0xffffffffffff000 failed
[RUN]	Trying a SYSCALL that falls through to 0x1ffffffffffff000
[OK]	mremap to 0x1fffffffffffe000 failed
[RUN]	Trying a SYSCALL that falls through to 0x2000000000000000
[OK]	mremap to 0x1ffffffffffff000 failed
[RUN]	Trying a SYSCALL that falls through to 0x3ffffffffffff000
[OK]	mremap to 0x3fffffffffffe000 failed
[RUN]	Trying a SYSCALL that falls through to 0x4000000000000000
[OK]	mremap to 0x3ffffffffffff000 failed
[RUN]	Trying a SYSCALL that falls through to 0x7ffffffffffff000
[OK]	mremap to 0x7fffffffffffe000 failed
[RUN]	Trying a SYSCALL that falls through to 0x8000000000000000
[OK]	mremap to 0x7ffffffffffff000 failed
ok 1..36 selftests: x86: sysret_rip_64 [PASS]
selftests: x86: ldt_gdt_64
========================================
[NOTE]	set_thread_area is available; will use GDT index 12
[OK]	LDT entry 0 has AR 0x0040FB00 and limit 0x0000000A
[OK]	LDT entry 0 has AR 0x00C0FB00 and limit 0x0000AFFF
[OK]	LDT entry 1 is invalid
[OK]	LDT entry 2 has AR 0x00C0FB00 and limit 0x0000AFFF
[OK]	LDT entry 1 is invalid
[OK]	LDT entry 2 has AR 0x00C0FB00 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D0FB00 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D07B00 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00907B00 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D07300 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D07100 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D07500 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00507700 and limit 0x0000000A
[OK]	LDT entry 2 has AR 0x00507F00 and limit 0x0000000A
[OK]	LDT entry 2 has AR 0x00507D00 and limit 0x0000000A
[OK]	LDT entry 2 has AR 0x00507B00 and limit 0x0000000A
[OK]	LDT entry 2 has AR 0x00507900 and limit 0x0000000A
[OK]	LDT entry 2 has AR 0x00507900 and limit 0x0000000A
[RUN]	Test fork
[OK]	LDT entry 2 has AR 0x00507900 and limit 0x0000000A
[OK]	LDT entry 1 is invalid
[OK]	LDT entry 0 is invalid
[NOTE]	set_thread_area is available; will use GDT index 12
[OK]	LDT entry 0 has AR 0x0040FB00 and limit 0x0000000A
[OK]	LDT entry 0 has AR 0x00C0FB00 and limit 0x0000AFFF
[OK]	LDT entry 1 is invalid
[OK]	LDT entry 2 has AR 0x00C0FB00 and limit 0x0000AFFF
[OK]	LDT entry 1 is invalid
[OK]	LDT entry 2 has AR 0x00C0FB00 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D0FB00 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D07B00 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00907B00 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D07300 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D07100 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D07500 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00507700 and limit 0x0000000A
[OK]	LDT entry 2 has AR 0x00507F00 and limit 0x0000000A
[OK]	LDT entry 2 has AR 0x00507D00 and limit 0x0000000A
[OK]	LDT entry 2 has AR 0x00507B00 and limit 0x0000000A
[OK]	LDT entry 2 has AR 0x00507900 and limit 0x0000000A
[OK]	LDT entry 2 has AR 0x00507900 and limit 0x0000000A
[RUN]	Test fork
[OK]	Child succeeded
[RUN]	Test size
[DONE]	Size test
[OK]	modify_ldt failure 22
[OK]	LDT entry 0 has AR 0x0000F300 and limit 0x00000000
[OK]	LDT entry 0 has AR 0x00007300 and limit 0x00000000
[OK]	LDT entry 0 has AR 0x0000F100 and limit 0x00000000
[OK]	LDT entry 0 has AR 0x00007300 and limit 0x00000000
[OK]	LDT entry 0 has AR 0x00007100 and limit 0x00000001
[OK]	LDT entry 0 has AR 0x00007100 and limit 0x00000000
[OK]	LDT entry 0 is invalid
[OK]	LDT entry 0 has AR 0x0040F300 and limit 0x000FFFFF
[OK]	LDT entry 0 has AR 0x00C0F300 and limit 0xFFFFFFFF
[OK]	LDT entry 0 has AR 0x00C0F100 and limit 0xFFFFFFFF
[OK]	LDT entry 0 has AR 0x00C0F700 and limit 0xFFFFFFFF
[OK]	LDT entry 0 has AR 0x00C0F500 and limit 0xFFFFFFFF
[OK]	LDT entry 0 is invalid
[RUN]	Cross-CPU LDT invalidation
[OK]	All 5 iterations succeeded
[RUN]	Test exec
[OK]	LDT entry 0 has AR 0x0040FB00 and limit 0x0000002A
[OK]	Child succeeded
[OK]	Invalidate DS with set_thread_area: new DS = 0x0
[OK]	Invalidate ES with set_thread_area: new ES = 0x0
[OK]	Invalidate FS with set_thread_area: new FS = 0x0
[OK]	New FSBASE was zero
[OK]	Invalidate GS with set_thread_area: new GS = 0x0
[OK]	New GSBASE was zero
ok 1..37 selftests: x86: ldt_gdt_64 [PASS]
selftests: x86: ptrace_syscall_64
========================================
[RUN]	Check int80 return regs
[OK]	getpid() preserves regs
[OK]	kill(getpid(), SIGUSR1) preserves regs
[RUN]	ptrace-induced syscall restart
[RUN]	SYSEMU
[OK]	Initial nr and args are correct
[RUN]	Restart the syscall (ip = 0x7f395f0aa309)
[OK]	Restarted nr and args are correct
[RUN]	Change nr and args and restart the syscall (ip = 0x7f395f0aa309)
[OK]	Replacement nr and args are correct
[OK]	Child exited cleanly
[RUN]	kernel syscall restart under ptrace
[RUN]	SYSCALL
[OK]	Initial nr and args are correct
[RUN]	SYSCALL
[OK]	Args after SIGUSR1 are correct (ax = -514)
[OK]	Child got SIGUSR1
[RUN]	Step again
[OK]	pause(2) restarted correctly
ok 1..38 selftests: x86: ptrace_syscall_64 [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86'
ignored_by_lkp zram test



To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email



Thanks,
Rong Chen


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.0.0-rc3-00060-g6ea3dfe"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.0.0-rc3 Kernel Configuration
#

#
# Compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=70300
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
CONFIG_PGTABLE_LEVELS=4
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
# CONFIG_X86_5LEVEL is not set
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
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
# CONFIG_SECURITY_LOADPIN is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_SECURITY_SAFESETID is not set
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
CONFIG_LSM="yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
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

--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='kernel_selftests'
	export testcase='kernel_selftests'
	export category='functional'
	export need_memory='2G'
	export need_cpu=2
	export kernel_cmdline='erst_disable'
	export job_origin='/lkp/lkp/.src-20190226-164723/allot/cyclic:vm:linux-devel:devel-hourly/vm-snb-4G/kernel_selftests.yaml'
	export queue_cmdline_keys='branch
commit'
	export queue='bisect'
	export testbox='vm-snb-4G-763'
	export tbox_group='vm-snb-4G'
	export submit_id='5c7624810b9a9335090af842'
	export job_file='/lkp/jobs/scheduled/vm-snb-4G-763/kernel_selftests-kselftests-03-debian-x86_64-2018-04-03.cgz-6ea3dfe1e-20190227-79113-awlp07-2.yaml'
	export id='40df379d9a54d8347c61f87c2a7a8f16c9129ddf'
	export queuer_version='/lkp/lkp/.src-20190226-164723'
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
	export commit='6ea3dfe1e0732c5bd3be1e073690b06a83c03c25'
	export ssh_base_port=23032
	export kconfig='x86_64-rhel-7.2'
	export compiler='gcc-7'
	export rootfs='debian-x86_64-2018-04-03.cgz'
	export enqueue_time='2019-02-27 13:47:45 +0800'
	export _id='5c7628bb0b9a9335090af844'
	export _rt='/result/kernel_selftests/kselftests-03/vm-snb-4G/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.2/gcc-7/6ea3dfe1e0732c5bd3be1e073690b06a83c03c25'
	export user='lkp'
	export head_commit='7d6af384841724bbfe2b7394dfd33bae398becd7'
	export base_commit='5908e6b738e3357af42c10e1183753c70a0117a9'
	export branch='linux-devel/devel-hourly-2019022601'
	export result_root='/result/kernel_selftests/kselftests-03/vm-snb-4G/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.2/gcc-7/6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/8'
	export scheduler_version='/lkp/lkp/.src-20190227-134226'
	export LKP_SERVER='inn'
	export max_uptime=3600
	export initrd='/osimage/debian/debian-x86_64-2018-04-03.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/vm-snb-4G-763/kernel_selftests-kselftests-03-debian-x86_64-2018-04-03.cgz-6ea3dfe1e-20190227-79113-awlp07-2.yaml
ARCH=x86_64
kconfig=x86_64-rhel-7.2
branch=linux-devel/devel-hourly-2019022601
commit=6ea3dfe1e0732c5bd3be1e073690b06a83c03c25
BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.2/gcc-7/6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/vmlinuz-5.0.0-rc3-00060-g6ea3dfe
erst_disable
max_uptime=3600
RESULT_ROOT=/result/kernel_selftests/kselftests-03/vm-snb-4G/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.2/gcc-7/6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/8
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
	export modules_initrd='/pkg/linux/x86_64-rhel-7.2/gcc-7/6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/modules.cgz'
	export bm_initrd='/osimage/deps/debian-x86_64-2018-04-03.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/lkp_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/kernel_selftests_2018-12-12.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/kernel_selftests-x86_64-f5d582777bcb_2018-12-12.cgz'
	export linux_headers_initrd='/pkg/linux/x86_64-rhel-7.2/gcc-7/6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/linux-headers.cgz'
	export linux_selftests_initrd='/pkg/linux/x86_64-rhel-7.2/gcc-7/6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/linux-selftests.cgz'
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
	export kernel='/pkg/linux/x86_64-rhel-7.2/gcc-7/6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/vmlinuz-5.0.0-rc3-00060-g6ea3dfe'
	export dequeue_time='2019-02-27 15:14:46 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-snb-4G-763/kernel_selftests-kselftests-03-debian-x86_64-2018-04-03.cgz-6ea3dfe1e-20190227-79113-awlp07-2.cgz'

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

	run_test group='kselftests-03' $LKP_SRC/tests/wrapper kernel_selftests
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

--4ZLFUWh1odzi/v6L
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=kernel_selftests

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25
2019-02-27 15:15:21 ln -sf /usr/bin/clang-7 /usr/bin/clang
2019-02-27 15:15:21 ln -sf /usr/bin/llc-7 /usr/bin/llc

2019-02-27 15:15:21 make run_tests -C timers
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers'
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  posix_timers.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers/posix_timers
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  nanosleep.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers/nanosleep
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  nsleep-lat.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers/nsleep-lat
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  set-timer-lat.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers/set-timer-lat
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  mqueue-lat.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers/mqueue-lat
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  inconsistency-check.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers/inconsistency-check
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  raw_skew.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers/raw_skew
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  threadtest.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers/threadtest
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  rtcpie.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers/rtcpie
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  alarmtimer-suspend.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers/alarmtimer-suspend
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  valid-adjtimex.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers/valid-adjtimex
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  adjtick.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers/adjtick
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  change_skew.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers/change_skew
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  skew_consistency.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers/skew_consistency
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  clocksource-switch.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers/clocksource-switch
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  freq-step.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers/freq-step
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  leap-a-day.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers/leap-a-day
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  leapcrash.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers/leapcrash
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  set-tai.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers/set-tai
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  set-2038.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers/set-2038
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  set-tz.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers/set-tz
TAP version 13
selftests: timers: posix_timers
========================================
Testing posix timers. False negative may happen on CPU execution 
based timers if other threads run on the CPU...
Check itimer virtual... [OK]
Check itimer prof... [OK]
Check itimer real... [OK]
Check timer_create() per thread... [OK]
Check timer_create() per process... [OK]
Pass 0 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..0
ok 1..1 selftests: timers: posix_timers [PASS]
selftests: timers: nanosleep
========================================
Nanosleep CLOCK_REALTIME                  [OK]
Nanosleep CLOCK_MONOTONIC                 [OK]
Nanosleep CLOCK_MONOTONIC_RAW             [UNSUPPORTED]
Nanosleep CLOCK_REALTIME_COARSE           [UNSUPPORTED]
Nanosleep CLOCK_MONOTONIC_COARSE          [UNSUPPORTED]
Nanosleep CLOCK_BOOTTIME                  [OK]
Nanosleep CLOCK_REALTIME_ALARM            [OK]
Nanosleep CLOCK_BOOTTIME_ALARM            [OK]
Nanosleep CLOCK_TAI                       [OK]
Pass 0 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..0
ok 1..2 selftests: timers: nanosleep [PASS]
selftests: timers: nsleep-lat
========================================
nsleep latency CLOCK_REALTIME             [OK]
nsleep latency CLOCK_MONOTONIC            [OK]
nsleep latency CLOCK_MONOTONIC_RAW        [UNSUPPORTED]
nsleep latency CLOCK_REALTIME_COARSE      [UNSUPPORTED]
nsleep latency CLOCK_MONOTONIC_COARSE     [UNSUPPORTED]
nsleep latency CLOCK_BOOTTIME             [OK]
nsleep latency CLOCK_REALTIME_ALARM       [OK]
nsleep latency CLOCK_BOOTTIME_ALARM       [OK]
nsleep latency CLOCK_TAI                  [OK]
Pass 0 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..0
ok 1..3 selftests: timers: nsleep-lat [PASS]
selftests: timers: set-timer-lat
========================================
Setting timers for every 1 seconds
CLOCK_REALTIME         ABSTIME PERIODIC timer fired early:       0 : [OK]
CLOCK_REALTIME         ABSTIME PERIODIC max latency:     112099 ns : [OK]
CLOCK_REALTIME         RELTIME PERIODIC timer fired early:       0 : [OK]
CLOCK_REALTIME         RELTIME PERIODIC max latency:      82088 ns : [OK]
CLOCK_REALTIME         ABSTIME ONE-SHOT timer fired early:       0 : [OK]
CLOCK_REALTIME         ABSTIME ONE-SHOT max latency:      56827 ns : [OK]
CLOCK_REALTIME         ABSTIME ONE-SHOT count:                   1 : [OK]
CLOCK_REALTIME         RELTIME ONE-SHOT timer fired early:       0 : [OK]
CLOCK_REALTIME         RELTIME ONE-SHOT max latency:      73434 ns : [OK]
CLOCK_REALTIME         RELTIME ONE-SHOT count:                   1 : [OK]
CLOCK_MONOTONIC        ABSTIME PERIODIC timer fired early:       0 : [OK]
CLOCK_MONOTONIC        ABSTIME PERIODIC max latency:      90264 ns : [OK]
CLOCK_MONOTONIC        RELTIME PERIODIC timer fired early:       0 : [OK]
CLOCK_MONOTONIC        RELTIME PERIODIC max latency:      90327 ns : [OK]
CLOCK_MONOTONIC        ABSTIME ONE-SHOT timer fired early:       0 : [OK]
CLOCK_MONOTONIC        ABSTIME ONE-SHOT max latency:      75888 ns : [OK]
CLOCK_MONOTONIC        ABSTIME ONE-SHOT count:                   1 : [OK]
CLOCK_MONOTONIC        RELTIME ONE-SHOT timer fired early:       0 : [OK]
CLOCK_MONOTONIC        RELTIME ONE-SHOT max latency:      64950 ns : [OK]
CLOCK_MONOTONIC        RELTIME ONE-SHOT count:                   1 : [OK]
CLOCK_BOOTTIME         ABSTIME PERIODIC timer fired early:       0 : [OK]
CLOCK_BOOTTIME         ABSTIME PERIODIC max latency:      83457 ns : [OK]
CLOCK_BOOTTIME         RELTIME PERIODIC timer fired early:       0 : [OK]
CLOCK_BOOTTIME         RELTIME PERIODIC max latency:     118242 ns : [OK]
CLOCK_BOOTTIME         ABSTIME ONE-SHOT timer fired early:       0 : [OK]
CLOCK_BOOTTIME         ABSTIME ONE-SHOT max latency:     101604 ns : [OK]
CLOCK_BOOTTIME         ABSTIME ONE-SHOT count:                   1 : [OK]
CLOCK_BOOTTIME         RELTIME ONE-SHOT timer fired early:       0 : [OK]
CLOCK_BOOTTIME         RELTIME ONE-SHOT max latency:      64288 ns : [OK]
CLOCK_BOOTTIME         RELTIME ONE-SHOT count:                   1 : [OK]
CLOCK_REALTIME_ALARM   ABSTIME PERIODIC timer fired early:       0 : [OK]
CLOCK_REALTIME_ALARM   ABSTIME PERIODIC max latency:      88942 ns : [OK]
CLOCK_REALTIME_ALARM   RELTIME PERIODIC timer fired early:       0 : [OK]
CLOCK_REALTIME_ALARM   RELTIME PERIODIC max latency:      92606 ns : [OK]
CLOCK_REALTIME_ALARM   ABSTIME ONE-SHOT timer fired early:       0 : [OK]
CLOCK_REALTIME_ALARM   ABSTIME ONE-SHOT max latency:      79689 ns : [OK]
CLOCK_REALTIME_ALARM   ABSTIME ONE-SHOT count:                   1 : [OK]
CLOCK_REALTIME_ALARM   RELTIME ONE-SHOT timer fired early:       0 : [OK]
CLOCK_REALTIME_ALARM   RELTIME ONE-SHOT max latency:      73682 ns : [OK]
CLOCK_REALTIME_ALARM   RELTIME ONE-SHOT count:                   1 : [OK]
CLOCK_BOOTTIME_ALARM   ABSTIME PERIODIC timer fired early:       0 : [OK]
CLOCK_BOOTTIME_ALARM   ABSTIME PERIODIC max latency:     111494 ns : [OK]
CLOCK_BOOTTIME_ALARM   RELTIME PERIODIC timer fired early:       0 : [OK]
CLOCK_BOOTTIME_ALARM   RELTIME PERIODIC max latency:     106944 ns : [OK]
CLOCK_BOOTTIME_ALARM   ABSTIME ONE-SHOT timer fired early:       0 : [OK]
CLOCK_BOOTTIME_ALARM   ABSTIME ONE-SHOT max latency:      96530 ns : [OK]
CLOCK_BOOTTIME_ALARM   ABSTIME ONE-SHOT count:                   1 : [OK]
CLOCK_BOOTTIME_ALARM   RELTIME ONE-SHOT timer fired early:       0 : [OK]
CLOCK_BOOTTIME_ALARM   RELTIME ONE-SHOT max latency:      84931 ns : [OK]
CLOCK_BOOTTIME_ALARM   RELTIME ONE-SHOT count:                   1 : [OK]
CLOCK_TAI              ABSTIME PERIODIC timer fired early:       0 : [OK]
CLOCK_TAI              ABSTIME PERIODIC max latency:      96775 ns : [OK]
CLOCK_TAI              RELTIME PERIODIC timer fired early:       0 : [OK]
CLOCK_TAI              RELTIME PERIODIC max latency:      84091 ns : [OK]
CLOCK_TAI              ABSTIME ONE-SHOT timer fired early:       0 : [OK]
CLOCK_TAI              ABSTIME ONE-SHOT max latency:      82905 ns : [OK]
CLOCK_TAI              ABSTIME ONE-SHOT count:                   1 : [OK]
CLOCK_TAI              RELTIME ONE-SHOT timer fired early:       0 : [OK]
CLOCK_TAI              RELTIME ONE-SHOT max latency:     147295 ns : [OK]
CLOCK_TAI              RELTIME ONE-SHOT count:                   1 : [OK]
Pass 0 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..0
ok 1..4 selftests: timers: set-timer-lat [PASS]
selftests: timers: mqueue-lat
========================================
Mqueue latency :                          [OK]
Pass 0 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..0
ok 1..5 selftests: timers: mqueue-lat [PASS]
selftests: timers: inconsistency-check
========================================
Consistent CLOCK_REALTIME                 [OK]
Consistent CLOCK_MONOTONIC                [OK]
Consistent CLOCK_PROCESS_CPUTIME_ID       [OK]
Consistent CLOCK_THREAD_CPUTIME_ID        [OK]
Consistent CLOCK_MONOTONIC_RAW            [OK]
Consistent CLOCK_REALTIME_COARSE          [OK]
Consistent CLOCK_MONOTONIC_COARSE         [OK]
Consistent CLOCK_BOOTTIME                 [OK]
Consistent CLOCK_REALTIME_ALARM           [OK]
Consistent CLOCK_BOOTTIME_ALARM           [OK]
Consistent CLOCK_TAI                      [OK]
Pass 0 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..0
ok 1..6 selftests: timers: inconsistency-check [PASS]
selftests: timers: raw_skew
========================================
Estimating clock drift: 0.0(est) 0.0(act)	[OK]
Pass 0 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..0
ok 1..7 selftests: timers: raw_skew [PASS]
selftests: timers: threadtest
========================================
Wed, 27 Feb 2019 15:23:51 +0800
Testing consistency with 8 threads for 30 seconds: [OK]
Pass 0 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..0
ok 1..8 selftests: timers: threadtest [PASS]
selftests: timers: rtcpie
========================================

Periodic IRQ rate is 1024Hz.
Counting 20 interrupts at:
2Hz:	 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
4Hz:	 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
8Hz:	 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
16Hz:	 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
32Hz:	 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
64Hz:	
PIE delta error: 0.017446 should be close to 0.015625
not ok 1..9 selftests: timers: rtcpie [FAIL]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/timers'

2019-02-27 15:24:40 make run_tests -C tpm2
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/tpm2'
TAP version 13
selftests: tpm2: test_smoke.sh
========================================
test_seal_with_auth (tpm2_tests.SmokeTest) ... ERROR
test_seal_with_policy (tpm2_tests.SmokeTest) ... ERROR
test_seal_with_too_long_auth (tpm2_tests.SmokeTest) ... ERROR
test_too_short_cmd (tpm2_tests.SmokeTest) ... ERROR
test_unseal_with_wrong_auth (tpm2_tests.SmokeTest) ... ERROR
test_unseal_with_wrong_policy (tpm2_tests.SmokeTest) ... ERROR

======================================================================
ERROR: test_seal_with_auth (tpm2_tests.SmokeTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "tpm2_tests.py", line 15, in setUp
    self.client = tpm2.Client()
  File "tpm2.py", line 360, in __init__
    self.tpm = open('/dev/tpm0', 'r+b')
IOError: [Errno 2] No such file or directory: '/dev/tpm0'

======================================================================
ERROR: test_seal_with_policy (tpm2_tests.SmokeTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "tpm2_tests.py", line 15, in setUp
    self.client = tpm2.Client()
  File "tpm2.py", line 360, in __init__
    self.tpm = open('/dev/tpm0', 'r+b')
IOError: [Errno 2] No such file or directory: '/dev/tpm0'

======================================================================
ERROR: test_seal_with_too_long_auth (tpm2_tests.SmokeTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "tpm2_tests.py", line 15, in setUp
    self.client = tpm2.Client()
  File "tpm2.py", line 360, in __init__
    self.tpm = open('/dev/tpm0', 'r+b')
IOError: [Errno 2] No such file or directory: '/dev/tpm0'

======================================================================
ERROR: test_too_short_cmd (tpm2_tests.SmokeTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "tpm2_tests.py", line 15, in setUp
    self.client = tpm2.Client()
  File "tpm2.py", line 360, in __init__
    self.tpm = open('/dev/tpm0', 'r+b')
IOError: [Errno 2] No such file or directory: '/dev/tpm0'

======================================================================
ERROR: test_unseal_with_wrong_auth (tpm2_tests.SmokeTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "tpm2_tests.py", line 15, in setUp
    self.client = tpm2.Client()
  File "tpm2.py", line 360, in __init__
    self.tpm = open('/dev/tpm0', 'r+b')
IOError: [Errno 2] No such file or directory: '/dev/tpm0'

======================================================================
ERROR: test_unseal_with_wrong_policy (tpm2_tests.SmokeTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "tpm2_tests.py", line 15, in setUp
    self.client = tpm2.Client()
  File "tpm2.py", line 360, in __init__
    self.tpm = open('/dev/tpm0', 'r+b')
IOError: [Errno 2] No such file or directory: '/dev/tpm0'

----------------------------------------------------------------------
Ran 6 tests in 0.001s

FAILED (errors=6)
not ok 1..1 selftests: tpm2: test_smoke.sh [FAIL]
selftests: tpm2: test_space.sh
========================================
test_flush_context (tpm2_tests.SpaceTest) ... ERROR
test_get_handles (tpm2_tests.SpaceTest) ... ERROR
test_invalid_cc (tpm2_tests.SpaceTest) ... ERROR
test_make_two_spaces (tpm2_tests.SpaceTest) ... ERROR

======================================================================
ERROR: test_flush_context (tpm2_tests.SpaceTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "tpm2_tests.py", line 183, in test_flush_context
    space1 = tpm2.Client(tpm2.Client.FLAG_SPACE)
  File "tpm2.py", line 362, in __init__
    self.tpm = open('/dev/tpmrm0', 'r+b')
IOError: [Errno 2] No such file or directory: '/dev/tpmrm0'

======================================================================
ERROR: test_get_handles (tpm2_tests.SpaceTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "tpm2_tests.py", line 193, in test_get_handles
    space1 = tpm2.Client(tpm2.Client.FLAG_SPACE)
  File "tpm2.py", line 362, in __init__
    self.tpm = open('/dev/tpmrm0', 'r+b')
IOError: [Errno 2] No such file or directory: '/dev/tpmrm0'

======================================================================
ERROR: test_invalid_cc (tpm2_tests.SpaceTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "tpm2_tests.py", line 212, in test_invalid_cc
    space1 = tpm2.Client(tpm2.Client.FLAG_SPACE)
  File "tpm2.py", line 362, in __init__
    self.tpm = open('/dev/tpmrm0', 'r+b')
IOError: [Errno 2] No such file or directory: '/dev/tpmrm0'

======================================================================
ERROR: test_make_two_spaces (tpm2_tests.SpaceTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "tpm2_tests.py", line 169, in test_make_two_spaces
    space1 = tpm2.Client(tpm2.Client.FLAG_SPACE)
  File "tpm2.py", line 362, in __init__
    self.tpm = open('/dev/tpmrm0', 'r+b')
IOError: [Errno 2] No such file or directory: '/dev/tpmrm0'

----------------------------------------------------------------------
Ran 4 tests in 0.002s

FAILED (errors=4)
not ok 1..2 selftests: tpm2: test_space.sh [FAIL]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/tpm2'
uevent test: not in Makefile
2019-02-27 15:24:40 make TARGETS=uevent
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/uevent'
gcc -Wl,-no-as-needed -Wall uevent_filtering.c -o uevent_filtering
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/uevent'

2019-02-27 15:24:41 make run_tests -C uevent
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/uevent'
TAP version 13
selftests: uevent: uevent_filtering
========================================
add@/devices/virtual/mem/fullACTION=addDEVPATH=/devices/virtual/mem/fullSUBSYSTEM=memSYNTH_UUID=0MAJOR=1MINOR=7DEVNAME=fullDEVMODE=0666SEQNUM=1697
add@/devices/virtual/mem/fullACTION=addDEVPATH=/devices/virtual/mem/fullSUBSYSTEM=memSYNTH_UUID=0MAJOR=1MINOR=7DEVNAME=fullDEVMODE=0666SEQNUM=1710
No buffer space available - Failed to receive uevent
add@/devices/virtual/mem/fullACTION=addDEVPATH=/devices/virtual/mem/fullSUBSYSTEM=memSYNTH_UUID=0MAJOR=1MINOR=7DEVNAME=fullDEVMODE=0666SEQNUM=1746
add@/devices/virtual/mem/fullACTION=addDEVPATH=/devices/virtual/mem/fullSUBSYSTEM=memSYNTH_UUID=0MAJOR=1MINOR=7DEVNAME=fullDEVMODE=0666SEQNUM=1756
add@/devices/virtual/mem/fullACTION=addDEVPATH=/devices/virtual/mem/fullSUBSYSTEM=memSYNTH_UUID=0MAJOR=1MINOR=7DEVNAME=fullDEVMODE=0666SEQNUM=1769
[==========] Running 1 tests from 1 test cases.
[ RUN      ] global.uevent_filtering
[       OK ] global.uevent_filtering
[==========] 1 / 1 tests passed.
[  PASSED  ]
ok 1..1 selftests: uevent: uevent_filtering [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/uevent'

2019-02-27 15:24:43 make run_tests -C user
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/user'
TAP version 13
selftests: user: test_user_copy.sh
========================================
user_copy: ok
ok 1..1 selftests: user: test_user_copy.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/user'
vDSO test: not in Makefile
2019-02-27 15:24:43 make TARGETS=vDSO
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vDSO'
gcc -std=gnu99    vdso_test.c parse_vdso.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vDSO/vdso_test
gcc -std=gnu99 -nostdlib -fno-asynchronous-unwind-tables -fno-stack-protector \
	vdso_standalone_test_x86.c parse_vdso.c \
	-o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vDSO/vdso_standalone_test_x86
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vDSO'

2019-02-27 15:24:43 make run_tests -C vDSO
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vDSO'
TAP version 13
selftests: vDSO: vdso_test
========================================
The time is 1551252283.583175
ok 1..1 selftests: vDSO: vdso_test [PASS]
selftests: vDSO: vdso_standalone_test_x86
========================================
The time is           1551252283.593524
ok 1..2 selftests: vDSO: vdso_standalone_test_x86 [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vDSO'

2019-02-27 15:24:43 make run_tests -C vm
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vm'
make ARCH=x86 -C ../../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25'
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
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25'
gcc -Wall -I ../../../../usr/include     compaction_test.c -lrt -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vm/compaction_test
gcc -Wall -I ../../../../usr/include     gup_benchmark.c -lrt -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vm/gup_benchmark
gcc -Wall -I ../../../../usr/include     hugepage-mmap.c -lrt -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vm/hugepage-mmap
gcc -Wall -I ../../../../usr/include     hugepage-shm.c -lrt -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vm/hugepage-shm
gcc -Wall -I ../../../../usr/include     map_hugetlb.c -lrt -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vm/map_hugetlb
gcc -Wall -I ../../../../usr/include     map_fixed_noreplace.c -lrt -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vm/map_fixed_noreplace
gcc -Wall -I ../../../../usr/include     map_populate.c -lrt -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vm/map_populate
gcc -Wall -I ../../../../usr/include     mlock-random-test.c -lrt -lcap -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vm/mlock-random-test
gcc -Wall -I ../../../../usr/include     mlock2-tests.c -lrt -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vm/mlock2-tests
gcc -Wall -I ../../../../usr/include     on-fault-limit.c -lrt -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vm/on-fault-limit
gcc -Wall -I ../../../../usr/include     thuge-gen.c -lrt -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vm/thuge-gen
gcc -Wall -I ../../../../usr/include     transhuge-stress.c -lrt -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vm/transhuge-stress
gcc -Wall -I ../../../../usr/include     userfaultfd.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vm/userfaultfd
gcc -Wall -I ../../../../usr/include     va_128TBswitch.c -lrt -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vm/va_128TBswitch
gcc -Wall -I ../../../../usr/include     virtual_address_range.c -lrt -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vm/virtual_address_range
TAP version 13
selftests: vm: run_vmtests
========================================
---------------------
running hugepage-mmap
---------------------
Returned address is 0x7ff0b7a00000
First hex is 0
First hex is 3020100
[PASS]
--------------------
running hugepage-shm
--------------------
shmid: 0x0
shmaddr: 0x7f5d81800000
Starting the writes:
................................................................................................................................................................................................................................................................
Starting the Check...Done.
[PASS]
-------------------
running map_hugetlb
-------------------
Returned address is 0x7ff874000000
First hex is 0
First hex is 3020100
[PASS]
NOTE: The above hugetlb tests provide minimal coverage.  Use
      https://github.com/libhugetlbfs/libhugetlbfs.git for
      hugetlb regression testing.
-------------------
running userfaultfd
-------------------
nr_pages: 32768, nr_pages_per_cpu: 16384
bounces: 31, mode: rnd racing ver poll, userfaults: 2703 2888
bounces: 30, mode: racing ver poll, userfaults: 5001 2425
bounces: 29, mode: rnd ver poll, userfaults: 4419 4637
bounces: 28, mode: ver poll, userfaults: 15930 6292
bounces: 27, mode: rnd racing poll, userfaults: 4262 2689
bounces: 26, mode: racing poll, userfaults: 8537 3080
bounces: 25, mode: rnd poll, userfaults: 6019 4104
bounces: 24, mode: poll, userfaults: 8587 5465
bounces: 23, mode: rnd racing ver, userfaults: 1721 7204
bounces: 22, mode: racing ver, userfaults: 2549 2129
bounces: 21, mode: rnd ver, userfaults: 4066 3737
bounces: 20, mode: ver, userfaults: 6170 5100
bounces: 19, mode: rnd racing, userfaults: 4268 4094
bounces: 18, mode: racing, userfaults: 2870 2494
bounces: 17, mode: rnd, userfaults: 6824 6297
bounces: 16, mode:, userfaults: 6829 6360
bounces: 15, mode: rnd racing ver poll, userfaults: 3115 2918
bounces: 14, mode: racing ver poll, userfaults: 6667 1434
bounces: 13, mode: rnd ver poll, userfaults: 4019 5395
bounces: 12, mode: ver poll, userfaults: 2491 4733
bounces: 11, mode: rnd racing poll, userfaults: 3615 3008
bounces: 10, mode: racing poll, userfaults: 2960 4775
bounces: 9, mode: rnd poll, userfaults: 4541 4587
bounces: 8, mode: poll, userfaults: 6640 6258
bounces: 7, mode: rnd racing ver, userfaults: 4449 3356
bounces: 6, mode: racing ver, userfaults: 5784 5127
bounces: 5, mode: rnd ver, userfaults: 6475 5466
bounces: 4, mode: ver, userfaults: 7559 7026
bounces: 3, mode: rnd racing, userfaults: 1727 5211
bounces: 2, mode: racing, userfaults: 4792 4723
bounces: 1, mode: rnd, userfaults: 5464 5139
bounces: 0, mode:, userfaults: 8359 8239
testing UFFDIO_ZEROPAGE: done.
testing signal delivery: done.
testing events (fork, remap, remove): userfaults: 32768
[PASS]
---------------------------
running userfaultfd_hugetlb
---------------------------
nr_pages: 64, nr_pages_per_cpu: 32
bounces: 31, mode: rnd racing ver poll, userfaults: 11 14
bounces: 30, mode: racing ver poll, userfaults: 12 13
bounces: 29, mode: rnd ver poll, userfaults: 16 7
bounces: 28, mode: ver poll, userfaults: 5 2
bounces: 27, mode: rnd racing poll, userfaults: 17 10
bounces: 26, mode: racing poll, userfaults: 10 17
bounces: 25, mode: rnd poll, userfaults: 18 13
bounces: 24, mode: poll, userfaults: 16 4
bounces: 23, mode: rnd racing ver, userfaults: 30 5
bounces: 22, mode: racing ver, userfaults: 25 15
bounces: 21, mode: rnd ver, userfaults: 19 19
bounces: 20, mode: ver, userfaults: 18 11
bounces: 19, mode: rnd racing, userfaults: 24 6
bounces: 18, mode: racing, userfaults: 15 9
bounces: 17, mode: rnd, userfaults: 21 10
bounces: 16, mode:, userfaults: 14 13
bounces: 15, mode: rnd racing ver poll, userfaults: 23 8
bounces: 14, mode: racing ver poll, userfaults: 17 7
bounces: 13, mode: rnd ver poll, userfaults: 19 12
bounces: 12, mode: ver poll, userfaults: 18 12
bounces: 11, mode: rnd racing poll, userfaults: 17 10
bounces: 10, mode: racing poll, userfaults: 16 3
bounces: 9, mode: rnd poll, userfaults: 14 7
bounces: 8, mode: poll, userfaults: 19 13
bounces: 7, mode: rnd racing ver, userfaults: 19 11
bounces: 6, mode: racing ver, userfaults: 21 5
bounces: 5, mode: rnd ver, userfaults: 18 18
bounces: 4, mode: ver, userfaults: 19 11
bounces: 3, mode: rnd racing, userfaults: 17 11
bounces: 2, mode: racing, userfaults: 13 10
bounces: 1, mode: rnd, userfaults: 22 15
bounces: 0, mode:, userfaults: 17 12
testing UFFDIO_ZEROPAGE: done.
testing signal delivery: done.
testing events (fork, remap, remove): userfaults: 64
[PASS]
-------------------------
running userfaultfd_shmem
-------------------------
nr_pages: 32768, nr_pages_per_cpu: 16384
bounces: 31, mode: rnd racing ver poll, userfaults: 4874 832
bounces: 30, mode: racing ver poll, userfaults: 4198 3987
bounces: 29, mode: rnd ver poll, userfaults: 4214 4832
bounces: 28, mode: ver poll, userfaults: 6352 6804
bounces: 27, mode: rnd racing poll, userfaults: 3565 2613
bounces: 26, mode: racing poll, userfaults: 5095 2547
bounces: 25, mode: rnd poll, userfaults: 4706 5501
bounces: 24, mode: poll, userfaults: 5077 5306
bounces: 23, mode: rnd racing ver, userfaults: 3660 3855
bounces: 22, mode: racing ver, userfaults: 3990 1906
bounces: 21, mode: rnd ver, userfaults: 6546 6123
bounces: 20, mode: ver, userfaults: 4790 4657
bounces: 19, mode: rnd racing, userfaults: 4831 4642
bounces: 18, mode: racing, userfaults: 3696 2936
bounces: 17, mode: rnd, userfaults: 6943 5752
bounces: 16, mode:, userfaults: 6531 6499
bounces: 15, mode: rnd racing ver poll, userfaults: 4303 3680
bounces: 14, mode: racing ver poll, userfaults: 3082 4979
bounces: 13, mode: rnd ver poll, userfaults: 5504 9595
bounces: 12, mode: ver poll, userfaults: 6365 6848
bounces: 11, mode: rnd racing poll, userfaults: 4572 4120
bounces: 10, mode: racing poll, userfaults: 3318 5788
bounces: 9, mode: rnd poll, userfaults: 4396 4692
bounces: 8, mode: poll, userfaults: 6163 6676
bounces: 7, mode: rnd racing ver, userfaults: 3148 3606
bounces: 6, mode: racing ver, userfaults: 3530 3421
bounces: 5, mode: rnd ver, userfaults: 5903 5757
bounces: 4, mode: ver, userfaults: 4970 4901
bounces: 3, mode: rnd racing, userfaults: 3964 3317
bounces: 2, mode: racing, userfaults: 4445 4453
bounces: 1, mode: rnd, userfaults: 5309 6216
bounces: 0, mode:, userfaults: 5058 4684
testing UFFDIO_ZEROPAGE: done.
testing signal delivery: done.
testing events (fork, remap, remove): userfaults: 32768
[PASS]
-----------------------
running compaction_test
-----------------------
[ignored_by_lkp]
[PASS]
----------------------
running on-fault-limit
----------------------
[PASS]
--------------------
running map_populate
--------------------
[PASS]
--------------------
running mlock2-tests
--------------------
Failed to make faulted page unevictable
Failed to make faulted page unevictable
Failed to make present page unevictable
[FAIL]
-----------------------------
running virtual_address_range
-----------------------------
[PASS]
-----------------------------
running virtual address 128TB switch test
-----------------------------
[ignored_by_lkp]
[PASS]
not ok 1..1 selftests: vm: run_vmtests [FAIL]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/vm'
watchdog test: not in Makefile
2019-02-27 15:25:16 make TARGETS=watchdog
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/watchdog'
gcc     watchdog-test.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/watchdog/watchdog-test
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/watchdog'
ignored_by_lkp watchdog test
ignored_by_lkp x86.mov_ss_trap test

2019-02-27 15:25:16 make run_tests -C x86
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86'
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/single_step_syscall_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 single_step_syscall.c -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/sysret_ss_attrs_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 sysret_ss_attrs.c -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/syscall_nt_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 syscall_nt.c -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/test_mremap_vdso_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 test_mremap_vdso.c -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/check_initial_reg_state_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -Wl,-ereal_start -static -DCAN_BUILD_32 -DCAN_BUILD_64 check_initial_reg_state.c -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/sigreturn_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 sigreturn.c -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/iopl_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 iopl.c -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/mpx-mini-test_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 mpx-mini-test.c -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/ioperm_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 ioperm.c -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/protection_keys_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 protection_keys.c -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/test_vdso_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 test_vdso.c -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/test_vsyscall_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 test_vsyscall.c -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/entry_from_vm86_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 entry_from_vm86.c -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/syscall_arg_fault_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 syscall_arg_fault.c -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/test_syscall_vdso_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 test_syscall_vdso.c thunks_32.S -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/unwind_vdso_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 unwind_vdso.c -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/test_FCMOV_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 test_FCMOV.c -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/test_FCOMI_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 test_FCOMI.c -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/test_FISTTP_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 test_FISTTP.c -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/vdso_restorer_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 vdso_restorer.c -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/ldt_gdt_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 ldt_gdt.c -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/ptrace_syscall_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 ptrace_syscall.c raw_syscall_helper_32.S -lrt -ldl -lm
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/single_step_syscall_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 single_step_syscall.c -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/sysret_ss_attrs_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 sysret_ss_attrs.c thunks.S -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/syscall_nt_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 syscall_nt.c -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/test_mremap_vdso_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 test_mremap_vdso.c -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/check_initial_reg_state_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -Wl,-ereal_start -static -DCAN_BUILD_32 -DCAN_BUILD_64 check_initial_reg_state.c -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/sigreturn_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 sigreturn.c -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/iopl_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 iopl.c -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/mpx-mini-test_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 mpx-mini-test.c -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/ioperm_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 ioperm.c -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/protection_keys_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 protection_keys.c -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/test_vdso_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 test_vdso.c -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/test_vsyscall_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 test_vsyscall.c -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/fsgsbase_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 fsgsbase.c -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/sysret_rip_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 sysret_rip.c -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/ldt_gdt_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 ldt_gdt.c -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86/ptrace_syscall_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 ptrace_syscall.c -lrt -ldl
TAP version 13
selftests: x86: single_step_syscall_32
========================================
[RUN]	Set TF and check nop
[OK]	Survived with TF set and 14 traps
[RUN]	Set TF and check int80
[OK]	Survived with TF set and 14 traps
[RUN]	Set TF and check a fast syscall
[OK]	Survived with TF set and 43 traps
[RUN]	Fast syscall with TF cleared
[OK]	Nothing unexpected happened
ok 1..1 selftests: x86: single_step_syscall_32 [PASS]
selftests: x86: sysret_ss_attrs_32
========================================
[RUN]	Syscalls followed by SS validation
[OK]	We survived
ok 1..2 selftests: x86: sysret_ss_attrs_32 [PASS]
selftests: x86: syscall_nt_32
========================================
[RUN]	Set NT and issue a syscall
[OK]	The syscall worked and flags are still set
[RUN]	Set NT|TF and issue a syscall
[OK]	The syscall worked and flags are still set
ok 1..3 selftests: x86: syscall_nt_32 [PASS]
selftests: x86: test_mremap_vdso_32
========================================
	AT_SYSINFO_EHDR is 0xf7ee7000
[NOTE]	Moving vDSO: [0xf7ee7000, 0xf7ee8000] -> [0xf7f0f000, 0xf7f10000]
[OK]
ok 1..4 selftests: x86: test_mremap_vdso_32 [PASS]
selftests: x86: check_initial_reg_state_32
========================================
[OK]	All GPRs except SP are 0
[OK]	FLAGS is 0x202
ok 1..5 selftests: x86: check_initial_reg_state_32 [PASS]
selftests: x86: sigreturn_32
========================================
[OK]	set_thread_area refused 16-bit data
[OK]	set_thread_area refused 16-bit data
[RUN]	Valid sigreturn: 64-bit CS (33), 32-bit SS (2b, GDT)
[OK]	all registers okay
[RUN]	Valid sigreturn: 32-bit CS (23), 32-bit SS (2b, GDT)
[OK]	all registers okay
[RUN]	Valid sigreturn: 16-bit CS (37), 32-bit SS (2b, GDT)
[OK]	all registers okay
[RUN]	Valid sigreturn: 64-bit CS (33), 16-bit SS (3f)
[OK]	all registers okay
[RUN]	Valid sigreturn: 32-bit CS (23), 16-bit SS (3f)
[OK]	all registers okay
[RUN]	Valid sigreturn: 16-bit CS (37), 16-bit SS (3f)
[OK]	all registers okay
[RUN]	64-bit CS (33), bogus SS (47)
[OK]	Got #GP(0x0) (i.e. Segmentation fault)
[RUN]	32-bit CS (23), bogus SS (47)
[OK]	Got #GP(0x0) (i.e. Segmentation fault)
[RUN]	16-bit CS (37), bogus SS (47)
[OK]	Got #GP(0x0) (i.e. Segmentation fault)
[RUN]	64-bit CS (33), bogus SS (23)
[OK]	Got #GP(0x20) (i.e. GDT index 4, Segmentation fault)
[RUN]	32-bit CS (23), bogus SS (23)
[OK]	Got #GP(0x20) (i.e. GDT index 4, Segmentation fault)
[RUN]	16-bit CS (37), bogus SS (23)
[OK]	Got #GP(0x20) (i.e. GDT index 4, Segmentation fault)
[RUN]	32-bit CS (4f), bogus SS (2b)
[OK]	Got #NP(0x4c) (i.e. LDT index 9, Bus error)
[RUN]	32-bit CS (23), bogus SS (57)
[OK]	Got #GP(0x0) (i.e. Segmentation fault)
ok 1..6 selftests: x86: sigreturn_32 [PASS]
selftests: x86: iopl_32
========================================
	child: set IOPL to 3
[RUN]	child: write to 0x80
[OK]	Child succeeded
[RUN]	parent: write to 0x80 (should fail)
[OK]	write was denied
	iopl(3)
	Drop privileges
[RUN]	iopl(3) unprivileged but with IOPL==3
[RUN]	iopl(0) unprivileged
[RUN]	iopl(3) unprivileged
[OK]	Failed as expected
ok 1..7 selftests: x86: iopl_32 [PASS]
selftests: x86: mpx-mini-test_32
========================================
processor lacks MPX XSTATE(s), can not run MPX tests
XSAVE is supported by HW & OS
XSAVE processor supported state mask: 0x7
XSAVE OS supported state mask: 0x7
ok 1..8 selftests: x86: mpx-mini-test_32 [PASS]
selftests: x86: ioperm_32
========================================
[OK]	outb to 0x80 failed
[OK]	outb to 0xed failed
[RUN]	enable 0x80
[OK]	outb to 0x80 worked
[OK]	outb to 0xed failed
[RUN]	disable 0x80
[OK]	outb to 0x80 failed
[OK]	outb to 0xed failed
[RUN]	child: check that we inherited permissions
[OK]	outb to 0x80 worked
[OK]	outb to 0xed failed
[OK]	outb to 0x80 failed
[OK]	outb to 0xed failed
[RUN]	enable 0x80
[OK]	outb to 0x80 worked
[OK]	outb to 0xed failed
[RUN]	disable 0x80
[OK]	outb to 0x80 failed
[OK]	outb to 0xed failed
[OK]	Child succeeded
	Drop privileges
[RUN]	disable 0x80
[OK]	it worked
[RUN]	enable 0x80 again
[OK]	it failed
ok 1..9 selftests: x86: ioperm_32 [PASS]
selftests: x86: protection_keys_32
========================================
has pku: 0
running PKEY tests for unsupported CPU/OS
ok 1..10 selftests: x86: protection_keys_32 [PASS]
selftests: x86: test_vdso_32
========================================
Warning: failed to find getcpu in vDSO
[RUN]	Testing clock_gettime for clock CLOCK_REALTIME (0)...
	1551252325.597246296 1551252325.597252343 1551252325.597252973
[RUN]	Testing clock_gettime for clock CLOCK_MONOTONIC (1)...
	632.985155857 632.985156269 632.985156737
[RUN]	Testing clock_gettime for clock CLOCK_PROCESS_CPUTIME_ID (2)...
	0.001371749 0.001372886 0.001373730
[RUN]	Testing clock_gettime for clock CLOCK_THREAD_CPUTIME_ID (3)...
	0.001376964 0.001377806 0.001378641
[RUN]	Testing clock_gettime for clock CLOCK_MONOTONIC_RAW (4)...
	632.577313626 632.577314342 632.577315071
[RUN]	Testing clock_gettime for clock CLOCK_REALTIME_COARSE (5)...
	1551252325.596853650 1551252325.596853650 1551252325.596853650
[RUN]	Testing clock_gettime for clock CLOCK_MONOTONIC_COARSE (6)...
	632.984752162 632.984752162 632.984752162
[RUN]	Testing clock_gettime for clock CLOCK_BOOTTIME (7)...
	632.985178930 632.985179662 632.985180406
[RUN]	Testing clock_gettime for clock CLOCK_REALTIME_ALARM (8)...
	1551252325.597284486 1551252325.597285249 1551252325.597286030
[RUN]	Testing clock_gettime for clock CLOCK_BOOTTIME_ALARM (9)...
	632.985187015 632.985187786 632.985188568
[RUN]	Testing clock_gettime for clock CLOCK_SGI_CYCLE (10)...
[OK]	No such clock.
[RUN]	Testing clock_gettime for clock CLOCK_TAI (11)...
	1551252325.597295127 1551252325.597295489 1551252325.597295966
[RUN]	Testing clock_gettime for clock invalid (-1)...
[OK]	No such clock.
[RUN]	Testing clock_gettime for clock invalid (-2147483648)...
[OK]	No such clock.
[RUN]	Testing clock_gettime for clock invalid (2147483647)...
[OK]	No such clock.
[RUN]	Testing gettimeofday...
	1551252325.597304 1551252325.597304 1551252325.597305
[OK]	timezones match: minuteswest=-480, dsttime=0
[RUN]	Testing getcpu...
[OK]	CPU 0: syscall: cpu 0, node 0
[OK]	CPU 1: syscall: cpu 1, node 0
ok 1..11 selftests: x86: test_vdso_32 [PASS]
selftests: x86: test_vsyscall_32
========================================
[NOTE]	failed to find getcpu in vDSO
[RUN]	test gettimeofday()
	vDSO time offsets: 0.000005 0.000000
[OK]	vDSO gettimeofday()'s timeval was okay
[RUN]	test time()
[OK]	vDSO time() is okay
[RUN]	getcpu() on CPU 0
[RUN]	getcpu() on CPU 1
ok 1..12 selftests: x86: test_vsyscall_32 [PASS]
selftests: x86: entry_from_vm86_32
========================================
[RUN]	#BR from vm86 mode
[SKIP]	vm86 not supported
[RUN]	SYSENTER from vm86 mode
[SKIP]	vm86 not supported
[RUN]	SYSCALL from vm86 mode
[SKIP]	vm86 not supported
[RUN]	STI with VIP set from vm86 mode
[SKIP]	vm86 not supported
[RUN]	POPF with VIP set and IF clear from vm86 mode
[SKIP]	vm86 not supported
[RUN]	POPF with VIP and IF set from vm86 mode
[SKIP]	vm86 not supported
[RUN]	POPF with VIP clear and IF set from vm86 mode
[SKIP]	vm86 not supported
[RUN]	INT3 from vm86 mode
[SKIP]	vm86 not supported
[RUN]	int80 from vm86 mode
[SKIP]	vm86 not supported
[RUN]	UMIP tests from vm86 mode
[SKIP]	vm86 not supported
[INFO]	Result from SMSW:[0x0000]
[INFO]	Result from SIDT: limit[0x0000]base[0x00000000]
[INFO]	Result from SGDT: limit[0x0000]base[0x00000000]
[PASS]	All the results from SMSW are identical.
[PASS]	All the results from SGDT are identical.
[PASS]	All the results from SIDT are identical.
[RUN]	STR instruction from vm86 mode
[SKIP]	vm86 not supported
[RUN]	SLDT instruction from vm86 mode
[SKIP]	vm86 not supported
[RUN]	Execute null pointer from vm86 mode
[SKIP]	vm86 not supported
ok 1..13 selftests: x86: entry_from_vm86_32 [PASS]
[RUN]	#BR from vm86 mode
[SKIP]	vm86 not supported
[RUN]	SYSENTER from vm86 mode
[SKIP]	vm86 not supported
[RUN]	SYSCALL from vm86 mode
[SKIP]	vm86 not supported
[RUN]	STI with VIP set from vm86 mode
[SKIP]	vm86 not supported
[RUN]	POPF with VIP set and IF clear from vm86 mode
[SKIP]	vm86 not supported
[RUN]	POPF with VIP and IF set from vm86 mode
[SKIP]	vm86 not supported
[RUN]	POPF with VIP clear and IF set from vm86 mode
[SKIP]	vm86 not supported
[RUN]	INT3 from vm86 mode
[SKIP]	vm86 not supported
[RUN]	int80 from vm86 mode
[SKIP]	vm86 not supported
[RUN]	UMIP tests from vm86 mode
[SKIP]	vm86 not supported
[INFO]	Result from SMSW:[0x0000]
[INFO]	Result from SIDT: limit[0x0000]base[0x00000000]
[INFO]	Result from SGDT: limit[0x0000]base[0x00000000]
[PASS]	All the results from SMSW are identical.
[PASS]	All the results from SGDT are identical.
[PASS]	All the results from SIDT are identical.
[RUN]	STR instruction from vm86 mode
[SKIP]	vm86 not supported
[RUN]	SLDT instruction from vm86 mode
[SKIP]	vm86 not supported
[RUN]	Execute null pointer from vm86 mode
[SKIP]	vm86 not supported
selftests: x86: syscall_arg_fault_32
========================================
[RUN]	SYSENTER with invalid state
[OK]	Seems okay
[RUN]	SYSCALL with invalid state
[SKIP]	Illegal instruction
ok 1..14 selftests: x86: syscall_arg_fault_32 [PASS]
selftests: x86: test_syscall_vdso_32
========================================
[RUN]	Executing 6-argument 32-bit syscall via VDSO
[WARN]	Flags before=0000000000200ed7 id 0 00 o d i s z 0 a 0 p 1 c
[WARN]	Flags  after=0000000000200606 id 0 00 d i 0 0 p 1 
[WARN]	Flags change=00000000000008d1 0 00 o s z 0 a 0 0 c
[OK]	Arguments are preserved across syscall
[NOTE]	R11 has changed:0000000000200606 - assuming clobbered by SYSRET insn
[OK]	R8..R15 did not leak kernel data
[RUN]	Executing 6-argument 32-bit syscall via INT 80
[OK]	Arguments are preserved across syscall
[OK]	R8..R15 did not leak kernel data
[RUN]	Executing 6-argument 32-bit syscall via VDSO
[WARN]	Flags before=0000000000200ed7 id 0 00 o d i s z 0 a 0 p 1 c
[WARN]	Flags  after=0000000000200606 id 0 00 d i 0 0 p 1 
[WARN]	Flags change=00000000000008d1 0 00 o s z 0 a 0 0 c
[OK]	Arguments are preserved across syscall
[NOTE]	R11 has changed:0000000000200606 - assuming clobbered by SYSRET insn
[OK]	R8..R15 did not leak kernel data
[RUN]	Executing 6-argument 32-bit syscall via INT 80
[OK]	Arguments are preserved across syscall
[OK]	R8..R15 did not leak kernel data
[RUN]	Running tests under ptrace
ok 1..15 selftests: x86: test_syscall_vdso_32 [PASS]
selftests: x86: unwind_vdso_32
========================================
	AT_SYSINFO is 0xf7fbd940
[OK]	AT_SYSINFO maps to linux-gate.so.1, loaded at 0x0xf7fbd000
[RUN]	Set TF and check a fast syscall
	In vsyscall at 0xf7fbd940, returning to 0xf7da9877
	SIGTRAP at 0xf7fbd940
	  0xf7fbd940
	  0xf7da9877
[OK]	  NR = 20, args = 1, 2, 3, 4, 5, 6
	SIGTRAP at 0xf7fbd941
	  0xf7fbd941
	  0xf7da9877
[OK]	  NR = 20, args = 1, 2, 3, 4, 5, 6
	SIGTRAP at 0xf7fbd942
	  0xf7fbd942
	  0xf7da9877
[OK]	  NR = 20, args = 1, 2, 3, 4, 5, 6
	SIGTRAP at 0xf7fbd943
	  0xf7fbd943
	  0xf7da9877
[OK]	  NR = 20, args = 1, 2, 3, 4, 5, 6
	SIGTRAP at 0xf7fbd945
	  0xf7fbd945
	  0xf7da9877
[OK]	  NR = 20, args = 1, 2, 3, 4, 5, 6
	SIGTRAP at 0xf7fbd94a
	  0xf7fbd94a
	  0xf7da9877
[OK]	  NR = 10002, args = 1, 2, 3, 4, 5, 6
	SIGTRAP at 0xf7fbd94b
	  0xf7fbd94b
	  0xf7da9877
[OK]	  NR = 10002, args = 1, 2, 3, 4, 5, 6
	SIGTRAP at 0xf7fbd94c
	  0xf7fbd94c
	  0xf7da9877
[OK]	  NR = 10002, args = 1, 2, 3, 4, 5, 6
	Vsyscall is done
[OK]	All is well
ok 1..16 selftests: x86: unwind_vdso_32 [PASS]
selftests: x86: test_FCMOV_32
========================================
[RUN]	Testing fcmovCC instructions
[OK]	fcmovCC
ok 1..17 selftests: x86: test_FCMOV_32 [PASS]
selftests: x86: test_FCOMI_32
========================================
[RUN]	Testing f[u]comi[p] instructions
[OK]	f[u]comi[p]
ok 1..18 selftests: x86: test_FCOMI_32 [PASS]
selftests: x86: test_FISTTP_32
========================================
[RUN]	Testing fisttp instructions
[OK]	fisttp
ok 1..19 selftests: x86: test_FISTTP_32 [PASS]
selftests: x86: vdso_restorer_32
========================================
[OK]	SA_SIGINFO handler returned successfully
[OK]	!SA_SIGINFO handler returned successfully
ok 1..20 selftests: x86: vdso_restorer_32 [PASS]
selftests: x86: ldt_gdt_32
========================================
[NOTE]	set_thread_area is available; will use GDT index 13
[OK]	LDT entry 0 has AR 0x0040FB00 and limit 0x0000000A
[OK]	LDT entry 0 has AR 0x00C0FB00 and limit 0x0000AFFF
[OK]	LDT entry 1 is invalid
[OK]	LDT entry 2 has AR 0x00C0FB00 and limit 0x0000AFFF
[OK]	LDT entry 1 is invalid
[OK]	LDT entry 2 has AR 0x00C0FB00 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D0FB00 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D07B00 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00907B00 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D07300 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D07100 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D07500 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00507700 and limit 0x0000000A
[OK]	LDT entry 2 has AR 0x00507F00 and limit 0x0000000A
[OK]	LDT entry 2 has AR 0x00507D00 and limit 0x0000000A
[OK]	LDT entry 2 has AR 0x00507B00 and limit 0x0000000A
[OK]	LDT entry 2 has AR 0x00507900 and limit 0x0000000A
[RUN]	Test fork
[OK]	LDT entry 2 has AR 0x00507900 and limit 0x0000000A
[OK]	LDT entry 1 is invalid
[OK]	LDT entry 0 is invalid
[NOTE]	set_thread_area is available; will use GDT index 13
[OK]	LDT entry 0 has AR 0x0040FB00 and limit 0x0000000A
[OK]	LDT entry 0 has AR 0x00C0FB00 and limit 0x0000AFFF
[OK]	LDT entry 1 is invalid
[OK]	LDT entry 2 has AR 0x00C0FB00 and limit 0x0000AFFF
[OK]	LDT entry 1 is invalid
[OK]	LDT entry 2 has AR 0x00C0FB00 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D0FB00 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D07B00 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00907B00 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D07300 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D07100 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D07500 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00507700 and limit 0x0000000A
[OK]	LDT entry 2 has AR 0x00507F00 and limit 0x0000000A
[OK]	LDT entry 2 has AR 0x00507D00 and limit 0x0000000A
[OK]	LDT entry 2 has AR 0x00507B00 and limit 0x0000000A
[OK]	LDT entry 2 has AR 0x00507900 and limit 0x0000000A
[RUN]	Test fork
[OK]	Child succeeded
[RUN]	Test size
[DONE]	Size test
[OK]	modify_ldt failure 22
[OK]	LDT entry 0 has AR 0x0000F300 and limit 0x00000000
[OK]	LDT entry 0 has AR 0x00007300 and limit 0x00000000
[OK]	LDT entry 0 has AR 0x0000F100 and limit 0x00000000
[OK]	LDT entry 0 has AR 0x00007300 and limit 0x00000000
[OK]	LDT entry 0 has AR 0x00007100 and limit 0x00000001
[OK]	LDT entry 0 has AR 0x00007100 and limit 0x00000000
[OK]	LDT entry 0 is invalid
[OK]	LDT entry 0 has AR 0x0040F300 and limit 0x000FFFFF
[OK]	GDT entry 13 has AR 0x0040F300 and limit 0x000FFFFF
[OK]	LDT entry 0 has AR 0x00C0F300 and limit 0xFFFFFFFF
[OK]	GDT entry 13 has AR 0x00C0F300 and limit 0xFFFFFFFF
[OK]	LDT entry 0 has AR 0x00C0F100 and limit 0xFFFFFFFF
[OK]	GDT entry 13 has AR 0x00C0F100 and limit 0xFFFFFFFF
[OK]	LDT entry 0 has AR 0x00C0F700 and limit 0xFFFFFFFF
[OK]	GDT entry 13 has AR 0x00C0F700 and limit 0xFFFFFFFF
[OK]	LDT entry 0 has AR 0x00C0F500 and limit 0xFFFFFFFF
[OK]	GDT entry 13 has AR 0x00C0F500 and limit 0xFFFFFFFF
[OK]	LDT entry 0 is invalid
[RUN]	Cross-CPU LDT invalidation
[OK]	All 5 iterations succeeded
[RUN]	Test exec
[OK]	LDT entry 0 has AR 0x0040FB00 and limit 0x0000002A
[OK]	Child succeeded
[OK]	Invalidate DS with set_thread_area: new DS = 0x0
[OK]	Invalidate ES with set_thread_area: new ES = 0x0
[OK]	Invalidate FS with set_thread_area: new FS = 0x0
[OK]	Invalidate GS with set_thread_area: new GS = 0x0
ok 1..21 selftests: x86: ldt_gdt_32 [PASS]
selftests: x86: ptrace_syscall_32
========================================
[RUN]	Check int80 return regs
[OK]	getpid() preserves regs
[OK]	kill(getpid(), SIGUSR1) preserves regs
[RUN]	Check AT_SYSINFO return regs
[OK]	getpid() preserves regs
[OK]	kill(getpid(), SIGUSR1) preserves regs
[RUN]	ptrace-induced syscall restart
[RUN]	SYSEMU
[OK]	Initial nr and args are correct
[RUN]	Restart the syscall (ip = 0xf7f0b949)
[OK]	Restarted nr and args are correct
[RUN]	Change nr and args and restart the syscall (ip = 0xf7f0b949)
[OK]	Replacement nr and args are correct
[OK]	Child exited cleanly
[RUN]	kernel syscall restart under ptrace
[RUN]	SYSCALL
[OK]	Initial nr and args are correct
[RUN]	SYSCALL
[OK]	Args after SIGUSR1 are correct (ax = -514)
[OK]	Child got SIGUSR1
[RUN]	Step again
[OK]	pause(2) restarted correctly
ok 1..22 selftests: x86: ptrace_syscall_32 [PASS]
selftests: x86: single_step_syscall_64
========================================
[RUN]	Set TF and check nop
[OK]	Survived with TF set and 9 traps
[RUN]	Set TF and check syscall-less opportunistic sysret
[OK]	Survived with TF set and 12 traps
[RUN]	Set TF and check int80
[OK]	Survived with TF set and 9 traps
[RUN]	Set TF and check a fast syscall
[OK]	Survived with TF set and 22 traps
[RUN]	Fast syscall with TF cleared
[OK]	Nothing unexpected happened
ok 1..23 selftests: x86: single_step_syscall_64 [PASS]
selftests: x86: sysret_ss_attrs_64
========================================
[RUN]	Syscalls followed by SS validation
[OK]	We survived
ok 1..24 selftests: x86: sysret_ss_attrs_64 [PASS]
selftests: x86: syscall_nt_64
========================================
[RUN]	Set NT and issue a syscall
[OK]	The syscall worked and flags are still set
[RUN]	Set NT|TF and issue a syscall
[OK]	The syscall worked and flags are still set
ok 1..25 selftests: x86: syscall_nt_64 [PASS]
selftests: x86: test_mremap_vdso_64
========================================
	AT_SYSINFO_EHDR is 0x7ffe44b92000
[NOTE]	Moving vDSO: [0x7ffe44b92000, 0x7ffe44b93000] -> [0x7fb552928000, 0x7fb552929000]
[OK]
ok 1..26 selftests: x86: test_mremap_vdso_64 [PASS]
selftests: x86: check_initial_reg_state_64
========================================
[OK]	All GPRs except SP are 0
[OK]	FLAGS is 0x202
ok 1..27 selftests: x86: check_initial_reg_state_64 [PASS]
selftests: x86: sigreturn_64
========================================
[OK]	set_thread_area refused 16-bit data
[OK]	set_thread_area refused 16-bit data
[RUN]	Valid sigreturn: 64-bit CS (33), 32-bit SS (2b, GDT)
[OK]	all registers okay
[RUN]	Valid sigreturn: 32-bit CS (23), 32-bit SS (2b, GDT)
[NOTE]	SP: 8badf00d5aadc0de -> 5aadc0de
[OK]	all registers okay
[RUN]	Valid sigreturn: 16-bit CS (37), 32-bit SS (2b, GDT)
[NOTE]	SP: 8badf00d5aadc0de -> 5aadc0de
[OK]	all registers okay
[RUN]	Valid sigreturn: 64-bit CS (33), 16-bit SS (3f)
[OK]	all registers okay
[RUN]	Valid sigreturn: 32-bit CS (23), 16-bit SS (3f)
[NOTE]	SP: 8badf00d5aadc0de -> 5aadc0de
[OK]	all registers okay
[RUN]	Valid sigreturn: 16-bit CS (37), 16-bit SS (3f)
[NOTE]	SP: 8badf00d5aadc0de -> 5aadc0de
[OK]	all registers okay
[RUN]	Valid sigreturn: 32-bit CS (23), 32-bit SS (2b, GDT)
	Corrupting SS on return to 64-bit mode
[NOTE]	SP: 8badf00d5aadc0de -> 5aadc0de
[OK]	all registers okay
[RUN]	Valid sigreturn: 32-bit CS (23), 16-bit SS (3f)
	Corrupting SS on return to 64-bit mode
[NOTE]	SP: 8badf00d5aadc0de -> 5aadc0de
[OK]	all registers okay
[RUN]	64-bit CS (33), bogus SS (47)
[OK]	Got #GP(0x0) (i.e. Segmentation fault)
[RUN]	32-bit CS (23), bogus SS (47)
[OK]	Got #GP(0x0) (i.e. Segmentation fault)
[RUN]	16-bit CS (37), bogus SS (47)
[OK]	Got #GP(0x0) (i.e. Segmentation fault)
[RUN]	64-bit CS (33), bogus SS (33)
[OK]	Got #GP(0x30) (i.e. GDT index 6, Segmentation fault)
[RUN]	32-bit CS (23), bogus SS (33)
[OK]	Got #GP(0x30) (i.e. GDT index 6, Segmentation fault)
[RUN]	16-bit CS (37), bogus SS (33)
[OK]	Got #GP(0x30) (i.e. GDT index 6, Segmentation fault)
[RUN]	32-bit CS (4f), bogus SS (2b)
[OK]	Got #NP(0x4c) (i.e. LDT index 9, Bus error)
[RUN]	32-bit CS (23), bogus SS (57)
[OK]	Got #GP(0x0) (i.e. Segmentation fault)
[RUN]	Clear UC_STRICT_RESTORE_SS and corrupt SS
[OK]	It worked
ok 1..28 selftests: x86: sigreturn_64 [PASS]
selftests: x86: iopl_64
========================================
	child: set IOPL to 3
[RUN]	child: write to 0x80
[OK]	Child succeeded
[RUN]	parent: write to 0x80 (should fail)
[OK]	write was denied
	iopl(3)
	Drop privileges
[RUN]	iopl(3) unprivileged but with IOPL==3
[RUN]	iopl(0) unprivileged
[RUN]	iopl(3) unprivileged
[OK]	Failed as expected
ok 1..29 selftests: x86: iopl_64 [PASS]
selftests: x86: mpx-mini-test_64
========================================
processor lacks MPX XSTATE(s), can not run MPX tests
XSAVE is supported by HW & OS
XSAVE processor supported state mask: 0x7
XSAVE OS supported state mask: 0x7
ok 1..30 selftests: x86: mpx-mini-test_64 [PASS]
selftests: x86: ioperm_64
========================================
[OK]	outb to 0x80 failed
[OK]	outb to 0xed failed
[RUN]	enable 0x80
[OK]	outb to 0x80 worked
[OK]	outb to 0xed failed
[RUN]	disable 0x80
[OK]	outb to 0x80 failed
[OK]	outb to 0xed failed
[RUN]	child: check that we inherited permissions
[OK]	outb to 0x80 worked
[OK]	outb to 0xed failed
[OK]	outb to 0x80 failed
[OK]	outb to 0xed failed
[RUN]	enable 0x80
[OK]	outb to 0x80 worked
[OK]	outb to 0xed failed
[RUN]	disable 0x80
[OK]	outb to 0x80 failed
[OK]	outb to 0xed failed
[OK]	Child succeeded
	Drop privileges
[RUN]	disable 0x80
[OK]	it worked
[RUN]	enable 0x80 again
[OK]	it failed
ok 1..31 selftests: x86: ioperm_64 [PASS]
selftests: x86: protection_keys_64
========================================
has pku: 0
running PKEY tests for unsupported CPU/OS
ok 1..32 selftests: x86: protection_keys_64 [PASS]
selftests: x86: test_vdso_64
========================================
[RUN]	Testing clock_gettime for clock CLOCK_REALTIME (0)...
	1551252326.064454763 1551252326.064460618 1551252326.064461264
[RUN]	Testing clock_gettime for clock CLOCK_MONOTONIC (1)...
	633.452362833 633.452363285 633.452363750
[RUN]	Testing clock_gettime for clock CLOCK_PROCESS_CPUTIME_ID (2)...
	0.000703738 0.000705015 0.000705910
[RUN]	Testing clock_gettime for clock CLOCK_THREAD_CPUTIME_ID (3)...
	0.000708187 0.000709083 0.000709956
[RUN]	Testing clock_gettime for clock CLOCK_MONOTONIC_RAW (4)...
	633.044519105 633.044519915 633.044520670
[RUN]	Testing clock_gettime for clock CLOCK_REALTIME_COARSE (5)...
	1551252326.061853650 1551252326.061853650 1551252326.061853650
[RUN]	Testing clock_gettime for clock CLOCK_MONOTONIC_COARSE (6)...
	633.449752162 633.449752162 633.449752162
[RUN]	Testing clock_gettime for clock CLOCK_BOOTTIME (7)...
	633.452383428 633.452384219 633.452385002
[RUN]	Testing clock_gettime for clock CLOCK_REALTIME_ALARM (8)...
	1551252326.064488798 1551252326.064489620 1551252326.064490434
[RUN]	Testing clock_gettime for clock CLOCK_BOOTTIME_ALARM (9)...
	633.452390937 633.452391757 633.452392569
[RUN]	Testing clock_gettime for clock CLOCK_SGI_CYCLE (10)...
[OK]	No such clock.
[RUN]	Testing clock_gettime for clock CLOCK_TAI (11)...
	1551252326.064499465 1551252326.064499907 1551252326.064500337
[RUN]	Testing clock_gettime for clock invalid (-1)...
[OK]	No such clock.
[RUN]	Testing clock_gettime for clock invalid (-2147483648)...
[OK]	No such clock.
[RUN]	Testing clock_gettime for clock invalid (2147483647)...
[OK]	No such clock.
[RUN]	Testing gettimeofday...
	1551252326.064508 1551252326.064508 1551252326.064509
[OK]	timezones match: minuteswest=-480, dsttime=0
[RUN]	Testing getcpu...
[OK]	CPU 0: syscall: cpu 0, node 0 vdso: cpu 0, node 0 vsyscall: cpu 0, node 0
[OK]	CPU 1: syscall: cpu 1, node 0 vdso: cpu 1, node 0 vsyscall: cpu 1, node 0
ok 1..33 selftests: x86: test_vdso_64 [PASS]
selftests: x86: test_vsyscall_64
========================================
	vsyscall map: ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0                  [vsyscall]
	vsyscall permissions are r-x
[RUN]	test gettimeofday()
	vDSO time offsets: 0.000005 0.000002
[OK]	vDSO gettimeofday()'s timeval was okay
	vsyscall time offsets: 0.000006 0.000001
[OK]	vsyscall gettimeofday()'s timeval was okay
[RUN]	test time()
[OK]	vDSO time() is okay
[OK]	vsyscall time() is okay
[RUN]	getcpu() on CPU 0
[OK]	vDSO reported correct CPU
[OK]	vDSO reported correct node
[OK]	vsyscall reported correct CPU
[OK]	vsyscall reported correct node
[RUN]	getcpu() on CPU 1
[OK]	vDSO reported correct CPU
[OK]	vDSO reported correct node
[OK]	vsyscall reported correct CPU
[OK]	vsyscall reported correct node
[RUN]	Checking read access to the vsyscall page
[OK]	got expected result
[RUN]	checking that vsyscalls are emulated
[OK]	vsyscalls are emulated (1 instructions in vsyscall page)
ok 1..34 selftests: x86: test_vsyscall_64 [PASS]
selftests: x86: fsgsbase_64
========================================
[RUN]	ARCH_SET_GS to 0x0
[OK]	GSBASE was set as expected (selector 0x0)
[OK]	ARCH_GET_GS worked as expected (selector 0x0)
[RUN]	ARCH_SET_GS to 0x1
[OK]	GSBASE was set as expected (selector 0x0)
[OK]	ARCH_GET_GS worked as expected (selector 0x0)
[RUN]	ARCH_SET_GS to 0x200000000
[OK]	GSBASE was set as expected (selector 0x0)
[OK]	ARCH_GET_GS worked as expected (selector 0x0)
[RUN]	ARCH_SET_GS to 0x0
[OK]	GSBASE was set as expected (selector 0x0)
[OK]	ARCH_GET_GS worked as expected (selector 0x0)
[RUN]	ARCH_SET_GS to 0x200000000
[OK]	GSBASE was set as expected (selector 0x0)
[OK]	ARCH_GET_GS worked as expected (selector 0x0)
[RUN]	ARCH_SET_GS to 0x1
[OK]	GSBASE was set as expected (selector 0x0)
[OK]	ARCH_GET_GS worked as expected (selector 0x0)
[RUN]	ARCH_SET_GS to 0x0 then mov 0 to %gs
[OK]	GSBASE is 0x0
[RUN]	ARCH_SET_GS to 0x1 then mov 0 to %gs
[OK]	GSBASE is 0x0
[RUN]	ARCH_SET_GS to 0x200000000 then mov 0 to %gs
[OK]	GSBASE is 0x0
[RUN]	ARCH_SET_GS to 0x0 then mov 0 to %gs and schedule 
[OK]	GSBASE is 0x0
[RUN]	ARCH_SET_GS to 0x1 then mov 0 to %gs and schedule 
[OK]	GSBASE is 0x0
[RUN]	ARCH_SET_GS to 0x200000000 then mov 0 to %gs and schedule 
[OK]	GSBASE is 0x0
[RUN]	ARCH_SET_GS(0x0), then schedule to 0x0
	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
[OK]	GS/BASE remained 0x0/0x0
[RUN]	ARCH_SET_GS(0x0), then schedule to 0x0
	Before schedule, set selector to 0x1
	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
[OK]	GS/BASE remained 0x1/0x0
[RUN]	ARCH_SET_GS(0x0), then schedule to 0x0
	Before schedule, set selector to 0x2
	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
[OK]	GS/BASE remained 0x2/0x0
[RUN]	ARCH_SET_GS(0x0), then schedule to 0x0
	Before schedule, set selector to 0x3
	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
[OK]	GS/BASE remained 0x3/0x0
[RUN]	ARCH_SET_GS(0x0), then schedule to 0x0
	Before schedule, set selector to 0x2b
	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
[OK]	GS/BASE remained 0x2b/0x0
[RUN]	ARCH_SET_GS(0x0), then schedule to 0xa1fa5f343cb85fa4
	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
[OK]	GS/BASE remained 0x0/0x0
[RUN]	ARCH_SET_GS(0x0), then schedule to 0xa1fa5f343cb85fa4
	Before schedule, set selector to 0x1
	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
[OK]	GS/BASE remained 0x1/0x0
[RUN]	ARCH_SET_GS(0x0), then schedule to 0xa1fa5f343cb85fa4
	Before schedule, set selector to 0x2
	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
[OK]	GS/BASE remained 0x2/0x0
[RUN]	ARCH_SET_GS(0x0), then schedule to 0xa1fa5f343cb85fa4
	Before schedule, set selector to 0x3
	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
[OK]	GS/BASE remained 0x3/0x0
[RUN]	ARCH_SET_GS(0x0), then schedule to 0xa1fa5f343cb85fa4
	Before schedule, set selector to 0x2b
	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
[OK]	GS/BASE remained 0x2b/0x0
[RUN]	ARCH_SET_GS(0x0), then schedule to 0x1
	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
[OK]	GS/BASE remained 0x0/0x0
[RUN]	ARCH_SET_GS(0x0), then schedule to 0x1
	Before schedule, set selector to 0x1
	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
[OK]	GS/BASE remained 0x1/0x0
[RUN]	ARCH_SET_GS(0x0), then schedule to 0x1
	Before schedule, set selector to 0x2
	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
[OK]	GS/BASE remained 0x2/0x0
[RUN]	ARCH_SET_GS(0x0), then schedule to 0x1
	Before schedule, set selector to 0x3
	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
[OK]	GS/BASE remained 0x3/0x0
[RUN]	ARCH_SET_GS(0x0), then schedule to 0x1
	Before schedule, set selector to 0x2b
	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
[OK]	GS/BASE remained 0x2b/0x0
[RUN]	ARCH_SET_GS(0x0), then schedule to 0x200000000
	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
[OK]	GS/BASE remained 0x0/0x0
[RUN]	ARCH_SET_GS(0x0), then schedule to 0x200000000
	Before schedule, set selector to 0x1
	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
[OK]	GS/BASE remained 0x1/0x0
[RUN]	ARCH_SET_GS(0x0), then schedule to 0x200000000
	Before schedule, set selector to 0x2
	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
[OK]	GS/BASE remained 0x2/0x0
[RUN]	ARCH_SET_GS(0x0), then schedule to 0x200000000
	Before schedule, set selector to 0x3
	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
[OK]	GS/BASE remained 0x3/0x0
[RUN]	ARCH_SET_GS(0x0), then schedule to 0x200000000
	Before schedule, set selector to 0x2b
	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
[OK]	GS/BASE remained 0x2b/0x0
[RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x0
	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
[OK]	GS/BASE remained 0x0/0x0
[RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x0
	Before schedule, set selector to 0x1
	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
[OK]	GS/BASE remained 0x1/0x0
[RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x0
	Before schedule, set selector to 0x2
	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
[OK]	GS/BASE remained 0x2/0x0
[RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x0
	Before schedule, set selector to 0x3
	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
[OK]	GS/BASE remained 0x3/0x0
[RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x0
	Before schedule, set selector to 0x2b
	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
[OK]	GS/BASE remained 0x2b/0x0
[RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0xa1fa5f343cb85fa4
	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
[OK]	GS/BASE remained 0x0/0x0
[RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0xa1fa5f343cb85fa4
	Before schedule, set selector to 0x1
	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
[OK]	GS/BASE remained 0x1/0x0
[RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0xa1fa5f343cb85fa4
	Before schedule, set selector to 0x2
	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
[OK]	GS/BASE remained 0x2/0x0
[RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0xa1fa5f343cb85fa4
	Before schedule, set selector to 0x3
	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
[OK]	GS/BASE remained 0x3/0x0
[RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0xa1fa5f343cb85fa4
	Before schedule, set selector to 0x2b
	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
[OK]	GS/BASE remained 0x2b/0x0
[RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x1
	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
[OK]	GS/BASE remained 0x0/0x0
[RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x1
	Before schedule, set selector to 0x1
	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
[OK]	GS/BASE remained 0x1/0x0
[RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x1
	Before schedule, set selector to 0x2
	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
[OK]	GS/BASE remained 0x2/0x0
[RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x1
	Before schedule, set selector to 0x3
	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
[OK]	GS/BASE remained 0x3/0x0
[RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x1
	Before schedule, set selector to 0x2b
	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
[OK]	GS/BASE remained 0x2b/0x0
[RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x200000000
	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
[OK]	GS/BASE remained 0x0/0x0
[RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x200000000
	Before schedule, set selector to 0x1
	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
[OK]	GS/BASE remained 0x1/0x0
[RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x200000000
	Before schedule, set selector to 0x2
	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
[OK]	GS/BASE remained 0x2/0x0
[RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x200000000
	Before schedule, set selector to 0x3
	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
[OK]	GS/BASE remained 0x3/0x0
[RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x200000000
	Before schedule, set selector to 0x2b
	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
[OK]	GS/BASE remained 0x2b/0x0
[RUN]	ARCH_SET_GS(0x1), then schedule to 0x0
	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
[OK]	GS/BASE remained 0x0/0x1
[RUN]	ARCH_SET_GS(0x1), then schedule to 0x0
	Before schedule, set selector to 0x1
	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
[OK]	GS/BASE remained 0x1/0x0
[RUN]	ARCH_SET_GS(0x1), then schedule to 0x0
	Before schedule, set selector to 0x2
	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
[OK]	GS/BASE remained 0x2/0x0
[RUN]	ARCH_SET_GS(0x1), then schedule to 0x0
	Before schedule, set selector to 0x3
	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
[OK]	GS/BASE remained 0x3/0x0
[RUN]	ARCH_SET_GS(0x1), then schedule to 0x0
	Before schedule, set selector to 0x2b
	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
[OK]	GS/BASE remained 0x2b/0x0
[RUN]	ARCH_SET_GS(0x1), then schedule to 0xa1fa5f343cb85fa4
	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
[OK]	GS/BASE remained 0x0/0x1
[RUN]	ARCH_SET_GS(0x1), then schedule to 0xa1fa5f343cb85fa4
	Before schedule, set selector to 0x1
	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
[OK]	GS/BASE remained 0x1/0x0
[RUN]	ARCH_SET_GS(0x1), then schedule to 0xa1fa5f343cb85fa4
	Before schedule, set selector to 0x2
	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
[OK]	GS/BASE remained 0x2/0x0
[RUN]	ARCH_SET_GS(0x1), then schedule to 0xa1fa5f343cb85fa4
	Before schedule, set selector to 0x3
	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
[OK]	GS/BASE remained 0x3/0x0
[RUN]	ARCH_SET_GS(0x1), then schedule to 0xa1fa5f343cb85fa4
	Before schedule, set selector to 0x2b
	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
[OK]	GS/BASE remained 0x2b/0x0
[RUN]	ARCH_SET_GS(0x1), then schedule to 0x1
	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
[OK]	GS/BASE remained 0x0/0x1
[RUN]	ARCH_SET_GS(0x1), then schedule to 0x1
	Before schedule, set selector to 0x1
	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
[OK]	GS/BASE remained 0x1/0x0
[RUN]	ARCH_SET_GS(0x1), then schedule to 0x1
	Before schedule, set selector to 0x2
	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
[OK]	GS/BASE remained 0x2/0x0
[RUN]	ARCH_SET_GS(0x1), then schedule to 0x1
	Before schedule, set selector to 0x3
	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
[OK]	GS/BASE remained 0x3/0x0
[RUN]	ARCH_SET_GS(0x1), then schedule to 0x1
	Before schedule, set selector to 0x2b
	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
[OK]	GS/BASE remained 0x2b/0x0
[RUN]	ARCH_SET_GS(0x1), then schedule to 0x200000000
	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
[OK]	GS/BASE remained 0x0/0x1
[RUN]	ARCH_SET_GS(0x1), then schedule to 0x200000000
	Before schedule, set selector to 0x1
	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
[OK]	GS/BASE remained 0x1/0x0
[RUN]	ARCH_SET_GS(0x1), then schedule to 0x200000000
	Before schedule, set selector to 0x2
	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
[OK]	GS/BASE remained 0x2/0x0
[RUN]	ARCH_SET_GS(0x1), then schedule to 0x200000000
	Before schedule, set selector to 0x3
	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
[OK]	GS/BASE remained 0x3/0x0
[RUN]	ARCH_SET_GS(0x1), then schedule to 0x200000000
	Before schedule, set selector to 0x2b
	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
[OK]	GS/BASE remained 0x2b/0x0
[RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x0
	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
[OK]	GS/BASE remained 0x0/0x200000000
[RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x0
	Before schedule, set selector to 0x1
	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
[OK]	GS/BASE remained 0x1/0x0
[RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x0
	Before schedule, set selector to 0x2
	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
[OK]	GS/BASE remained 0x2/0x0
[RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x0
	Before schedule, set selector to 0x3
	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
[OK]	GS/BASE remained 0x3/0x0
[RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x0
	Before schedule, set selector to 0x2b
	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
[OK]	GS/BASE remained 0x2b/0x0
[RUN]	ARCH_SET_GS(0x200000000), then schedule to 0xa1fa5f343cb85fa4
	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
[OK]	GS/BASE remained 0x0/0x200000000
[RUN]	ARCH_SET_GS(0x200000000), then schedule to 0xa1fa5f343cb85fa4
	Before schedule, set selector to 0x1
	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
[OK]	GS/BASE remained 0x1/0x0
[RUN]	ARCH_SET_GS(0x200000000), then schedule to 0xa1fa5f343cb85fa4
	Before schedule, set selector to 0x2
	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
[OK]	GS/BASE remained 0x2/0x0
[RUN]	ARCH_SET_GS(0x200000000), then schedule to 0xa1fa5f343cb85fa4
	Before schedule, set selector to 0x3
	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
[OK]	GS/BASE remained 0x3/0x0
[RUN]	ARCH_SET_GS(0x200000000), then schedule to 0xa1fa5f343cb85fa4
	Before schedule, set selector to 0x2b
	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
[OK]	GS/BASE remained 0x2b/0x0
[RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x1
	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
[OK]	GS/BASE remained 0x0/0x200000000
[RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x1
	Before schedule, set selector to 0x1
	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
[OK]	GS/BASE remained 0x1/0x0
[RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x1
	Before schedule, set selector to 0x2
	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
[OK]	GS/BASE remained 0x2/0x0
[RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x1
	Before schedule, set selector to 0x3
	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
[OK]	GS/BASE remained 0x3/0x0
[RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x1
	Before schedule, set selector to 0x2b
	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
[OK]	GS/BASE remained 0x2b/0x0
[RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x200000000
	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
[OK]	GS/BASE remained 0x0/0x200000000
[RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x200000000
	Before schedule, set selector to 0x1
	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
[OK]	GS/BASE remained 0x1/0x0
[RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x200000000
	Before schedule, set selector to 0x2
	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
[OK]	GS/BASE remained 0x2/0x0
[RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x200000000
	Before schedule, set selector to 0x3
	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
[OK]	GS/BASE remained 0x3/0x0
[RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x200000000
	Before schedule, set selector to 0x2b
	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
[OK]	GS/BASE remained 0x2b/0x0
[RUN]	ARCH_SET_GS(0), clear gs, then manipulate GSBASE in a different thread
	other thread: using LDT slot 0
[OK]	GSBASE remained 0
ok 1..35 selftests: x86: fsgsbase_64 [PASS]
selftests: x86: sysret_rip_64
========================================
[RUN]	sigreturn to 0x800000000000
[OK]	Got SIGSEGV at RIP=0x800000000000
[RUN]	sigreturn to 0x1000000000000
[OK]	Got SIGSEGV at RIP=0x1000000000000
[RUN]	sigreturn to 0x2000000000000
[OK]	Got SIGSEGV at RIP=0x2000000000000
[RUN]	sigreturn to 0x4000000000000
[OK]	Got SIGSEGV at RIP=0x4000000000000
[RUN]	sigreturn to 0x8000000000000
[OK]	Got SIGSEGV at RIP=0x8000000000000
[RUN]	sigreturn to 0x10000000000000
[OK]	Got SIGSEGV at RIP=0x10000000000000
[RUN]	sigreturn to 0x20000000000000
[OK]	Got SIGSEGV at RIP=0x20000000000000
[RUN]	sigreturn to 0x40000000000000
[OK]	Got SIGSEGV at RIP=0x40000000000000
[RUN]	sigreturn to 0x80000000000000
[OK]	Got SIGSEGV at RIP=0x80000000000000
[RUN]	sigreturn to 0x100000000000000
[OK]	Got SIGSEGV at RIP=0x100000000000000
[RUN]	sigreturn to 0x200000000000000
[OK]	Got SIGSEGV at RIP=0x200000000000000
[RUN]	sigreturn to 0x400000000000000
[OK]	Got SIGSEGV at RIP=0x400000000000000
[RUN]	sigreturn to 0x800000000000000
[OK]	Got SIGSEGV at RIP=0x800000000000000
[RUN]	sigreturn to 0x1000000000000000
[OK]	Got SIGSEGV at RIP=0x1000000000000000
[RUN]	sigreturn to 0x2000000000000000
[OK]	Got SIGSEGV at RIP=0x2000000000000000
[RUN]	sigreturn to 0x4000000000000000
[OK]	Got SIGSEGV at RIP=0x4000000000000000
[RUN]	sigreturn to 0x8000000000000000
[OK]	Got SIGSEGV at RIP=0x8000000000000000
[RUN]	Trying a SYSCALL that falls through to 0x7fffffffe000
[OK]	We survived
[RUN]	Trying a SYSCALL that falls through to 0x7ffffffff000
[OK]	We survived
[RUN]	Trying a SYSCALL that falls through to 0x800000000000
[OK]	mremap to 0x7ffffffff000 failed
[RUN]	Trying a SYSCALL that falls through to 0xfffffffff000
[OK]	mremap to 0xffffffffe000 failed
[RUN]	Trying a SYSCALL that falls through to 0x1000000000000
[OK]	mremap to 0xfffffffff000 failed
[RUN]	Trying a SYSCALL that falls through to 0x1fffffffff000
[OK]	mremap to 0x1ffffffffe000 failed
[RUN]	Trying a SYSCALL that falls through to 0x2000000000000
[OK]	mremap to 0x1fffffffff000 failed
[RUN]	Trying a SYSCALL that falls through to 0x3fffffffff000
[OK]	mremap to 0x3ffffffffe000 failed
[RUN]	Trying a SYSCALL that falls through to 0x4000000000000
[OK]	mremap to 0x3fffffffff000 failed
[RUN]	Trying a SYSCALL that falls through to 0x7fffffffff000
[OK]	mremap to 0x7ffffffffe000 failed
[RUN]	Trying a SYSCALL that falls through to 0x8000000000000
[OK]	mremap to 0x7fffffffff000 failed
[RUN]	Trying a SYSCALL that falls through to 0xffffffffff000
[OK]	mremap to 0xfffffffffe000 failed
[RUN]	Trying a SYSCALL that falls through to 0x10000000000000
[OK]	mremap to 0xffffffffff000 failed
[RUN]	Trying a SYSCALL that falls through to 0x1ffffffffff000
[OK]	mremap to 0x1fffffffffe000 failed
[RUN]	Trying a SYSCALL that falls through to 0x20000000000000
[OK]	mremap to 0x1ffffffffff000 failed
[RUN]	Trying a SYSCALL that falls through to 0x3ffffffffff000
[OK]	mremap to 0x3fffffffffe000 failed
[RUN]	Trying a SYSCALL that falls through to 0x40000000000000
[OK]	mremap to 0x3ffffffffff000 failed
[RUN]	Trying a SYSCALL that falls through to 0x7ffffffffff000
[OK]	mremap to 0x7fffffffffe000 failed
[RUN]	Trying a SYSCALL that falls through to 0x80000000000000
[OK]	mremap to 0x7ffffffffff000 failed
[RUN]	Trying a SYSCALL that falls through to 0xfffffffffff000
[OK]	mremap to 0xffffffffffe000 failed
[RUN]	Trying a SYSCALL that falls through to 0x100000000000000
[OK]	mremap to 0xfffffffffff000 failed
[RUN]	Trying a SYSCALL that falls through to 0x1fffffffffff000
[OK]	mremap to 0x1ffffffffffe000 failed
[RUN]	Trying a SYSCALL that falls through to 0x200000000000000
[OK]	mremap to 0x1fffffffffff000 failed
[RUN]	Trying a SYSCALL that falls through to 0x3fffffffffff000
[OK]	mremap to 0x3ffffffffffe000 failed
[RUN]	Trying a SYSCALL that falls through to 0x400000000000000
[OK]	mremap to 0x3fffffffffff000 failed
[RUN]	Trying a SYSCALL that falls through to 0x7fffffffffff000
[OK]	mremap to 0x7ffffffffffe000 failed
[RUN]	Trying a SYSCALL that falls through to 0x800000000000000
[OK]	mremap to 0x7fffffffffff000 failed
[RUN]	Trying a SYSCALL that falls through to 0xffffffffffff000
[OK]	mremap to 0xfffffffffffe000 failed
[RUN]	Trying a SYSCALL that falls through to 0x1000000000000000
[OK]	mremap to 0xffffffffffff000 failed
[RUN]	Trying a SYSCALL that falls through to 0x1ffffffffffff000
[OK]	mremap to 0x1fffffffffffe000 failed
[RUN]	Trying a SYSCALL that falls through to 0x2000000000000000
[OK]	mremap to 0x1ffffffffffff000 failed
[RUN]	Trying a SYSCALL that falls through to 0x3ffffffffffff000
[OK]	mremap to 0x3fffffffffffe000 failed
[RUN]	Trying a SYSCALL that falls through to 0x4000000000000000
[OK]	mremap to 0x3ffffffffffff000 failed
[RUN]	Trying a SYSCALL that falls through to 0x7ffffffffffff000
[OK]	mremap to 0x7fffffffffffe000 failed
[RUN]	Trying a SYSCALL that falls through to 0x8000000000000000
[OK]	mremap to 0x7ffffffffffff000 failed
ok 1..36 selftests: x86: sysret_rip_64 [PASS]
selftests: x86: ldt_gdt_64
========================================
[NOTE]	set_thread_area is available; will use GDT index 12
[OK]	LDT entry 0 has AR 0x0040FB00 and limit 0x0000000A
[OK]	LDT entry 0 has AR 0x00C0FB00 and limit 0x0000AFFF
[OK]	LDT entry 1 is invalid
[OK]	LDT entry 2 has AR 0x00C0FB00 and limit 0x0000AFFF
[OK]	LDT entry 1 is invalid
[OK]	LDT entry 2 has AR 0x00C0FB00 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D0FB00 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D07B00 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00907B00 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D07300 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D07100 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D07500 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00507700 and limit 0x0000000A
[OK]	LDT entry 2 has AR 0x00507F00 and limit 0x0000000A
[OK]	LDT entry 2 has AR 0x00507D00 and limit 0x0000000A
[OK]	LDT entry 2 has AR 0x00507B00 and limit 0x0000000A
[OK]	LDT entry 2 has AR 0x00507900 and limit 0x0000000A
[OK]	LDT entry 2 has AR 0x00507900 and limit 0x0000000A
[RUN]	Test fork
[OK]	LDT entry 2 has AR 0x00507900 and limit 0x0000000A
[OK]	LDT entry 1 is invalid
[OK]	LDT entry 0 is invalid
[NOTE]	set_thread_area is available; will use GDT index 12
[OK]	LDT entry 0 has AR 0x0040FB00 and limit 0x0000000A
[OK]	LDT entry 0 has AR 0x00C0FB00 and limit 0x0000AFFF
[OK]	LDT entry 1 is invalid
[OK]	LDT entry 2 has AR 0x00C0FB00 and limit 0x0000AFFF
[OK]	LDT entry 1 is invalid
[OK]	LDT entry 2 has AR 0x00C0FB00 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D0FB00 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D07B00 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00907B00 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D07300 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D07100 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D07500 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00507700 and limit 0x0000000A
[OK]	LDT entry 2 has AR 0x00507F00 and limit 0x0000000A
[OK]	LDT entry 2 has AR 0x00507D00 and limit 0x0000000A
[OK]	LDT entry 2 has AR 0x00507B00 and limit 0x0000000A
[OK]	LDT entry 2 has AR 0x00507900 and limit 0x0000000A
[OK]	LDT entry 2 has AR 0x00507900 and limit 0x0000000A
[RUN]	Test fork
[OK]	Child succeeded
[RUN]	Test size
[DONE]	Size test
[OK]	modify_ldt failure 22
[OK]	LDT entry 0 has AR 0x0000F300 and limit 0x00000000
[OK]	LDT entry 0 has AR 0x00007300 and limit 0x00000000
[OK]	LDT entry 0 has AR 0x0000F100 and limit 0x00000000
[OK]	LDT entry 0 has AR 0x00007300 and limit 0x00000000
[OK]	LDT entry 0 has AR 0x00007100 and limit 0x00000001
[OK]	LDT entry 0 has AR 0x00007100 and limit 0x00000000
[OK]	LDT entry 0 is invalid
[OK]	LDT entry 0 has AR 0x0040F300 and limit 0x000FFFFF
[OK]	LDT entry 0 has AR 0x00C0F300 and limit 0xFFFFFFFF
[OK]	LDT entry 0 has AR 0x00C0F100 and limit 0xFFFFFFFF
[OK]	LDT entry 0 has AR 0x00C0F700 and limit 0xFFFFFFFF
[OK]	LDT entry 0 has AR 0x00C0F500 and limit 0xFFFFFFFF
[OK]	LDT entry 0 is invalid
[RUN]	Cross-CPU LDT invalidation
[OK]	All 5 iterations succeeded
[RUN]	Test exec
[OK]	LDT entry 0 has AR 0x0040FB00 and limit 0x0000002A
[OK]	Child succeeded
[OK]	Invalidate DS with set_thread_area: new DS = 0x0
[OK]	Invalidate ES with set_thread_area: new ES = 0x0
[OK]	Invalidate FS with set_thread_area: new FS = 0x0
[OK]	New FSBASE was zero
[OK]	Invalidate GS with set_thread_area: new GS = 0x0
[OK]	New GSBASE was zero
ok 1..37 selftests: x86: ldt_gdt_64 [PASS]
selftests: x86: ptrace_syscall_64
========================================
[RUN]	Check int80 return regs
[OK]	getpid() preserves regs
[OK]	kill(getpid(), SIGUSR1) preserves regs
[RUN]	ptrace-induced syscall restart
[RUN]	SYSEMU
[OK]	Initial nr and args are correct
[RUN]	Restart the syscall (ip = 0x7f395f0aa309)
[OK]	Restarted nr and args are correct
[RUN]	Change nr and args and restart the syscall (ip = 0x7f395f0aa309)
[OK]	Replacement nr and args are correct
[OK]	Child exited cleanly
[RUN]	kernel syscall restart under ptrace
[RUN]	SYSCALL
[OK]	Initial nr and args are correct
[RUN]	SYSCALL
[OK]	Args after SIGUSR1 are correct (ax = -514)
[OK]	Child got SIGUSR1
[RUN]	Step again
[OK]	pause(2) restarted correctly
ok 1..38 selftests: x86: ptrace_syscall_64 [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-6ea3dfe1e0732c5bd3be1e073690b06a83c03c25/tools/testing/selftests/x86'
ignored_by_lkp zram test

--4ZLFUWh1odzi/v6L--
