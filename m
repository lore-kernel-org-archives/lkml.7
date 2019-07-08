Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03642C48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972E720844
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbfGHJGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 05:06:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:23221 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727352AbfGHJGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 05:06:42 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jul 2019 02:06:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,466,1557212400"; 
   d="xz'?scan'208";a="159069263"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.6])
  by orsmga008.jf.intel.com with ESMTP; 08 Jul 2019 02:06:23 -0700
Date:   Mon, 8 Jul 2019 17:06:27 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Elvira Khabirova <lineprinter@altlinux.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greentime Hu <greentime@andestech.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        James Hogan <jhogan@kernel.org>,
        kbuild test robot <lkp@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Burton <paul.burton@mips.com>,
        Paul Mackerras <paulus@samba.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Richard Kuo <rkuo@codeaurora.org>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Chen <deanbo422@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org
Subject: [ptrace] cd5bbb3047: kernel_selftests.seccomp.seccomp_bpf.fail
Message-ID: <20190708090627.GO17490@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="i7KxW38SoMauyveo"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i7KxW38SoMauyveo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

FYI, we noticed the following commit (built with gcc-7):

commit: cd5bbb3047bf73353767d70a03db986600ca372a ("ptrace: add PTRACE_GET_SYSCALL_INFO request")
https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git master

in testcase: kernel_selftests
with following parameters:

	group: kselftests-02

test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
test-url: https://www.kernel.org/doc/Documentation/kselftest.txt


on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 8G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


If you fix the issue, kindly add following tag
Reported-by: kernel test robot <rong.a.chen@intel.com>



# selftests: seccomp: seccomp_bpf
# [==========] Running 74 tests from 1 test cases.
# [ RUN      ] global.mode_strict_support
# [       OK ] global.mode_strict_support
# [ RUN      ] global.mode_strict_cannot_call_prctl
# [       OK ] global.mode_strict_cannot_call_prctl
# [ RUN      ] global.no_new_privs_support
# [       OK ] global.no_new_privs_support
# [ RUN      ] global.mode_filter_support
# [       OK ] global.mode_filter_support
# [ RUN      ] global.mode_filter_without_nnp
# [       OK ] global.mode_filter_without_nnp
# [ RUN      ] global.filter_size_limits
# [       OK ] global.filter_size_limits
# [ RUN      ] global.filter_chain_limits
# [       OK ] global.filter_chain_limits
# [ RUN      ] global.mode_filter_cannot_move_to_strict
# [       OK ] global.mode_filter_cannot_move_to_strict
# [ RUN      ] global.mode_filter_get_seccomp
# [       OK ] global.mode_filter_get_seccomp
# [ RUN      ] global.ALLOW_all
# [       OK ] global.ALLOW_all
# [ RUN      ] global.empty_prog
# [       OK ] global.empty_prog
# [ RUN      ] global.log_all
# [       OK ] global.log_all
# [ RUN      ] global.unknown_ret_is_kill_inside
# [       OK ] global.unknown_ret_is_kill_inside
# [ RUN      ] global.unknown_ret_is_kill_above_allow
# [       OK ] global.unknown_ret_is_kill_above_allow
# [ RUN      ] global.KILL_all
# [       OK ] global.KILL_all
# [ RUN      ] global.KILL_one
# [       OK ] global.KILL_one
# [ RUN      ] global.KILL_one_arg_one
# [       OK ] global.KILL_one_arg_one
# [ RUN      ] global.KILL_one_arg_six
# [       OK ] global.KILL_one_arg_six
# [ RUN      ] global.KILL_thread
# seccomp_bpf.c:1781:TRACE_syscall.ptrace_syscall_redirected:Expected 0 (0) == msg (1)
# seccomp_bpf.c:1781:TRACE_syscall.ptrace_syscall_redirected:Expected 0 (0) == msg (2)
# seccomp_bpf.c:1781:TRACE_syscall.ptrace_syscall_redirected:Expected 0 (0) == msg (1)
# seccomp_bpf.c:1781:TRACE_syscall.ptrace_syscall_redirected:Expected 0 (0) == msg (2)
# seccomp_bpf.c:1781:TRACE_syscall.ptrace_syscall_redirected:Expected 0 (0) == msg (1)
# seccomp_bpf.c:1781:TRACE_syscall.ptrace_syscall_redirected:Expected 0 (0) == msg (2)
# seccomp_bpf.c:1781:TRACE_syscall.ptrace_syscall_redirected:Expected 0 (0) == msg (1)
# TRACE_syscall.ptrace_syscall_redirected: Test failed at step #15
# seccomp_bpf.c:1781:TRACE_syscall.ptrace_syscall_errno:Expected 0 (0) == msg (1)
# seccomp_bpf.c:1781:TRACE_syscall.ptrace_syscall_errno:Expected 0 (0) == msg (2)
# seccomp_bpf.c:1781:TRACE_syscall.ptrace_syscall_errno:Expected 0 (0) == msg (1)
# seccomp_bpf.c:1781:TRACE_syscall.ptrace_syscall_errno:Expected 0 (0) == msg (2)
# seccomp_bpf.c:1781:TRACE_syscall.ptrace_syscall_errno:Expected 0 (0) == msg (1)
# seccomp_bpf.c:1781:TRACE_syscall.ptrace_syscall_errno:Expected 0 (0) == msg (2)
# seccomp_bpf.c:1781:TRACE_syscall.ptrace_syscall_errno:Expected 0 (0) == msg (1)
# TRACE_syscall.ptrace_syscall_errno: Test failed at step #15
# seccomp_bpf.c:1781:TRACE_syscall.ptrace_syscall_faked:Expected 0 (0) == msg (1)
# seccomp_bpf.c:1781:TRACE_syscall.ptrace_syscall_faked:Expected 0 (0) == msg (2)
# seccomp_bpf.c:1781:TRACE_syscall.ptrace_syscall_faked:Expected 0 (0) == msg (1)
# seccomp_bpf.c:1781:TRACE_syscall.ptrace_syscall_faked:Expected 0 (0) == msg (2)
# seccomp_bpf.c:1781:TRACE_syscall.ptrace_syscall_faked:Expected 0 (0) == msg (1)
# seccomp_bpf.c:1781:TRACE_syscall.ptrace_syscall_faked:Expected 0 (0) == msg (2)
# seccomp_bpf.c:1781:TRACE_syscall.ptrace_syscall_faked:Expected 0 (0) == msg (1)
# TRACE_syscall.ptrace_syscall_faked: Test failed at step #15
# [==========] Running 74 tests from 1 test cases.
# [ RUN      ] global.mode_strict_support
# [       OK ] global.mode_strict_support
# [ RUN      ] global.mode_strict_cannot_call_prctl
# [       OK ] global.mode_strict_cannot_call_prctl
# [ RUN      ] global.no_new_privs_support
# [       OK ] global.no_new_privs_support
# [ RUN      ] global.mode_filter_support
# [       OK ] global.mode_filter_support
# [ RUN      ] global.mode_filter_without_nnp
# [       OK ] global.mode_filter_without_nnp
# [ RUN      ] global.filter_size_limits
# [       OK ] global.filter_size_limits
# [ RUN      ] global.filter_chain_limits
# [       OK ] global.filter_chain_limits
# [ RUN      ] global.mode_filter_cannot_move_to_strict
# [       OK ] global.mode_filter_cannot_move_to_strict
# [ RUN      ] global.mode_filter_get_seccomp
# [       OK ] global.mode_filter_get_seccomp
# [ RUN      ] global.ALLOW_all
# [       OK ] global.ALLOW_all
# [ RUN      ] global.empty_prog
# [       OK ] global.empty_prog
# [ RUN      ] global.log_all
# [       OK ] global.log_all
# [ RUN      ] global.unknown_ret_is_kill_inside
# [       OK ] global.unknown_ret_is_kill_inside
# [ RUN      ] global.unknown_ret_is_kill_above_allow
# [       OK ] global.unknown_ret_is_kill_above_allow
# [ RUN      ] global.KILL_all
# [       OK ] global.KILL_all
# [ RUN      ] global.KILL_one
# [       OK ] global.KILL_one
# [ RUN      ] global.KILL_one_arg_one
# [       OK ] global.KILL_one_arg_one
# [ RUN      ] global.KILL_one_arg_six
# [       OK ] global.KILL_one_arg_six
# [ RUN      ] global.KILL_thread
# [       OK ] global.KILL_thread
# [ RUN      ] global.KILL_process
# [       OK ] global.KILL_process
# [ RUN      ] global.arg_out_of_range
# [       OK ] global.arg_out_of_range
# [ RUN      ] global.ERRNO_valid
# [       OK ] global.ERRNO_valid
# [ RUN      ] global.ERRNO_zero
# [       OK ] global.ERRNO_zero
# [ RUN      ] global.ERRNO_capped
# [       OK ] global.ERRNO_capped
# [ RUN      ] global.ERRNO_order
# [       OK ] global.ERRNO_order
# [ RUN      ] TRAP.dfl
# [       OK ] TRAP.dfl
# [ RUN      ] TRAP.ign
# [       OK ] TRAP.ign
# [ RUN      ] TRAP.handler
# [       OK ] TRAP.handler
# [ RUN      ] precedence.allow_ok
# [       OK ] precedence.allow_ok
# [ RUN      ] precedence.kill_is_highest
# [       OK ] precedence.kill_is_highest
# [ RUN      ] precedence.kill_is_highest_in_any_order
# [       OK ] precedence.kill_is_highest_in_any_order
# [ RUN      ] precedence.trap_is_second
# [       OK ] precedence.trap_is_second
# [ RUN      ] precedence.trap_is_second_in_any_order
# [       OK ] precedence.trap_is_second_in_any_order
# [ RUN      ] precedence.errno_is_third
# [       OK ] precedence.errno_is_third
# [ RUN      ] precedence.errno_is_third_in_any_order
# [       OK ] precedence.errno_is_third_in_any_order
# [ RUN      ] precedence.trace_is_fourth
# [       OK ] precedence.trace_is_fourth
# [ RUN      ] precedence.trace_is_fourth_in_any_order
# [       OK ] precedence.trace_is_fourth_in_any_order
# [ RUN      ] precedence.log_is_fifth
# [       OK ] precedence.log_is_fifth
# [ RUN      ] precedence.log_is_fifth_in_any_order
# [       OK ] precedence.log_is_fifth_in_any_order
# [ RUN      ] TRACE_poke.read_has_side_effects
# [       OK ] TRACE_poke.read_has_side_effects
# [ RUN      ] TRACE_poke.getpid_runs_normally
# [       OK ] TRACE_poke.getpid_runs_normally
# [ RUN      ] TRACE_syscall.ptrace_syscall_redirected
# [     FAIL ] TRACE_syscall.ptrace_syscall_redirected
# [ RUN      ] TRACE_syscall.ptrace_syscall_errno
# [     FAIL ] TRACE_syscall.ptrace_syscall_errno
# [ RUN      ] TRACE_syscall.ptrace_syscall_faked
# [     FAIL ] TRACE_syscall.ptrace_syscall_faked
# [ RUN      ] TRACE_syscall.syscall_allowed
# [       OK ] TRACE_syscall.syscall_allowed
# [ RUN      ] TRACE_syscall.syscall_redirected
# [       OK ] TRACE_syscall.syscall_redirected
# [ RUN      ] TRACE_syscall.syscall_errno
# [       OK ] TRACE_syscall.syscall_errno
# [ RUN      ] TRACE_syscall.syscall_faked
# [       OK ] TRACE_syscall.syscall_faked
# [ RUN      ] TRACE_syscall.skip_after_RET_TRACE
# [       OK ] TRACE_syscall.skip_after_RET_TRACE
# [ RUN      ] TRACE_syscall.kill_after_RET_TRACE
# [       OK ] TRACE_syscall.kill_after_RET_TRACE
# [ RUN      ] TRACE_syscall.skip_aseccomp_bpf.c:1781:TRACE_syscall.skip_after_ptrace:Expected 0 (0) == msg (1)
# seccomp_bpf.c:1781:TRACE_syscall.skip_after_ptrace:Expected 0 (0) == msg (2)
# seccomp_bpf.c:1781:TRACE_syscall.skip_after_ptrace:Expected 0 (0) == msg (1)
# seccomp_bpf.c:1781:TRACE_syscall.skip_after_ptrace:Expected 0 (0) == msg (2)
# seccomp_bpf.c:1781:TRACE_syscall.skip_after_ptrace:Expected 0 (0) == msg (1)
# seccomp_bpf.c:1781:TRACE_syscall.skip_after_ptrace:Expected 0 (0) == msg (2)
# seccomp_bpf.c:1781:TRACE_syscall.skip_after_ptrace:Expected 0 (0) == msg (1)
# seccomp_bpf.c:1781:TRACE_syscall.skip_after_ptrace:Expected 0 (0) == msg (2)
# seccomp_bpf.c:1781:TRACE_syscall.skip_after_ptrace:Expected 0 (0) == msg (1)
# seccomp_bpf.c:1781:TRACE_syscall.skip_after_ptrace:Expected 0 (0) == msg (2)
# seccomp_bpf.c:1781:TRACE_syscall.skip_after_ptrace:Expected 0 (0) == msg (1)
# TRACE_syscall.skip_after_ptrace: Test failed at step #17
# seccomp_bpf.c:1781:TRACE_syscall.kill_after_ptrace:Expected 0 (0) == msg (1)
# seccomp_bpf.c:1781:TRACE_syscall.kill_after_ptrace:Expected 0 (0) == msg (2)
# seccomp_bpf.c:1781:TRACE_syscall.kill_after_ptrace:Expected 0 (0) == msg (1)
# seccomp_bpf.c:1781:TRACE_syscall.kill_after_ptrace:Expected 0 (0) == msg (2)
# seccomp_bpf.c:1781:TRACE_syscall.kill_after_ptrace:Expected 0 (0) == msg (1)
# seccomp_bpf.c:1781:TRACE_syscall.kill_after_ptrace:Expected 0 (0) == msg (2)
# seccomp_bpf.c:1781:TRACE_syscall.kill_after_ptrace:Expected 0 (0) == msg (1)
# seccomp_bpf.c:1781:TRACE_syscall.kill_after_ptrace:Expected 0 (0) == msg (2)
# seccomp_bpf.c:1781:TRACE_syscall.kill_after_ptrace:Expected 0 (0) == msg (1)
# fter_ptrace
# [     FAIL ] TRACE_syscall.skip_after_ptrace
# [ RUN      ] TRACE_syscall.kill_after_ptrace
# [       OK ] TRACE_syscall.kill_after_ptrace
# [ RUN      ] global.seccomp_syscall
# [       OK ] global.seccomp_syscall
# [ RUN      ] global.seccomp_syscall_mode_lock
# [       OK ] global.seccomp_syscall_mode_lock
# [ RUN      ] global.detect_seccomp_filter_flags
# [       OK ] global.detect_seccomp_filter_flags
# [ RUN      ] global.TSYNC_first
# [       OK ] global.TSYNC_first
# [ RUN      ] TSYNC.siblings_fail_prctl
# [       OK ] TSYNC.siblings_fail_prctl
# [ RUN      ] TSYNC.two_siblings_with_ancestor
# [       OK ] TSYNC.two_siblings_with_ancestor
# [ RUN      ] TSYNC.two_sibling_want_nnp
# [       OK ] TSYNC.two_sibling_want_nnp
# [ RUN      ] TSYNC.two_siblings_with_no_filter
# [       OK ] TSYNC.two_siblings_with_no_filter
# [ RUN      ] TSYNC.two_siblings_with_one_divergence
# [       OK ] TSYNC.two_siblings_with_one_divergence
# [ RUN      ] TSYNC.two_siblings_not_under_filter
# [       OK ] TSYNC.two_siblings_not_under_filter
# [ RUN      ] global.syscall_restart
# [       OK ] global.syscall_restart
# [ RUN      ] global.filter_flag_log
# [       OK ] global.filter_flag_log
# [ RUN      ] global.get_action_avail
# [       OK ] global.get_action_avail
# [ RUN      ] global.get_metadata
# [       OK ] global.get_metadata
# [ RUN      ] global.user_notification_basic
# fter_ptrace
# [     FAIL ] TRACE_syscall.skip_after_ptrace
# [ RUN      ] TRACE_syscall.kill_after_ptrace
# [       OK ] TRACE_syscall.kill_after_ptrace
# [ RUN      ] global.seccomp_syscall
# [       OK ] global.seccomp_syscall
# [ RUN      ] global.seccomp_syscall_mode_lock
# [       OK ] global.seccomp_syscall_mode_lock
# [ RUN      ] global.detect_seccomp_filter_flags
# [       OK ] global.detect_seccomp_filter_flags
# [ RUN      ] global.TSYNC_first
# [       OK ] global.TSYNC_first
# [ RUN      ] TSYNC.siblings_fail_prctl
# [       OK ] TSYNC.siblings_fail_prctl
# [ RUN      ] TSYNC.two_siblings_with_ancestor
# [       OK ] TSYNC.two_siblings_with_ancestor
# [ RUN      ] TSYNC.two_sibling_want_nnp
# [       OK ] TSYNC.two_sibling_want_nnp
# [ RUN      ] TSYNC.two_siblings_with_no_filter
# [       OK ] TSYNC.two_siblings_with_no_filter
# [ RUN      ] TSYNC.two_siblings_with_one_divergence
# [       OK ] TSYNC.two_siblings_with_one_divergence
# [ RUN      ] TSYNC.two_siblings_not_under_filter
# [       OK ] TSYNC.two_siblings_not_under_filter
# [ RUN      ] global.syscall_restart
# [       OK ] global.syscall_restart
# [ RUN      ] global.filter_flag_log
# [       OK ] global.filter_flag_log
# [ RUN      ] global.get_action_avail
# [       OK ] global.get_action_avail
# [ RUN      ] global.get_metadata
# [       OK ] global.get_metadata
# [ RUN      ] global.user_notification_basic
# fter_ptrace
# [     FAIL ] TRACE_syscall.skip_after_ptrace
# [ RUN      ] TRACE_syscall.kill_after_ptrace
# [       OK ] TRACE_syscall.kill_after_ptrace
# [ RUN      ] global.seccomp_syscall
# [       OK ] global.seccomp_syscall
# [ RUN      ] global.seccomp_syscall_mode_lock
# [       OK ] global.seccomp_syscall_mode_lock
# [ RUN      ] global.detect_seccomp_filter_flags
# [       OK ] global.detect_seccomp_filter_flags
# [ RUN      ] global.TSYNC_first
# [       OK ] global.TSYNC_first
# [ RUN      ] TSYNC.siblings_fail_prctl
# [       OK ] TSYNC.siblings_fail_prctl
# [ RUN      ] TSYNC.two_siblings_with_ancestor
# [       OK ] TSYNC.two_siblings_with_ancestor
# [ RUN      ] TSYNC.two_sibling_want_nnp
# [       OK ] TSYNC.two_sibling_want_nnp
# [ RUN      ] TSYNC.two_siblings_with_no_filter
# [       OK ] TSYNC.two_siblings_with_no_filter
# [ RUN      ] TSYNC.two_siblings_with_one_divergence
# [       OK ] TSYNC.two_siblings_with_one_divergence
# [ RUN      ] TSYNC.two_siblings_not_under_filter
# [       OK ] TSYNC.two_siblings_not_under_filter
# [ RUN      ] global.syscall_restart
# [       OK ] global.syscall_restart
# [ RUN      ] global.filter_flag_log
# [       OK ] global.filter_flag_log
# [ RUN      ] global.get_action_avail
# [       OK ] global.get_action_avail
# [ RUN      ] global.get_metadata
# [       OK ] global.get_metadata
# [ RUN      ] global.user_notification_basic
# [       OK ] global.user_notification_basic
# [ RUN      ] global.user_notification_kill_in_middle
# [       OK ] global.user_notification_kill_in_middle
# [ RUN      ] global.user_notification_signal
# fter_ptrace
# [     FAIL ] TRACE_syscall.skip_after_ptrace
# [ RUN      ] TRACE_syscall.kill_after_ptrace
# [       OK ] TRACE_syscall.kill_after_ptrace
# [ RUN      ] global.seccomp_syscall
# [       OK ] global.seccomp_syscall
# [ RUN      ] global.seccomp_syscall_mode_lock
# [       OK ] global.seccomp_syscall_mode_lock
# [ RUN      ] global.detect_seccomp_filter_flags
# [       OK ] global.detect_seccomp_filter_flags
# [ RUN      ] global.TSYNC_first
# [       OK ] global.TSYNC_first
# [ RUN      ] TSYNC.siblings_fail_prctl
# [       OK ] TSYNC.siblings_fail_prctl
# [ RUN      ] TSYNC.two_siblings_with_ancestor
# [       OK ] TSYNC.two_siblings_with_ancestor
# [ RUN      ] TSYNC.two_sibling_want_nnp
# [       OK ] TSYNC.two_sibling_want_nnp
# [ RUN      ] TSYNC.two_siblings_with_no_filter
# [       OK ] TSYNC.two_siblings_with_no_filter
# [ RUN      ] TSYNC.two_siblings_with_one_divergence
# [       OK ] TSYNC.two_siblings_with_one_divergence
# [ RUN      ] TSYNC.two_siblings_not_under_filter
# [       OK ] TSYNC.two_siblings_not_under_filter
# [ RUN      ] global.syscall_restart
# [       OK ] global.syscall_restart
# [ RUN      ] global.filter_flag_log
# [       OK ] global.filter_flag_log
# [ RUN      ] global.get_action_avail
# [       OK ] global.get_action_avail
# [ RUN      ] global.get_metadata
# [       OK ] global.get_metadata
# [ RUN      ] global.user_notification_basic
# [       OK ] global.user_notification_basic
# [ RUN      ] global.user_notification_kill_in_middle
# [       OK ] global.user_notification_kill_in_middle
# [ RUN      ] global.user_notification_signal
# [       OK ] global.user_notification_signal
# [ RUN      ] global.user_notification_closed_listener
# fter_ptrace
# [     FAIL ] TRACE_syscall.skip_after_ptrace
# [ RUN      ] TRACE_syscall.kill_after_ptrace
# [       OK ] TRACE_syscall.kill_after_ptrace
# [ RUN      ] global.seccomp_syscall
# [       OK ] global.seccomp_syscall
# [ RUN      ] global.seccomp_syscall_mode_lock
# [       OK ] global.seccomp_syscall_mode_lock
# [ RUN      ] global.detect_seccomp_filter_flags
# [       OK ] global.detect_seccomp_filter_flags
# [ RUN      ] global.TSYNC_first
# [       OK ] global.TSYNC_first
# [ RUN      ] TSYNC.siblings_fail_prctl
# [       OK ] TSYNC.siblings_fail_prctl
# [ RUN      ] TSYNC.two_siblings_with_ancestor
# [       OK ] TSYNC.two_siblings_with_ancestor
# [ RUN      ] TSYNC.two_sibling_want_nnp
# [       OK ] TSYNC.two_sibling_want_nnp
# [ RUN      ] TSYNC.two_siblings_with_no_filter
# [       OK ] TSYNC.two_siblings_with_no_filter
# [ RUN      ] TSYNC.two_siblings_with_one_divergence
# [       OK ] TSYNC.two_siblings_with_one_divergence
# [ RUN      ] TSYNC.two_siblings_not_under_filter
# [       OK ] TSYNC.two_siblings_not_under_filter
# [ RUN      ] global.syscall_restart
# [       OK ] global.syscall_restart
# [ RUN      ] global.filter_flag_log
# [       OK ] global.filter_flag_log
# [ RUN      ] global.get_action_avail
# [       OK ] global.get_action_avail
# [ RUN      ] global.get_metadata
# [       OK ] global.get_metadata
# [ RUN      ] global.user_notification_basic
# [       OK ] global.user_notification_basic
# [ RUN      ] global.user_notification_kill_in_middle
# [       OK ] global.user_notification_kill_in_middle
# [ RUN      ] global.user_notification_signal
# [       OK ] global.user_notification_signal
# [ RUN      ] global.user_notification_closed_listener
# [       OK ] global.user_notification_closed_listener
# [ RUN      ] global.user_notification_child_pid_ns
# fter_ptrace
# [     FAIL ] TRACE_syscall.skip_after_ptrace
# [ RUN      ] TRACE_syscall.kill_after_ptrace
# [       OK ] TRACE_syscall.kill_after_ptrace
# [ RUN      ] global.seccomp_syscall
# [       OK ] global.seccomp_syscall
# [ RUN      ] global.seccomp_syscall_mode_lock
# [       OK ] global.seccomp_syscall_mode_lock
# [ RUN      ] global.detect_seccomp_filter_flags
# [       OK ] global.detect_seccomp_filter_flags
# [ RUN      ] global.TSYNC_first
# [       OK ] global.TSYNC_first
# [ RUN      ] TSYNC.siblings_fail_prctl
# [       OK ] TSYNC.siblings_fail_prctl
# [ RUN      ] TSYNC.two_siblings_with_ancestor
# [       OK ] TSYNC.two_siblings_with_ancestor
# [ RUN      ] TSYNC.two_sibling_want_nnp
# [       OK ] TSYNC.two_sibling_want_nnp
# [ RUN      ] TSYNC.two_siblings_with_no_filter
# [       OK ] TSYNC.two_siblings_with_no_filter
# [ RUN      ] TSYNC.two_siblings_with_one_divergence
# [       OK ] TSYNC.two_siblings_with_one_divergence
# [ RUN      ] TSYNC.two_siblings_not_under_filter
# [       OK ] TSYNC.two_siblings_not_under_filter
# [ RUN      ] global.syscall_restart
# [       OK ] global.syscall_restart
# [ RUN      ] global.filter_flag_log
# [       OK ] global.filter_flag_log
# [ RUN      ] global.get_action_avail
# [       OK ] global.get_action_avail
# [ RUN      ] global.get_metadata
# [       OK ] global.get_metadata
# [ RUN      ] global.user_notification_basic
# [       OK ] global.user_notification_basic
# [ RUN      ] global.user_notification_kill_in_middle
# [       OK ] global.user_notification_kill_in_middle
# [ RUN      ] global.user_notification_signal
# [       OK ] global.user_notification_signal
# [ RUN      ] global.user_notification_closed_listener
# [       OK ] global.user_notification_closed_listener
# [ RUN      ] global.user_notification_child_pid_ns
# [       OK ] global.user_notification_child_pid_ns
# [ RUN      ] global.user_notification_sibling_pid_ns
# fter_ptrace
# [     FAIL ] TRACE_syscall.skip_after_ptrace
# [ RUN      ] TRACE_syscall.kill_after_ptrace
# [       OK ] TRACE_syscall.kill_after_ptrace
# [ RUN      ] global.seccomp_syscall
# [       OK ] global.seccomp_syscall
# [ RUN      ] global.seccomp_syscall_mode_lock
# [       OK ] global.seccomp_syscall_mode_lock
# [ RUN      ] global.detect_seccomp_filter_flags
# [       OK ] global.detect_seccomp_filter_flags
# [ RUN      ] global.TSYNC_first
# [       OK ] global.TSYNC_first
# [ RUN      ] TSYNC.siblings_fail_prctl
# [       OK ] TSYNC.siblings_fail_prctl
# [ RUN      ] TSYNC.two_siblings_with_ancestor
# [       OK ] TSYNC.two_siblings_with_ancestor
# [ RUN      ] TSYNC.two_sibling_want_nnp
# [       OK ] TSYNC.two_sibling_want_nnp
# [ RUN      ] TSYNC.two_siblings_with_no_filter
# [       OK ] TSYNC.two_siblings_with_no_filter
# [ RUN      ] TSYNC.two_siblings_with_one_divergence
# [       OK ] TSYNC.two_siblings_with_one_divergence
# [ RUN      ] TSYNC.two_siblings_not_under_filter
# [       OK ] TSYNC.two_siblings_not_under_filter
# [ RUN      ] global.syscall_restart
# [       OK ] global.syscall_restart
# [ RUN      ] global.filter_flag_log
# [       OK ] global.filter_flag_log
# [ RUN      ] global.get_action_avail
# [       OK ] global.get_action_avail
# [ RUN      ] global.get_metadata
# [       OK ] global.get_metadata
# [ RUN      ] global.user_notification_basic
# [       OK ] global.user_notification_basic
# [ RUN      ] global.user_notification_kill_in_middle
# [       OK ] global.user_notification_kill_in_middle
# [ RUN      ] global.user_notification_signal
# [       OK ] global.user_notification_signal
# [ RUN      ] global.user_notification_closed_listener
# [       OK ] global.user_notification_closed_listener
# [ RUN      ] global.user_notification_child_pid_ns
# [       OK ] global.user_notification_child_pid_ns
# [ RUN      ] global.user_notification_sibling_pid_ns
# fter_ptrace
# [     FAIL ] TRACE_syscall.skip_after_ptrace
# [ RUN      ] TRACE_syscall.kill_after_ptrace
# [       OK ] TRACE_syscall.kill_after_ptrace
# [ RUN      ] global.seccomp_syscall
# [       OK ] global.seccomp_syscall
# [ RUN      ] global.seccomp_syscall_mode_lock
# [       OK ] global.seccomp_syscall_mode_lock
# [ RUN      ] global.detect_seccomp_filter_flags
# [       OK ] global.detect_seccomp_filter_flags
# [ RUN      ] global.TSYNC_first
# [       OK ] global.TSYNC_first
# [ RUN      ] TSYNC.siblings_fail_prctl
# [       OK ] TSYNC.siblings_fail_prctl
# [ RUN      ] TSYNC.two_siblings_with_ancestor
# [       OK ] TSYNC.two_siblings_with_ancestor
# [ RUN      ] TSYNC.two_sibling_want_nnp
# [       OK ] TSYNC.two_sibling_want_nnp
# [ RUN      ] TSYNC.two_siblings_with_no_filter
# [       OK ] TSYNC.two_siblings_with_no_filter
# [ RUN      ] TSYNC.two_siblings_with_one_divergence
# [       OK ] TSYNC.two_siblings_with_one_divergence
# [ RUN      ] TSYNC.two_siblings_not_under_filter
# [       OK ] TSYNC.two_siblings_not_under_filter
# [ RUN      ] global.syscall_restart
# [       OK ] global.syscall_restart
# [ RUN      ] global.filter_flag_log
# [       OK ] global.filter_flag_log
# [ RUN      ] global.get_action_avail
# [       OK ] global.get_action_avail
# [ RUN      ] global.get_metadata
# [       OK ] global.get_metadata
# [ RUN      ] global.user_notification_basic
# [       OK ] global.user_notification_basic
# [ RUN      ] global.user_notification_kill_in_middle
# [       OK ] global.user_notification_kill_in_middle
# [ RUN      ] global.user_notification_signal
# [       OK ] global.user_notification_signal
# [ RUN      ] global.user_notification_closed_listener
# [       OK ] global.user_notification_closed_listener
# [ RUN      ] global.user_notification_child_pid_ns
# [       OK ] global.user_notification_child_pid_ns
# [ RUN      ] global.user_notification_sibling_pid_ns
# fter_ptrace
# [     FAIL ] TRACE_syscall.skip_after_ptrace
# [ RUN      ] TRACE_syscall.kill_after_ptrace
# [       OK ] TRACE_syscall.kill_after_ptrace
# [ RUN      ] global.seccomp_syscall
# [       OK ] global.seccomp_syscall
# [ RUN      ] global.seccomp_syscall_mode_lock
# [       OK ] global.seccomp_syscall_mode_lock
# [ RUN      ] global.detect_seccomp_filter_flags
# [       OK ] global.detect_seccomp_filter_flags
# [ RUN      ] global.TSYNC_first
# [       OK ] global.TSYNC_first
# [ RUN      ] TSYNC.siblings_fail_prctl
# [       OK ] TSYNC.siblings_fail_prctl
# [ RUN      ] TSYNC.two_siblings_with_ancestor
# [       OK ] TSYNC.two_siblings_with_ancestor
# [ RUN      ] TSYNC.two_sibling_want_nnp
# [       OK ] TSYNC.two_sibling_want_nnp
# [ RUN      ] TSYNC.two_siblings_with_no_filter
# [       OK ] TSYNC.two_siblings_with_no_filter
# [ RUN      ] TSYNC.two_siblings_with_one_divergence
# [       OK ] TSYNC.two_siblings_with_one_divergence
# [ RUN      ] TSYNC.two_siblings_not_under_filter
# [       OK ] TSYNC.two_siblings_not_under_filter
# [ RUN      ] global.syscall_restart
# [       OK ] global.syscall_restart
# [ RUN      ] global.filter_flag_log
# [       OK ] global.filter_flag_log
# [ RUN      ] global.get_action_avail
# [       OK ] global.get_action_avail
# [ RUN      ] global.get_metadata
# [       OK ] global.get_metadata
# [ RUN      ] global.user_notification_basic
# [       OK ] global.user_notification_basic
# [ RUN      ] global.user_notification_kill_in_middle
# [       OK ] global.user_notification_kill_in_middle
# [ RUN      ] global.user_notification_signal
# [       OK ] global.user_notification_signal
# [ RUN      ] global.user_notification_closed_listener
# [       OK ] global.user_notification_closed_listener
# [ RUN      ] global.user_notification_child_pid_ns
# [       OK ] global.user_notification_child_pid_ns
# [ RUN      ] global.user_notification_sibling_pid_ns
# [       OK ] global.user_notification_sibling_pid_ns
# [ RUN      ] global.user_notification_fault_recv
# fter_ptrace
# [     FAIL ] TRACE_syscall.skip_after_ptrace
# [ RUN      ] TRACE_syscall.kill_after_ptrace
# [       OK ] TRACE_syscall.kill_after_ptrace
# [ RUN      ] global.seccomp_syscall
# [       OK ] global.seccomp_syscall
# [ RUN      ] global.seccomp_syscall_mode_lock
# [       OK ] global.seccomp_syscall_mode_lock
# [ RUN      ] global.detect_seccomp_filter_flags
# [       OK ] global.detect_seccomp_filter_flags
# [ RUN      ] global.TSYNC_first
# [       OK ] global.TSYNC_first
# [ RUN      ] TSYNC.siblings_fail_prctl
# [       OK ] TSYNC.siblings_fail_prctl
# [ RUN      ] TSYNC.two_siblings_with_ancestor
# [       OK ] TSYNC.two_siblings_with_ancestor
# [ RUN      ] TSYNC.two_sibling_want_nnp
# [       OK ] TSYNC.two_sibling_want_nnp
# [ RUN      ] TSYNC.two_siblings_with_no_filter
# [       OK ] TSYNC.two_siblings_with_no_filter
# [ RUN      ] TSYNC.two_siblings_with_one_divergence
# [       OK ] TSYNC.two_siblings_with_one_divergence
# [ RUN      ] TSYNC.two_siblings_not_under_filter
# [       OK ] TSYNC.two_siblings_not_under_filter
# [ RUN      ] global.syscall_restart
# [       OK ] global.syscall_restart
# [ RUN      ] global.filter_flag_log
# [       OK ] global.filter_flag_log
# [ RUN      ] global.get_action_avail
# [       OK ] global.get_action_avail
# [ RUN      ] global.get_metadata
# [       OK ] global.get_metadata
# [ RUN      ] global.user_notification_basic
# [       OK ] global.user_notification_basic
# [ RUN      ] global.user_notification_kill_in_middle
# [       OK ] global.user_notification_kill_in_middle
# [ RUN      ] global.user_notification_signal
# [       OK ] global.user_notification_signal
# [ RUN      ] global.user_notification_closed_listener
# [       OK ] global.user_notification_closed_listener
# [ RUN      ] global.user_notification_child_pid_ns
# [       OK ] global.user_notification_child_pid_ns
# [ RUN      ] global.user_notification_sibling_pid_ns
# [       OK ] global.user_notification_sibling_pid_ns
# [ RUN      ] global.user_notification_fault_recv
# [       OK ] global.user_notification_fault_recv
# [ RUN      ] global.seccomp_get_notif_sizes
# [       OK ] global.seccomp_get_notif_sizes
# [==========] 70 / 74 tests passed.
# [  FAILED  ]
not ok 1 selftests: seccomp: seccomp_bpf




To reproduce:

        # build kernel
	cd linux
	cp config-5.2.0-rc4-00289-gcd5bbb3047bf7 .config
	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email



Thanks,
Rong Chen


--i7KxW38SoMauyveo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.2.0-rc4-00289-gcd5bbb3047bf7"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.2.0-rc4 Kernel Configuration
#

#
# Compiler: gcc-7 (Debian 7.4.0-6) 7.4.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=70400
CONFIG_CLANG_VERSION=0
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_WARN_MAYBE_UNINITIALIZED=y
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
# end of IRQ subsystem

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
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

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
# end of CPU/Task time and stats accounting

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
CONFIG_RCU_NOCB_CPU=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
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
CONFIG_CGROUP_CPUACCT=y
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
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT_ALWAYS_ON=y
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
# end of Kernel Performance Events And Counters

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
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

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
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
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
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
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
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_XXL=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_XEN=y
CONFIG_XEN_PV=y
CONFIG_XEN_PV_SMP=y
# CONFIG_XEN_DOM0 is not set
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
# end of Performance monitoring

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
CONFIG_AMD_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
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
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
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
CONFIG_EFI_MIXED=y
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
CONFIG_KEXEC_VERIFY_SIG=y
CONFIG_KEXEC_BZIMAGE_VERIFY_SIG=y
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

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
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
CONFIG_PM_TRACE=y
CONFIG_PM_TRACE_RTC=y
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
# CONFIG_ACPI_DEBUG is not set
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
# CONFIG_ACPI_HMAT is not set
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
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

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
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

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
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
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
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_EFI_EARLYCON=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

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
CONFIG_KVM_AMD_SEV=y
CONFIG_KVM_MMU_AUDIT=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
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
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
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
CONFIG_64BIT_TIME=y
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
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y

#
# GCC plugins
#
# CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# CONFIG_GCC_PLUGIN_RANDSTRUCT is not set
# end of GCC plugins
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
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
# end of Partition Types

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
# end of IO Schedulers

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
# end of Executable file formats

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
CONFIG_CONTIG_ALLOC=y
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
CONFIG_MEM_SOFT_DIRTY=y
CONFIG_ZSWAP=y
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
# CONFIG_PGTABLE_MAPPING is not set
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DEVICE=y
CONFIG_ARCH_HAS_HMM_MIRROR=y
CONFIG_ARCH_HAS_HMM=y
CONFIG_MIGRATE_VMA_HELPER=y
CONFIG_DEV_PAGEMAP_OPS=y
CONFIG_HMM=y
CONFIG_HMM_MIRROR=y
# CONFIG_DEVICE_PRIVATE is not set
# CONFIG_DEVICE_PUBLIC is not set
CONFIG_FRAME_VECTOR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# end of Memory Management options

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
CONFIG_UNIX_SCM=y
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
CONFIG_TCP_CONG_DCTCP=m
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
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
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
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
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
CONFIG_NF_CT_NETLINK_TIMEOUT=m
# CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
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
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
# CONFIG_NFT_TUNNEL is not set
# CONFIG_NFT_OBJREF is not set
CONFIG_NFT_QUEUE=m
# CONFIG_NFT_QUOTA is not set
CONFIG_NFT_REJECT=m
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
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
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
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
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
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
CONFIG_NETFILTER_XT_MATCH_TIME=m
CONFIG_NETFILTER_XT_MATCH_U32=m
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
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
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
# CONFIG_NF_TABLES_IPV4 is not set
# CONFIG_NF_TABLES_ARP is not set
CONFIG_NF_DUP_IPV4=m
# CONFIG_NF_LOG_ARP is not set
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
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
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
# CONFIG_NF_TABLES_IPV6 is not set
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
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
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

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
# end of DCCP CCIDs Configuration

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# end of DCCP Kernel Hacking

CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
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
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
CONFIG_6LOWPAN_NHC=m
CONFIG_6LOWPAN_NHC_DEST=m
CONFIG_6LOWPAN_NHC_FRAGMENT=m
CONFIG_6LOWPAN_NHC_HOP=m
CONFIG_6LOWPAN_NHC_IPV6=m
CONFIG_6LOWPAN_NHC_MOBILITY=m
CONFIG_6LOWPAN_NHC_ROUTING=m
CONFIG_6LOWPAN_NHC_UDP=m
# CONFIG_6LOWPAN_GHC_EXT_HDR_HOP is not set
# CONFIG_6LOWPAN_GHC_UDP is not set
# CONFIG_6LOWPAN_GHC_ICMPV6 is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_DEST is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
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
CONFIG_NET_SCH_FQ=m
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
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
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
CONFIG_NET_ACT_SAMPLE=m
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
CONFIG_NET_ACT_VLAN=m
# CONFIG_NET_ACT_BPF is not set
CONFIG_NET_ACT_CONNMARK=m
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
CONFIG_NET_CLS_IND=y
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_OPENVSWITCH_GENEVE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
# CONFIG_MPLS_ROUTING is not set
CONFIG_NET_NSH=m
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
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
# end of Network testing
# end of Networking options

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
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=m
CONFIG_CAN_EMS_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PLX_PCI=m
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
CONFIG_CAN_8DEV_USB=m
CONFIG_CAN_EMS_USB=m
CONFIG_CAN_ESD_USB2=m
# CONFIG_CAN_GS_USB is not set
CONFIG_CAN_KVASER_USB=m
# CONFIG_CAN_MCBA_USB is not set
CONFIG_CAN_PEAK_USB=m
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

CONFIG_BT=m
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_CMTP=m
CONFIG_BT_HIDP=m
CONFIG_BT_HS=y
CONFIG_BT_LE=y
# CONFIG_BT_6LOWPAN is not set
# CONFIG_BT_LEDS is not set
# CONFIG_BT_SELFTEST is not set
CONFIG_BT_DEBUGFS=y

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=m
CONFIG_BT_BCM=m
CONFIG_BT_RTL=m
CONFIG_BT_HCIBTUSB=m
# CONFIG_BT_HCIBTUSB_AUTOSUSPEND is not set
CONFIG_BT_HCIBTUSB_BCM=y
CONFIG_BT_HCIBTUSB_RTL=y
CONFIG_BT_HCIBTSDIO=m
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
# CONFIG_BT_HCIUART_INTEL is not set
# CONFIG_BT_HCIUART_AG6XX is not set
# CONFIG_BT_HCIUART_MRVL is not set
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
CONFIG_BT_MRVL_SDIO=m
CONFIG_BT_ATH3K=m
# CONFIG_BT_MTKSDIO is not set
# end of Bluetooth device drivers

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
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_FAILOVER=m
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
# CONFIG_PCIE_BW is not set
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
CONFIG_PCI_HYPERV=m
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support

CONFIG_VMD=y

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

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
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
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
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# end of Bus devices

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
# end of Partition parsers

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
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
# CONFIG_MTD_PLATRAM is not set
# end of Mapping drivers for chip access

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
# end of Self-contained MTD device drivers

# CONFIG_MTD_ONENAND is not set
# CONFIG_MTD_RAW_NAND is not set
# CONFIG_MTD_SPI_NAND is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
# end of LPDDR & LPDDR2 PCM memory drivers

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
CONFIG_VIRTIO_BLK=y
# CONFIG_VIRTIO_BLK_SCSI is not set
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_FABRICS=m
CONFIG_NVME_FC=m
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

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
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_HDCP is not set
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
# end of Intel MIC & related support

# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# end of Misc devices

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
# end of SCSI Transports

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
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA_FC=m
CONFIG_TCM_QLA2XXX=m
# CONFIG_TCM_QLA2XXX_DEBUG is not set
CONFIG_SCSI_QLA_ISCSI=m
# CONFIG_QEDI is not set
# CONFIG_QEDF is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
CONFIG_SCSI_PMCRAID=m
CONFIG_SCSI_PM8001=m
# CONFIG_SCSI_BFA_FC is not set
CONFIG_SCSI_VIRTIO=m
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

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
CONFIG_DM_ERA=m
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
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
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_TCM_FC=m
CONFIG_ISCSI_TARGET=m
CONFIG_ISCSI_TARGET_CXGB4=m
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
# end of IEEE 1394 (FireWire) support

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
CONFIG_GENEVE=m
# CONFIG_GTP is not set
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_NTB_NETDEV=m
CONFIG_TUN=m
CONFIG_TAP=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
CONFIG_NLMON=m
CONFIG_NET_VRF=y
CONFIG_VSOCKMON=m
# CONFIG_ARCNET is not set
# CONFIG_ATM_DRIVERS is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

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
CONFIG_ENA_ETHERNET=m
CONFIG_NET_VENDOR_AMD=y
CONFIG_AMD8111_ETH=m
CONFIG_PCNET32=m
CONFIG_AMD_XGBE=m
# CONFIG_AMD_XGBE_DCB is not set
CONFIG_AMD_XGBE_HAVE_ECC=y
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_AQTION=m
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
CONFIG_ATL2=m
CONFIG_ATL1=m
CONFIG_ATL1E=m
CONFIG_ATL1C=m
CONFIG_ALX=m
CONFIG_NET_VENDOR_AURORA=y
# CONFIG_AURORA_NB8800 is not set
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
CONFIG_BNX2X=m
CONFIG_BNX2X_SRIOV=y
# CONFIG_SYSTEMPORT is not set
CONFIG_BNXT=m
CONFIG_BNXT_SRIOV=y
CONFIG_BNXT_FLOWER_OFFLOAD=y
CONFIG_BNXT_DCB=y
CONFIG_BNXT_HWMON=y
CONFIG_NET_VENDOR_BROCADE=y
CONFIG_BNA=m
CONFIG_NET_VENDOR_CADENCE=y
CONFIG_MACB=m
CONFIG_MACB_USE_HWSTAMP=y
# CONFIG_MACB_PCI is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
CONFIG_LIQUIDIO=m
CONFIG_LIQUIDIO_VF=m
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
CONFIG_IXGB=y
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
CONFIG_IXGBE_DCB=y
CONFIG_IXGBEVF=m
CONFIG_I40E=y
CONFIG_I40E_DCB=y
CONFIG_IAVF=m
CONFIG_I40EVF=m
# CONFIG_ICE is not set
CONFIG_FM10K=m
# CONFIG_IGC is not set
CONFIG_JME=m
CONFIG_NET_VENDOR_MARVELL=y
CONFIG_MVMDIO=m
CONFIG_SKGE=y
# CONFIG_SKGE_DEBUG is not set
CONFIG_SKGE_GENESIS=y
CONFIG_SKY2=m
# CONFIG_SKY2_DEBUG is not set
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
# CONFIG_NET_VENDOR_MICROCHIP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
# CONFIG_MSCC_OCELOT_SWITCH is not set
CONFIG_NET_VENDOR_MYRI=y
CONFIG_MYRI10GE=m
CONFIG_MYRI10GE_DCA=y
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NFP=m
CONFIG_NFP_APP_FLOWER=y
CONFIG_NFP_APP_ABM_NIC=y
# CONFIG_NFP_DEBUG is not set
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
CONFIG_QED=m
CONFIG_QED_SRIOV=y
CONFIG_QEDE=m
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
# CONFIG_NET_VENDOR_RDC is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
CONFIG_8139CP=y
CONFIG_8139TOO=y
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
CONFIG_8139TOO_8129=y
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_ROCKER=m
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
# CONFIG_NET_VENDOR_SEEQ is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
CONFIG_SFC=m
CONFIG_SFC_MTD=y
CONFIG_SFC_MCDI_MON=y
CONFIG_SFC_SRIOV=y
CONFIG_SFC_MCDI_LOGGING=y
CONFIG_SFC_FALCON=m
CONFIG_SFC_FALCON_MTD=y
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
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
CONFIG_TLAN=m
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_LL_TEMAC is not set
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
CONFIG_USB_NET_HUAWEI_CDC_NCM=m
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
CONFIG_ATH_COMMON=m
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_ATH9K_HW=m
CONFIG_ATH9K_COMMON=m
CONFIG_ATH9K_BTCOEX_SUPPORT=y
# CONFIG_ATH9K is not set
CONFIG_ATH9K_HTC=m
# CONFIG_ATH9K_HTC_DEBUGFS is not set
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
CONFIG_IWLEGACY=m
CONFIG_IWL4965=m
CONFIG_IWL3945=m

#
# iwl3945 / iwl4965 Debugging Options
#
CONFIG_IWLEGACY_DEBUG=y
CONFIG_IWLEGACY_DEBUGFS=y
# end of iwl3945 / iwl4965 Debugging Options

CONFIG_IWLWIFI=m
CONFIG_IWLWIFI_LEDS=y
CONFIG_IWLDVM=m
CONFIG_IWLMVM=m
CONFIG_IWLWIFI_OPMODE_MODULAR=y
# CONFIG_IWLWIFI_BCAST_FILTERING is not set
# CONFIG_IWLWIFI_PCIE_RTPM is not set

#
# Debugging Options
#
# CONFIG_IWLWIFI_DEBUG is not set
CONFIG_IWLWIFI_DEBUGFS=y
# CONFIG_IWLWIFI_DEVICE_TRACING is not set
# end of Debugging Options

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
# CONFIG_MT7603E is not set
# CONFIG_MT7615E is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
# CONFIG_RTL_CARDS is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
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
CONFIG_VMXNET3=m
CONFIG_FUJITSU_ES=m
CONFIG_THUNDERBOLT_NET=m
CONFIG_HYPERV_NET=m
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=m
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
# end of ISDN feature submodules

#
# ISDN4Linux hardware drivers
#

#
# Passive cards
#
CONFIG_ISDN_DRV_HISAX=m

#
# D-channel protocol features
#
CONFIG_HISAX_EURO=y
CONFIG_DE_AOC=y
CONFIG_HISAX_NO_SENDCOMPLETE=y
CONFIG_HISAX_NO_LLC=y
CONFIG_HISAX_NO_KEYPAD=y
CONFIG_HISAX_1TR6=y
CONFIG_HISAX_NI1=y
CONFIG_HISAX_MAX_CARDS=8

#
# HiSax supported cards
#
CONFIG_HISAX_16_3=y
CONFIG_HISAX_TELESPCI=y
CONFIG_HISAX_S0BOX=y
CONFIG_HISAX_FRITZPCI=y
CONFIG_HISAX_AVM_A1_PCMCIA=y
CONFIG_HISAX_ELSA=y
CONFIG_HISAX_DIEHLDIVA=y
CONFIG_HISAX_SEDLBAUER=y
CONFIG_HISAX_NETJET=y
CONFIG_HISAX_NETJET_U=y
CONFIG_HISAX_NICCY=y
CONFIG_HISAX_BKM_A4T=y
CONFIG_HISAX_SCT_QUADRO=y
CONFIG_HISAX_GAZEL=y
CONFIG_HISAX_HFC_PCI=y
CONFIG_HISAX_W6692=y
CONFIG_HISAX_HFC_SX=y
CONFIG_HISAX_ENTERNOW_PCI=y
# CONFIG_HISAX_DEBUG is not set

#
# HiSax PCMCIA card service modules
#

#
# HiSax sub driver modules
#
CONFIG_HISAX_ST5481=m
# CONFIG_HISAX_HFCUSB is not set
CONFIG_HISAX_HFC4S8S=m
CONFIG_HISAX_FRITZ_PCIPNP=m
# end of Passive cards

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
CONFIG_NVM=y
# CONFIG_NVM_PBLK is not set

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
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
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
CONFIG_MOUSE_PS2_VMMOUSE=y
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
# CONFIG_TOUCHSCREEN_ADC is not set
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
CONFIG_TOUCHSCREEN_ELO=m
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
# CONFIG_TOUCHSCREEN_IQS5XX is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
# CONFIG_INPUT_MSM_VIBRATOR is not set
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_MMA8450 is not set
CONFIG_INPUT_APANEL=m
CONFIG_INPUT_GP2A=m
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_GPIO_VIBRA is not set
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
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_CMA3000 is not set
CONFIG_INPUT_XEN_KBDDEV_FRONTEND=m
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_RMI4_CORE=m
# CONFIG_RMI4_I2C is not set
# CONFIG_RMI4_SPI is not set
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F54 is not set
# CONFIG_RMI4_F55 is not set

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
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

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
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK=m
CONFIG_SYNCLINKMP=m
CONFIG_SYNCLINK_GT=m
CONFIG_NOZOMI=m
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
# CONFIG_TRACE_SINK is not set
# CONFIG_NULL_TTY is not set
CONFIG_LDISC_AUTOLOAD=y
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
# end of Serial drivers

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
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_NVRAM=y
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
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_XEN is not set
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set
# end of Character devices

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
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
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
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
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
# CONFIG_I2C_DESIGNWARE_PCI is not set
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
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

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
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
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
CONFIG_PTP_1588_CLOCK_KVM=m
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=m
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
CONFIG_PINCTRL_INTEL=m
# CONFIG_PINCTRL_BROXTON is not set
CONFIG_PINCTRL_CANNONLAKE=m
# CONFIG_PINCTRL_CEDARFORK is not set
CONFIG_PINCTRL_DENVERTON=m
CONFIG_PINCTRL_GEMINILAKE=m
# CONFIG_PINCTRL_ICELAKE is not set
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_SUNRISEPOINT=m
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=m
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_LYNXPOINT is not set
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=m
# end of USB GPIO expanders

CONFIG_GPIO_MOCKUP=y
# CONFIG_W1 is not set
# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
# CONFIG_GENERIC_ADC_BATTERY is not set
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
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_BQ2415X is not set
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
# CONFIG_SENSORS_IIO_HWMON is not set
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
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
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_ISL68137 is not set
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
CONFIG_SENSORS_SHT15=m
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
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
# CONFIG_INT3406_THERMAL is not set
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_GENERIC_ADC_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

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
CONFIG_INTEL_MEI_WDT=m
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
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
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
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
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
CONFIG_MFD_SM501_GPIO=y
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
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
# CONFIG_IR_IMON_DECODER is not set
# CONFIG_IR_RCMM_DECODER is not set
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
CONFIG_MEDIA_CONTROLLER=y
CONFIG_MEDIA_CONTROLLER_DVB=y
CONFIG_VIDEO_DEV=m
# CONFIG_VIDEO_V4L2_SUBDEV_API is not set
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
# CONFIG_VIDEO_FB_IVTV_FORCE_PAT is not set
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
# end of Texas Instruments WL128x FM driver (ST based)

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
# Lens drivers
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
# Media SPI Adapters
#
# CONFIG_CXD2880_SPI_DRV is not set
# end of Media SPI Adapters

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
CONFIG_DRM_DP_AUX_CHARDEV=y
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#
# end of ACP (Audio CoProcessor) Configuration

# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
# CONFIG_DRM_I915_ALPHA_SUPPORT is not set
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y
CONFIG_DRM_I915_GVT_KVMGT=m

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
# end of drm/i915 Debugging

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
CONFIG_DRM_BOCHS=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
# CONFIG_DRM_HISI_HIBMC is not set
# CONFIG_DRM_TINYDRM is not set
# CONFIG_DRM_XEN is not set
# CONFIG_DRM_VBOXVIDEO is not set
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
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
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
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

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
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

CONFIG_SOUND=m
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_PCM_ELD=y
CONFIG_SND_HWDEP=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_COMPRESS_OFFLOAD=m
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
CONFIG_SND_HDA_RECONFIG=y
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=0
CONFIG_SND_HDA_PATCH_LOADER=y
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
# end of HD-Audio

CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_EXT_CORE=m
CONFIG_SND_HDA_PREALLOC_SIZE=512
# CONFIG_SND_SPI is not set
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=m
CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER=y
CONFIG_SND_USB_UA101=m
CONFIG_SND_USB_USX2Y=m
CONFIG_SND_USB_CAIAQ=m
CONFIG_SND_USB_CAIAQ_INPUT=y
CONFIG_SND_USB_US122L=m
CONFIG_SND_USB_6FIRE=m
CONFIG_SND_USB_HIFACE=m
CONFIG_SND_BCD2000=m
CONFIG_SND_USB_LINE6=m
CONFIG_SND_USB_POD=m
CONFIG_SND_USB_PODHD=m
CONFIG_SND_USB_TONEPORT=m
CONFIG_SND_USB_VARIAX=m
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
CONFIG_SND_SOC=m
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
CONFIG_SND_SOC_ACPI=m
# CONFIG_SND_SOC_AMD_ACP is not set
# CONFIG_SND_SOC_AMD_ACP3x is not set
# CONFIG_SND_ATMEL_SOC is not set
# CONFIG_SND_DESIGNWARE_I2S is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
# CONFIG_SND_SOC_FSL_SAI is not set
# CONFIG_SND_SOC_FSL_AUDMIX is not set
# CONFIG_SND_SOC_FSL_SSI is not set
# CONFIG_SND_SOC_FSL_SPDIF is not set
# CONFIG_SND_SOC_FSL_ESAI is not set
# CONFIG_SND_SOC_FSL_MICFIL is not set
# CONFIG_SND_SOC_IMX_AUDMUX is not set
# end of SoC Audio for Freescale CPUs

# CONFIG_SND_I2S_HI6210_I2S is not set
# CONFIG_SND_SOC_IMG is not set
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SST_IPC=m
CONFIG_SND_SST_IPC_ACPI=m
CONFIG_SND_SOC_INTEL_SST_ACPI=m
CONFIG_SND_SOC_INTEL_SST=m
CONFIG_SND_SOC_INTEL_SST_FIRMWARE=m
CONFIG_SND_SOC_INTEL_HASWELL=m
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=m
# CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=m
CONFIG_SND_SOC_INTEL_SKYLAKE=m
CONFIG_SND_SOC_INTEL_SKL=m
CONFIG_SND_SOC_INTEL_APL=m
CONFIG_SND_SOC_INTEL_KBL=m
CONFIG_SND_SOC_INTEL_GLK=m
CONFIG_SND_SOC_INTEL_CNL=m
CONFIG_SND_SOC_INTEL_CFL=m
CONFIG_SND_SOC_INTEL_SKYLAKE_FAMILY=m
CONFIG_SND_SOC_INTEL_SKYLAKE_SSP_CLK=m
# CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC is not set
CONFIG_SND_SOC_INTEL_SKYLAKE_COMMON=m
CONFIG_SND_SOC_ACPI_INTEL_MATCH=m
CONFIG_SND_SOC_INTEL_MACH=y
CONFIG_SND_SOC_INTEL_HASWELL_MACH=m
CONFIG_SND_SOC_INTEL_BDW_RT5677_MACH=m
CONFIG_SND_SOC_INTEL_BROADWELL_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH=m
# CONFIG_SND_SOC_INTEL_CHT_BSW_NAU8824_MACH is not set
CONFIG_SND_SOC_INTEL_BYT_CHT_DA7213_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_ES8316_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH=m
CONFIG_SND_SOC_INTEL_SKL_RT286_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_BXT_RT298_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH=m
# CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_RT5660_MACH is not set
# CONFIG_SND_SOC_INTEL_GLK_RT5682_MAX98357A_MACH is not set
# CONFIG_SND_SOC_MTK_BTCVSD is not set
# CONFIG_SND_SOC_SOF_TOPLEVEL is not set

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

# CONFIG_SND_SOC_XILINX_I2S is not set
# CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
# CONFIG_SND_SOC_XILINX_SPDIF is not set
# CONFIG_SND_SOC_XTFPGA_I2S is not set
# CONFIG_ZX_TDM is not set
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
# CONFIG_SND_SOC_AC97_CODEC is not set
# CONFIG_SND_SOC_ADAU1701 is not set
# CONFIG_SND_SOC_ADAU1761_I2C is not set
# CONFIG_SND_SOC_ADAU1761_SPI is not set
# CONFIG_SND_SOC_ADAU7002 is not set
# CONFIG_SND_SOC_AK4104 is not set
# CONFIG_SND_SOC_AK4118 is not set
# CONFIG_SND_SOC_AK4458 is not set
# CONFIG_SND_SOC_AK4554 is not set
# CONFIG_SND_SOC_AK4613 is not set
# CONFIG_SND_SOC_AK4642 is not set
# CONFIG_SND_SOC_AK5386 is not set
# CONFIG_SND_SOC_AK5558 is not set
# CONFIG_SND_SOC_ALC5623 is not set
# CONFIG_SND_SOC_BD28623 is not set
# CONFIG_SND_SOC_BT_SCO is not set
# CONFIG_SND_SOC_CS35L32 is not set
# CONFIG_SND_SOC_CS35L33 is not set
# CONFIG_SND_SOC_CS35L34 is not set
# CONFIG_SND_SOC_CS35L35 is not set
# CONFIG_SND_SOC_CS35L36 is not set
# CONFIG_SND_SOC_CS42L42 is not set
# CONFIG_SND_SOC_CS42L51_I2C is not set
# CONFIG_SND_SOC_CS42L52 is not set
# CONFIG_SND_SOC_CS42L56 is not set
# CONFIG_SND_SOC_CS42L73 is not set
# CONFIG_SND_SOC_CS4265 is not set
# CONFIG_SND_SOC_CS4270 is not set
# CONFIG_SND_SOC_CS4271_I2C is not set
# CONFIG_SND_SOC_CS4271_SPI is not set
# CONFIG_SND_SOC_CS42XX8_I2C is not set
# CONFIG_SND_SOC_CS43130 is not set
# CONFIG_SND_SOC_CS4341 is not set
# CONFIG_SND_SOC_CS4349 is not set
# CONFIG_SND_SOC_CS53L30 is not set
CONFIG_SND_SOC_DA7213=m
CONFIG_SND_SOC_DA7219=m
CONFIG_SND_SOC_DMIC=m
# CONFIG_SND_SOC_ES7134 is not set
# CONFIG_SND_SOC_ES7241 is not set
CONFIG_SND_SOC_ES8316=m
# CONFIG_SND_SOC_ES8328_I2C is not set
# CONFIG_SND_SOC_ES8328_SPI is not set
# CONFIG_SND_SOC_GTM601 is not set
CONFIG_SND_SOC_HDAC_HDMI=m
# CONFIG_SND_SOC_INNO_RK3036 is not set
# CONFIG_SND_SOC_MAX98088 is not set
CONFIG_SND_SOC_MAX98090=m
CONFIG_SND_SOC_MAX98357A=m
# CONFIG_SND_SOC_MAX98504 is not set
# CONFIG_SND_SOC_MAX9867 is not set
CONFIG_SND_SOC_MAX98927=m
# CONFIG_SND_SOC_MAX98373 is not set
# CONFIG_SND_SOC_MAX9860 is not set
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
# CONFIG_SND_SOC_PCM1681 is not set
# CONFIG_SND_SOC_PCM1789_I2C is not set
# CONFIG_SND_SOC_PCM179X_I2C is not set
# CONFIG_SND_SOC_PCM179X_SPI is not set
# CONFIG_SND_SOC_PCM186X_I2C is not set
# CONFIG_SND_SOC_PCM186X_SPI is not set
# CONFIG_SND_SOC_PCM3060_I2C is not set
# CONFIG_SND_SOC_PCM3060_SPI is not set
# CONFIG_SND_SOC_PCM3168A_I2C is not set
# CONFIG_SND_SOC_PCM3168A_SPI is not set
# CONFIG_SND_SOC_PCM512x_I2C is not set
# CONFIG_SND_SOC_PCM512x_SPI is not set
# CONFIG_SND_SOC_RK3328 is not set
CONFIG_SND_SOC_RL6231=m
CONFIG_SND_SOC_RL6347A=m
CONFIG_SND_SOC_RT286=m
CONFIG_SND_SOC_RT298=m
CONFIG_SND_SOC_RT5514=m
CONFIG_SND_SOC_RT5514_SPI=m
# CONFIG_SND_SOC_RT5616 is not set
# CONFIG_SND_SOC_RT5631 is not set
CONFIG_SND_SOC_RT5640=m
CONFIG_SND_SOC_RT5645=m
CONFIG_SND_SOC_RT5651=m
CONFIG_SND_SOC_RT5663=m
CONFIG_SND_SOC_RT5670=m
CONFIG_SND_SOC_RT5677=m
CONFIG_SND_SOC_RT5677_SPI=m
# CONFIG_SND_SOC_SGTL5000 is not set
# CONFIG_SND_SOC_SIMPLE_AMPLIFIER is not set
# CONFIG_SND_SOC_SIRF_AUDIO_CODEC is not set
# CONFIG_SND_SOC_SPDIF is not set
# CONFIG_SND_SOC_SSM2305 is not set
# CONFIG_SND_SOC_SSM2602_SPI is not set
# CONFIG_SND_SOC_SSM2602_I2C is not set
CONFIG_SND_SOC_SSM4567=m
# CONFIG_SND_SOC_STA32X is not set
# CONFIG_SND_SOC_STA350 is not set
# CONFIG_SND_SOC_STI_SAS is not set
# CONFIG_SND_SOC_TAS2552 is not set
# CONFIG_SND_SOC_TAS5086 is not set
# CONFIG_SND_SOC_TAS571X is not set
# CONFIG_SND_SOC_TAS5720 is not set
# CONFIG_SND_SOC_TAS6424 is not set
# CONFIG_SND_SOC_TDA7419 is not set
# CONFIG_SND_SOC_TFA9879 is not set
# CONFIG_SND_SOC_TLV320AIC23_I2C is not set
# CONFIG_SND_SOC_TLV320AIC23_SPI is not set
# CONFIG_SND_SOC_TLV320AIC31XX is not set
# CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
# CONFIG_SND_SOC_TLV320AIC32X4_SPI is not set
# CONFIG_SND_SOC_TLV320AIC3X is not set
CONFIG_SND_SOC_TS3A227E=m
# CONFIG_SND_SOC_TSCS42XX is not set
# CONFIG_SND_SOC_TSCS454 is not set
# CONFIG_SND_SOC_WM8510 is not set
# CONFIG_SND_SOC_WM8523 is not set
# CONFIG_SND_SOC_WM8524 is not set
# CONFIG_SND_SOC_WM8580 is not set
# CONFIG_SND_SOC_WM8711 is not set
# CONFIG_SND_SOC_WM8728 is not set
# CONFIG_SND_SOC_WM8731 is not set
# CONFIG_SND_SOC_WM8737 is not set
# CONFIG_SND_SOC_WM8741 is not set
# CONFIG_SND_SOC_WM8750 is not set
# CONFIG_SND_SOC_WM8753 is not set
# CONFIG_SND_SOC_WM8770 is not set
# CONFIG_SND_SOC_WM8776 is not set
# CONFIG_SND_SOC_WM8782 is not set
# CONFIG_SND_SOC_WM8804_I2C is not set
# CONFIG_SND_SOC_WM8804_SPI is not set
# CONFIG_SND_SOC_WM8903 is not set
# CONFIG_SND_SOC_WM8904 is not set
# CONFIG_SND_SOC_WM8960 is not set
# CONFIG_SND_SOC_WM8962 is not set
# CONFIG_SND_SOC_WM8974 is not set
# CONFIG_SND_SOC_WM8978 is not set
# CONFIG_SND_SOC_WM8985 is not set
# CONFIG_SND_SOC_ZX_AUD96P22 is not set
# CONFIG_SND_SOC_MAX9759 is not set
# CONFIG_SND_SOC_MT6351 is not set
# CONFIG_SND_SOC_MT6358 is not set
# CONFIG_SND_SOC_NAU8540 is not set
# CONFIG_SND_SOC_NAU8810 is not set
# CONFIG_SND_SOC_NAU8822 is not set
CONFIG_SND_SOC_NAU8824=m
CONFIG_SND_SOC_NAU8825=m
# CONFIG_SND_SOC_TPA6130A2 is not set
# end of CODEC drivers

# CONFIG_SND_SIMPLE_CARD is not set
CONFIG_SND_X86=y
CONFIG_HDMI_LPE_AUDIO=m
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
# CONFIG_HID_MACALLY is not set
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
# CONFIG_HID_VIEWSONIC is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=y
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
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_REDRAGON=y
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
CONFIG_HID_RMI=m
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
# CONFIG_HID_U2FZERO is not set
CONFIG_HID_WACOM=m
CONFIG_HID_WIIMOTE=m
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=m
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y
# end of USB HID support

#
# I2C HID support
#
CONFIG_I2C_HID=m
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=y
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support
# end of HID support

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
CONFIG_USB_LEDS_TRIGGER_USBPORT=m
CONFIG_USB_AUTOSUSPEND_DELAY=2
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
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
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
CONFIG_USBIP_CORE=m
# CONFIG_USBIP_VHCI_HCD is not set
# CONFIG_USBIP_HOST is not set
# CONFIG_USBIP_DEBUG is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
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
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_TYPEC_TPS6598X is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

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
# CONFIG_LEDS_LM3532 is not set
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
CONFIG_LEDS_TRIGGER_GPIO=m
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
CONFIG_EDAC_GHES=y
CONFIG_EDAC_AMD64=m
# CONFIG_EDAC_AMD64_ERROR_INJECTION is not set
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
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
# CONFIG_RTC_DRV_ABEOZ9 is not set
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
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

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
CONFIG_RTC_DRV_RX4581=m
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
CONFIG_INTEL_IOATDMA=m
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
# CONFIG_DMATEST is not set
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
# end of DMABUF options

CONFIG_DCA=m
CONFIG_AUXDISPLAY=y
# CONFIG_HD44780 is not set
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_CFAG12864B=m
CONFIG_CFAG12864B_RATE=20
# CONFIG_IMG_ASCII_LCD is not set
# CONFIG_PARPORT_PANEL is not set
# CONFIG_CHARLCD_BL_OFF is not set
# CONFIG_CHARLCD_BL_ON is not set
CONFIG_CHARLCD_BL_FLASH=y
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
CONFIG_UIO_HV_GENERIC=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_VFIO_MDEV_DEVICE=m
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TSCPAGE=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
CONFIG_XEN_BALLOON=y
# CONFIG_XEN_SELFBALLOONING is not set
# CONFIG_XEN_BALLOON_MEMORY_HOTPLUG is not set
CONFIG_XEN_SCRUB_PAGES_DEFAULT=y
CONFIG_XEN_DEV_EVTCHN=m
# CONFIG_XEN_BACKEND is not set
CONFIG_XENFS=m
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
CONFIG_XEN_TMEM=m
# CONFIG_XEN_PVCALLS_FRONTEND is not set
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_HAVE_PVMMU=y
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
CONFIG_XEN_HAVE_VPMU=y
# end of Xen driver support

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
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set

#
# IIO staging drivers
#

#
# Accelerometers
#
# CONFIG_ADIS16203 is not set
# CONFIG_ADIS16240 is not set
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7816 is not set
# CONFIG_AD7192 is not set
# CONFIG_AD7280 is not set
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
# CONFIG_ADT7316 is not set
# end of Analog digital bi-direction converters

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
# CONFIG_AD7746 is not set
# end of Capacitance to digital converters

#
# Direct Digital Synthesis
#
# CONFIG_AD9832 is not set
# CONFIG_AD9834 is not set
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
# CONFIG_AD5933 is not set
# end of Network Analyzer, Impedance Converters

#
# Active energy metering IC
#
# CONFIG_ADE7854 is not set
# end of Active energy metering IC

#
# Resolver to digital converters
#
# CONFIG_AD2S1210 is not set
# end of Resolver to digital converters
# end of IIO staging drivers

# CONFIG_FB_SM750 is not set

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set
# end of Speakup console speech

# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_ASHMEM is not set
# CONFIG_ANDROID_VSOC is not set
CONFIG_ION=y
CONFIG_ION_SYSTEM_HEAP=y
# CONFIG_ION_CARVEOUT_HEAP is not set
# CONFIG_ION_CHUNK_HEAP is not set
# CONFIG_ION_CMA_HEAP is not set
# end of Android

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
# CONFIG_PI433 is not set

#
# Gasket devices
#
# CONFIG_STAGING_GASKET_FRAMEWORK is not set
# end of Gasket devices

# CONFIG_EROFS_FS is not set
# CONFIG_FIELDBUS_DEV is not set
# CONFIG_KPC2000 is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACER_WMI=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACERHDF=m
# CONFIG_ALIENWARE_WMI is not set
CONFIG_ASUS_LAPTOP=m
CONFIG_DCDBAS=m
CONFIG_DELL_SMBIOS=m
CONFIG_DELL_SMBIOS_WMI=y
CONFIG_DELL_SMBIOS_SMM=y
CONFIG_DELL_LAPTOP=m
CONFIG_DELL_WMI=m
CONFIG_DELL_WMI_DESCRIPTOR=m
CONFIG_DELL_WMI_AIO=m
# CONFIG_DELL_WMI_LED is not set
CONFIG_DELL_SMO8800=m
CONFIG_DELL_RBTN=m
CONFIG_DELL_RBU=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
CONFIG_AMILO_RFKILL=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
CONFIG_HP_WIRELESS=m
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
CONFIG_INTEL_WMI_THUNDERBOLT=m
CONFIG_MSI_WMI=m
# CONFIG_PEAQ_WMI is not set
CONFIG_TOPSTAR_LAPTOP=m
CONFIG_ACPI_TOSHIBA=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
CONFIG_INTEL_IPS=m
CONFIG_INTEL_PMC_CORE=m
# CONFIG_IBM_RTL is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_MXM_WMI=m
CONFIG_INTEL_OAKTRAIL=m
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
# CONFIG_PCENGINES_APU2 is not set
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
# end of Common Clock Framework

# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Aspeed SoC drivers
#
# end of Aspeed SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# IXP4xx SoC drivers
#
# CONFIG_IXP4XX_QMGR is not set
# CONFIG_IXP4XX_NPE is not set
# end of IXP4xx SoC drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

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
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
# CONFIG_IIO_BUFFER_HW_CONSUMER is not set
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=m
# CONFIG_IIO_CONFIGFS is not set
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
# CONFIG_IIO_SW_TRIGGER is not set

#
# Accelerometers
#
# CONFIG_ADIS16201 is not set
# CONFIG_ADIS16209 is not set
# CONFIG_ADXL345_I2C is not set
# CONFIG_ADXL345_SPI is not set
# CONFIG_ADXL372_SPI is not set
# CONFIG_ADXL372_I2C is not set
# CONFIG_BMA180 is not set
# CONFIG_BMA220 is not set
# CONFIG_BMC150_ACCEL is not set
# CONFIG_DA280 is not set
# CONFIG_DA311 is not set
# CONFIG_DMARD09 is not set
# CONFIG_DMARD10 is not set
CONFIG_HID_SENSOR_ACCEL_3D=m
# CONFIG_IIO_CROS_EC_ACCEL_LEGACY is not set
# CONFIG_IIO_ST_ACCEL_3AXIS is not set
# CONFIG_KXSD9 is not set
# CONFIG_KXCJK1013 is not set
# CONFIG_MC3230 is not set
# CONFIG_MMA7455_I2C is not set
# CONFIG_MMA7455_SPI is not set
# CONFIG_MMA7660 is not set
# CONFIG_MMA8452 is not set
# CONFIG_MMA9551 is not set
# CONFIG_MMA9553 is not set
# CONFIG_MXC4005 is not set
# CONFIG_MXC6255 is not set
# CONFIG_SCA3000 is not set
# CONFIG_STK8312 is not set
# CONFIG_STK8BA50 is not set
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7124 is not set
# CONFIG_AD7266 is not set
# CONFIG_AD7291 is not set
# CONFIG_AD7298 is not set
# CONFIG_AD7476 is not set
# CONFIG_AD7606_IFACE_PARALLEL is not set
# CONFIG_AD7606_IFACE_SPI is not set
# CONFIG_AD7766 is not set
# CONFIG_AD7768_1 is not set
# CONFIG_AD7780 is not set
# CONFIG_AD7791 is not set
# CONFIG_AD7793 is not set
# CONFIG_AD7887 is not set
# CONFIG_AD7923 is not set
# CONFIG_AD7949 is not set
# CONFIG_AD799X is not set
# CONFIG_HI8435 is not set
# CONFIG_HX711 is not set
# CONFIG_INA2XX_ADC is not set
# CONFIG_LTC2471 is not set
# CONFIG_LTC2485 is not set
# CONFIG_LTC2497 is not set
# CONFIG_MAX1027 is not set
# CONFIG_MAX11100 is not set
# CONFIG_MAX1118 is not set
# CONFIG_MAX1363 is not set
# CONFIG_MAX9611 is not set
# CONFIG_MCP320X is not set
# CONFIG_MCP3422 is not set
# CONFIG_MCP3911 is not set
# CONFIG_NAU7802 is not set
# CONFIG_TI_ADC081C is not set
# CONFIG_TI_ADC0832 is not set
# CONFIG_TI_ADC084S021 is not set
# CONFIG_TI_ADC12138 is not set
# CONFIG_TI_ADC108S102 is not set
# CONFIG_TI_ADC128S052 is not set
# CONFIG_TI_ADC161S626 is not set
# CONFIG_TI_ADS1015 is not set
# CONFIG_TI_ADS7950 is not set
# CONFIG_TI_TLC4541 is not set
# CONFIG_VIPERBOARD_ADC is not set
# end of Analog to digital converters

#
# Analog Front Ends
#
# end of Analog Front Ends

#
# Amplifiers
#
# CONFIG_AD8366 is not set
# end of Amplifiers

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
# CONFIG_BME680 is not set
# CONFIG_CCS811 is not set
# CONFIG_IAQCORE is not set
# CONFIG_SENSIRION_SGP30 is not set
# CONFIG_SPS30 is not set
# CONFIG_VZ89X is not set
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=m
CONFIG_HID_SENSOR_IIO_TRIGGER=m
# end of Hid Sensor IIO Common

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORHUB is not set
# end of SSP Sensor Common

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
# CONFIG_AD5360 is not set
# CONFIG_AD5380 is not set
# CONFIG_AD5421 is not set
# CONFIG_AD5446 is not set
# CONFIG_AD5449 is not set
# CONFIG_AD5592R is not set
# CONFIG_AD5593R is not set
# CONFIG_AD5504 is not set
# CONFIG_AD5624R_SPI is not set
# CONFIG_LTC1660 is not set
# CONFIG_LTC2632 is not set
# CONFIG_AD5686_SPI is not set
# CONFIG_AD5696_I2C is not set
# CONFIG_AD5755 is not set
# CONFIG_AD5758 is not set
# CONFIG_AD5761 is not set
# CONFIG_AD5764 is not set
# CONFIG_AD5791 is not set
# CONFIG_AD7303 is not set
# CONFIG_AD8801 is not set
# CONFIG_DS4424 is not set
# CONFIG_M62332 is not set
# CONFIG_MAX517 is not set
# CONFIG_MCP4725 is not set
# CONFIG_MCP4922 is not set
# CONFIG_TI_DAC082S085 is not set
# CONFIG_TI_DAC5571 is not set
# CONFIG_TI_DAC7311 is not set
# CONFIG_TI_DAC7612 is not set
# end of Digital to analog converters

#
# IIO dummy driver
#
# end of IIO dummy driver

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# CONFIG_AD9523 is not set
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# CONFIG_ADF4350 is not set
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16080 is not set
# CONFIG_ADIS16130 is not set
# CONFIG_ADIS16136 is not set
# CONFIG_ADIS16260 is not set
# CONFIG_ADXRS450 is not set
# CONFIG_BMG160 is not set
# CONFIG_FXAS21002C is not set
CONFIG_HID_SENSOR_GYRO_3D=m
# CONFIG_MPU3050_I2C is not set
# CONFIG_IIO_ST_GYRO_3AXIS is not set
# CONFIG_ITG3200 is not set
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4403 is not set
# CONFIG_AFE4404 is not set
# CONFIG_MAX30100 is not set
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
# CONFIG_DHT11 is not set
# CONFIG_HDC100X is not set
# CONFIG_HID_SENSOR_HUMIDITY is not set
# CONFIG_HTS221 is not set
# CONFIG_HTU21 is not set
# CONFIG_SI7005 is not set
# CONFIG_SI7020 is not set
# end of Humidity sensors

#
# Inertial measurement units
#
# CONFIG_ADIS16400 is not set
# CONFIG_ADIS16480 is not set
# CONFIG_BMI160_I2C is not set
# CONFIG_BMI160_SPI is not set
# CONFIG_KMX61 is not set
# CONFIG_INV_MPU6050_I2C is not set
# CONFIG_INV_MPU6050_SPI is not set
# CONFIG_IIO_ST_LSM6DSX is not set
# end of Inertial measurement units

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
# CONFIG_ADJD_S311 is not set
# CONFIG_AL3320A is not set
# CONFIG_APDS9300 is not set
# CONFIG_APDS9960 is not set
# CONFIG_BH1750 is not set
# CONFIG_BH1780 is not set
# CONFIG_CM32181 is not set
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
# CONFIG_CM36651 is not set
# CONFIG_GP2AP020A00F is not set
# CONFIG_SENSORS_ISL29018 is not set
# CONFIG_SENSORS_ISL29028 is not set
# CONFIG_ISL29125 is not set
CONFIG_HID_SENSOR_ALS=m
CONFIG_HID_SENSOR_PROX=m
# CONFIG_JSA1212 is not set
# CONFIG_RPR0521 is not set
# CONFIG_LTR501 is not set
# CONFIG_LV0104CS is not set
# CONFIG_MAX44000 is not set
# CONFIG_MAX44009 is not set
# CONFIG_OPT3001 is not set
# CONFIG_PA12203001 is not set
# CONFIG_SI1133 is not set
# CONFIG_SI1145 is not set
# CONFIG_STK3310 is not set
# CONFIG_ST_UVIS25 is not set
# CONFIG_TCS3414 is not set
# CONFIG_TCS3472 is not set
# CONFIG_SENSORS_TSL2563 is not set
# CONFIG_TSL2583 is not set
# CONFIG_TSL2772 is not set
# CONFIG_TSL4531 is not set
# CONFIG_US5182D is not set
# CONFIG_VCNL4000 is not set
# CONFIG_VCNL4035 is not set
# CONFIG_VEML6070 is not set
# CONFIG_VL6180 is not set
# CONFIG_ZOPT2201 is not set
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8975 is not set
# CONFIG_AK09911 is not set
# CONFIG_BMC150_MAGN_I2C is not set
# CONFIG_BMC150_MAGN_SPI is not set
# CONFIG_MAG3110 is not set
CONFIG_HID_SENSOR_MAGNETOMETER_3D=m
# CONFIG_MMC35240 is not set
# CONFIG_IIO_ST_MAGN_3AXIS is not set
# CONFIG_SENSORS_HMC5843_I2C is not set
# CONFIG_SENSORS_HMC5843_SPI is not set
# CONFIG_SENSORS_RM3100_I2C is not set
# CONFIG_SENSORS_RM3100_SPI is not set
# end of Magnetometer sensors

#
# Multiplexers
#
# end of Multiplexers

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=m
CONFIG_HID_SENSOR_DEVICE_ROTATION=m
# end of Inclinometer sensors

#
# Triggers - standalone
#
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
# CONFIG_IIO_SYSFS_TRIGGER is not set
# end of Triggers - standalone

#
# Digital potentiometers
#
# CONFIG_AD5272 is not set
# CONFIG_DS1803 is not set
# CONFIG_MAX5481 is not set
# CONFIG_MAX5487 is not set
# CONFIG_MCP4018 is not set
# CONFIG_MCP4131 is not set
# CONFIG_MCP4531 is not set
# CONFIG_MCP41010 is not set
# CONFIG_TPL0102 is not set
# end of Digital potentiometers

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set
# end of Digital potentiostats

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
# CONFIG_BMP280 is not set
CONFIG_HID_SENSOR_PRESS=m
# CONFIG_HP03 is not set
# CONFIG_MPL115_I2C is not set
# CONFIG_MPL115_SPI is not set
# CONFIG_MPL3115 is not set
# CONFIG_MS5611 is not set
# CONFIG_MS5637 is not set
# CONFIG_IIO_ST_PRESS is not set
# CONFIG_T5403 is not set
# CONFIG_HP206C is not set
# CONFIG_ZPA2326 is not set
# end of Pressure sensors

#
# Lightning sensors
#
# CONFIG_AS3935 is not set
# end of Lightning sensors

#
# Proximity and distance sensors
#
# CONFIG_ISL29501 is not set
# CONFIG_LIDAR_LITE_V2 is not set
# CONFIG_MB1232 is not set
# CONFIG_RFD77402 is not set
# CONFIG_SRF04 is not set
# CONFIG_SX9500 is not set
# CONFIG_SRF08 is not set
# CONFIG_VL53L0X_I2C is not set
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# CONFIG_AD2S90 is not set
# CONFIG_AD2S1200 is not set
# end of Resolver to digital converters

#
# Temperature sensors
#
# CONFIG_MAXIM_THERMOCOUPLE is not set
# CONFIG_HID_SENSOR_TEMP is not set
# CONFIG_MLX90614 is not set
# CONFIG_MLX90632 is not set
# CONFIG_TMP006 is not set
# CONFIG_TMP007 is not set
# CONFIG_TSYS01 is not set
# CONFIG_TSYS02D is not set
# CONFIG_MAX31856 is not set
# end of Temperature sensors

CONFIG_NTB=m
CONFIG_NTB_AMD=m
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
CONFIG_NTB_PERF=m
CONFIG_NTB_TRANSPORT=m
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
CONFIG_ARM_GIC_MAX_NR=1
# end of IRQ chip support

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
# CONFIG_PHY_CPCAP_USB is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
CONFIG_THUNDERBOLT=y

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

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
CONFIG_DEV_DAX_KMEM=m
CONFIG_DEV_DAX_PMEM_COMPAT=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

# CONFIG_FPGA is not set
CONFIG_PM_OPP=y
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=m
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=m
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=m
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
# CONFIG_F2FS_IO_TRACE is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
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
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
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
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

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
# end of DOS/FAT/NT Filesystems

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
# end of Pseudo filesystems

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
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
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
# CONFIG_CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
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
# CONFIG_UNICODE is not set
# end of File systems

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
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
# CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
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
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
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
CONFIG_LSM="yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is not set
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

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
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
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
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECRDSA is not set

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
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=m
# CONFIG_CRYPTO_SHA3 is not set
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
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=m
# CONFIG_CRYPTO_USER_API_AEAD is not set
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
# CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set
CONFIG_CRYPTO_DEV_CHELSIO=m
CONFIG_CRYPTO_DEV_VIRTIO=m
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=m
CONFIG_PRIME_NUMBERS=m
CONFIG_RATIONAL=y
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
CONFIG_LIBCRC32C=m
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
CONFIG_DMA_DECLARE_COHERENT=y
CONFIG_SWIOTLB=y
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
# CONFIG_DMA_API_DEBUG is not set
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
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_BTF is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_UNUSED_SYMBOLS is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_OPTIMIZE_INLINING=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
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
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_CC_HAS_KASAN_GENERIC=y
# CONFIG_KASAN is not set
CONFIG_KASAN_STACK=1
# end of Memory Debugging

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
# end of Debug Lockups and Hangs

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
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
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
# end of RCU Debugging

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
CONFIG_HWLAT_TRACER=y
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
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
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
# CONFIG_TEST_VMALLOC is not set
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=m
CONFIG_TEST_SYSCTL=m
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
CONFIG_TEST_LIVEPATCH=m
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_MEMTEST is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_UBSAN_ALIGNMENT=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set
# CONFIG_DEBUG_AID_FOR_SYZBOT is not set
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
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
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# CONFIG_UNWINDER_GUESS is not set
# end of Kernel hacking

--i7KxW38SoMauyveo
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
	export job_origin='/lkp/lkp/src/allot/rand/vm-snb-8G/kernel_selftests.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='vm-snb-8G-414'
	export tbox_group='vm-snb-8G'
	export branch='linux-devel/devel-catchup-201907030021'
	export commit='cd5bbb3047bf73353767d70a03db986600ca372a'
	export kconfig='x86_64-rhel-7.6'
	export repeat_to=12
	export submit_id='5d20296b9f62131c76081045'
	export job_file='/lkp/jobs/scheduled/vm-snb-8G-414/kernel_selftests-kselftests-02-debian-x86_64-2018-04-03.cgz-cd5bbb30-20190706-7286-azbicy-8.yaml'
	export id='180cdea30e8f9226dcca8320dad814c5732d6183'
	export queuer_version='/lkp/lkp/src'
	export arch='x86_64'
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
CONFIG_IPV6_SEG6_LWTUNNEL=y ~ v(4\.1[0-9]|4\.20|5\.)
CONFIG_LWTUNNEL=y
CONFIG_WW_MUTEX_SELFTEST=m ~ v(4\.1[1-9]|4\.20|5\.)
CONFIG_DRM_DEBUG_SELFTEST=m ~ v(4\.1[8-9]|4\.20|5\.)
CONFIG_TEST_LIVEPATCH=m ~ v(5\.[1-9])
CONFIG_LIRC=y
CONFIG_IR_SHARP_DECODER=m
CONFIG_ANDROID=y ~ v(3\.[3-9]|3\.1[0-9]|4\.|5\.)
CONFIG_ION=y ~ v(3\.1[4-9]|4\.|5\.)
CONFIG_ION_SYSTEM_HEAP=y ~ v(4\.1[2-9]|4\.20|5\.)
CONFIG_KVM_GUEST=y'
	export ssh_base_port=26000
	export rootfs='debian-x86_64-2018-04-03.cgz'
	export compiler='gcc-7'
	export enqueue_time='2019-07-06 12:54:05 +0800'
	export _id='5d2029709f62131c76081047'
	export _rt='/result/kernel_selftests/kselftests-02/vm-snb-8G/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.6/gcc-7/cd5bbb3047bf73353767d70a03db986600ca372a'
	export user='lkp'
	export result_root='/result/kernel_selftests/kselftests-02/vm-snb-8G/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.6/gcc-7/cd5bbb3047bf73353767d70a03db986600ca372a/8'
	export scheduler_version='/lkp/lkp/.src-20190705-224659'
	export LKP_SERVER='inn'
	export max_uptime=3600
	export initrd='/osimage/debian/debian-x86_64-2018-04-03.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/vm-snb-8G-414/kernel_selftests-kselftests-02-debian-x86_64-2018-04-03.cgz-cd5bbb30-20190706-7286-azbicy-8.yaml
ARCH=x86_64
kconfig=x86_64-rhel-7.6
branch=linux-devel/devel-catchup-201907030021
commit=cd5bbb3047bf73353767d70a03db986600ca372a
BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.6/gcc-7/cd5bbb3047bf73353767d70a03db986600ca372a/vmlinuz-5.2.0-rc4-00289-gcd5bbb3047bf7
erst_disable
max_uptime=3600
RESULT_ROOT=/result/kernel_selftests/kselftests-02/vm-snb-8G/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.6/gcc-7/cd5bbb3047bf73353767d70a03db986600ca372a/8
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
	export modules_initrd='/pkg/linux/x86_64-rhel-7.6/gcc-7/cd5bbb3047bf73353767d70a03db986600ca372a/modules.cgz'
	export bm_initrd='/osimage/deps/debian-x86_64-2018-04-03.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/lkp_2019-06-26.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/kernel_selftests_2019-07-05.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/kernel_selftests-x86_64-b253d5f3ecc9_2019-06-23.cgz'
	export linux_headers_initrd='/pkg/linux/x86_64-rhel-7.6/gcc-7/cd5bbb3047bf73353767d70a03db986600ca372a/linux-headers.cgz'
	export linux_selftests_initrd='/pkg/linux/x86_64-rhel-7.6/gcc-7/cd5bbb3047bf73353767d70a03db986600ca372a/linux-selftests.cgz'
	export lkp_initrd='/lkp/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export schedule_notify_address=
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='8G'
	export hdd_partitions='/dev/vda /dev/vdb /dev/vdc /dev/vdd /dev/vde /dev/vdf'
	export swap_partitions='/dev/vdg'
	export queue_at_least_once=1
	export vm_tbox_group='vm-snb-8G'
	export nr_vm=48
	export vm_base_id=401
	export kernel='/pkg/linux/x86_64-rhel-7.6/gcc-7/cd5bbb3047bf73353767d70a03db986600ca372a/vmlinuz-5.2.0-rc4-00289-gcd5bbb3047bf7'
	export dequeue_time='2019-07-06 12:54:34 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-snb-8G-414/kernel_selftests-kselftests-02-debian-x86_64-2018-04-03.cgz-cd5bbb30-20190706-7286-azbicy-8.cgz'

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
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--i7KxW38SoMauyveo
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
nsYDj7wWIxkUxrHEZ/sCAAAAAARZWg==

--i7KxW38SoMauyveo
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=kernel_selftests
Content-Transfer-Encoding: quoted-printable

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-7=
=2E6-cd5bbb3047bf73353767d70a03db986600ca372a
media_tests test: not in Makefile
2019-07-06 12:56:25 make TARGETS=3Dmedia_tests
make --no-builtin-rules ARCH=3Dx86 -C ../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb=
3047bf73353767d70a03db986600ca372a'
  HOSTCC  scripts/basic/fixdep
  WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
  WRAP    arch/x86/include/generated/uapi/asm/poll.h
  WRAP    arch/x86/include/generated/uapi/asm/socket.h
  WRAP    arch/x86/include/generated/uapi/asm/sockios.h
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
  INSTALL usr/include/asm-generic/ (36 files)
  INSTALL usr/include/drm/ (28 files)
  INSTALL usr/include/linux/ (506 files)
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
  INSTALL usr/include/misc/ (4 files)
  INSTALL usr/include/mtd/ (5 files)
  INSTALL usr/include/rdma/ (26 files)
  INSTALL usr/include/rdma/hfi/ (2 files)
  INSTALL usr/include/scsi/ (5 files)
  INSTALL usr/include/scsi/fc/ (4 files)
  INSTALL usr/include/sound/ (16 files)
  INSTALL usr/include/sound/sof/ (8 files)
  INSTALL usr/include/video/ (3 files)
  INSTALL usr/include/xen/ (4 files)
  INSTALL usr/include/asm/ (62 files)
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3=
047bf73353767d70a03db986600ca372a'
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb=
3047bf73353767d70a03db986600ca372a/tools/testing/selftests/media_tests'
gcc -I../ -I../../../../usr/include/    media_device_test.c  -o /usr/src/pe=
rf_selftests-x86_64-rhel-7.6-cd5bbb3047bf73353767d70a03db986600ca372a/tools=
/testing/selftests/media_tests/media_device_test
gcc -I../ -I../../../../usr/include/    media_device_open.c  -o /usr/src/pe=
rf_selftests-x86_64-rhel-7.6-cd5bbb3047bf73353767d70a03db986600ca372a/tools=
/testing/selftests/media_tests/media_device_open
gcc -I../ -I../../../../usr/include/    video_device_test.c  -o /usr/src/pe=
rf_selftests-x86_64-rhel-7.6-cd5bbb3047bf73353767d70a03db986600ca372a/tools=
/testing/selftests/media_tests/video_device_test
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3=
047bf73353767d70a03db986600ca372a/tools/testing/selftests/media_tests'
ignored_by_lkp media_tests test

2019-07-06 12:56:46 make run_tests -C membarrier
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb304=
7bf73353767d70a03db986600ca372a/tools/testing/selftests/membarrier'
gcc -g -I../../../../usr/include/    membarrier_test.c  -o /usr/src/perf_se=
lftests-x86_64-rhel-7.6-cd5bbb3047bf73353767d70a03db986600ca372a/tools/test=
ing/selftests/membarrier/membarrier_test
TAP version 13
1..1
# selftests: membarrier: membarrier_test
# TAP version 13
# 1..13
# ok 1 sys_membarrier available
# ok 2 sys membarrier invalid command test: command =3D -1, flags =3D 0, er=
rno =3D 22. Failed as expected
# ok 3 sys membarrier MEMBARRIER_CMD_QUERY invalid flags test: flags =3D 1,=
 errno =3D 22. Failed as expected
# ok 4 sys membarrier MEMBARRIER_CMD_GLOBAL test: flags =3D 0
# ok 5 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED not registered failu=
re test: flags =3D 0, errno =3D 1
# ok 6 sys membarrier MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED test: flags=
 =3D 0
# ok 7 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED test: flags =3D 0
# ok 8 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE not regist=
ered failure test: flags =3D 0, errno =3D 1
# ok 9 sys membarrier MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE t=
est: flags =3D 0
# ok 10 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE test: fla=
gs =3D 0
# ok 11 sys membarrier MEMBARRIER_CMD_GLOBAL_EXPEDITED test: flags =3D 0
# ok 12 sys membarrier MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED test: flags=
 =3D 0
# ok 13 sys membarrier MEMBARRIER_CMD_GLOBAL_EXPEDITED test: flags =3D 0
# # Pass 13 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
ok 1 selftests: membarrier: membarrier_test
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047=
bf73353767d70a03db986600ca372a/tools/testing/selftests/membarrier'

2019-07-06 12:56:47 make run_tests -C memfd
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb304=
7bf73353767d70a03db986600ca372a/tools/testing/selftests/memfd'
gcc -D_FILE_OFFSET_BITS=3D64 -I../../../../include/uapi/ -I../../../../incl=
ude/ -I../../../../usr/include/   -c -o common.o common.c
gcc -D_FILE_OFFSET_BITS=3D64 -I../../../../include/uapi/ -I../../../../incl=
ude/ -I../../../../usr/include/    memfd_test.c common.o  -o /usr/src/perf_=
selftests-x86_64-rhel-7.6-cd5bbb3047bf73353767d70a03db986600ca372a/tools/te=
sting/selftests/memfd/memfd_test
memfd_test.c: In function =E2=80=98mfd_assert_reopen_fd=E2=80=99:
memfd_test.c:64:7: warning: implicit declaration of function =E2=80=98open=
=E2=80=99 [-Wimplicit-function-declaration]
  fd =3D open(path, O_RDWR);
       ^~~~
memfd_test.c: In function =E2=80=98mfd_assert_get_seals=E2=80=99:
memfd_test.c:90:6: warning: implicit declaration of function =E2=80=98fcntl=
=E2=80=99 [-Wimplicit-function-declaration]
  r =3D fcntl(fd, F_GET_SEALS);
      ^~~~~
memfd_test.c: In function =E2=80=98mfd_assert_write=E2=80=99:
memfd_test.c:363:6: warning: implicit declaration of function =E2=80=98fall=
ocate=E2=80=99 [-Wimplicit-function-declaration]
  r =3D fallocate(fd,
      ^~~~~~~~~
gcc -D_FILE_OFFSET_BITS=3D64 -I../../../../include/uapi/ -I../../../../incl=
ude/ -I../../../../usr/include/    fuse_mnt.c -lfuse -pthread -o /usr/src/p=
erf_selftests-x86_64-rhel-7.6-cd5bbb3047bf73353767d70a03db986600ca372a/tool=
s/testing/selftests/memfd/fuse_mnt
gcc -D_FILE_OFFSET_BITS=3D64 -I../../../../include/uapi/ -I../../../../incl=
ude/ -I../../../../usr/include/    fuse_test.c common.o  -o /usr/src/perf_s=
elftests-x86_64-rhel-7.6-cd5bbb3047bf73353767d70a03db986600ca372a/tools/tes=
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
1..3
# selftests: memfd: memfd_test
# memfd: CREATE
# memfd: BASIC
# memfd: SEAL-WRITE
# memfd: SEAL-FUTURE-WRITE
# memfd: SEAL-SHRINK
# memfd: SEAL-GROW
# memfd: SEAL-RESIZE
# memfd: SHARE-DUP=20
# memfd: SHARE-MMAP=20
# memfd: SHARE-OPEN=20
# memfd: SHARE-FORK=20
# memfd: SHARE-DUP (shared file-table)
# memfd: SHARE-MMAP (shared file-table)
# memfd: SHARE-OPEN (shared file-table)
# memfd: SHARE-FORK (shared file-table)
# memfd: DONE
ok 1 selftests: memfd: memfd_test
# selftests: memfd: run_fuse_test.sh
# opening: ./mnt/memfd
# fuse: DONE
ok 2 selftests: memfd: run_fuse_test.sh
# selftests: memfd: run_hugetlbfs_test.sh
# ./run_hugetlbfs_test.sh: line 60:  7076 Aborted                 ./memfd_t=
est hugetlbfs
# opening: ./mnt/memfd
# fuse: DONE
ok 3 selftests: memfd: run_hugetlbfs_test.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047=
bf73353767d70a03db986600ca372a/tools/testing/selftests/memfd'

2019-07-06 12:56:51 make run_tests -C memory-hotplug
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb304=
7bf73353767d70a03db986600ca372a/tools/testing/selftests/memory-hotplug'
TAP version 13
1..1
# selftests: memory-hotplug: mem-on-off-test.sh
# Test scope: 2% hotplug memory
# 	 online all hot-pluggable memory in offline state:
# 		 SKIPPED - no hot-pluggable memory in offline state
# 	 offline 2% hot-pluggable memory in online state
# 	 trying to offline 1 out of 27 memory block(s):
# online->offline memory1
# 	 online all hot-pluggable memory in offline state:
# offline->online memory1
# 	 Test with memory notifier error injection
ok 1 selftests: memory-hotplug: mem-on-off-test.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047=
bf73353767d70a03db986600ca372a/tools/testing/selftests/memory-hotplug'

2019-07-06 12:56:54 make run_tests -C mount
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb304=
7bf73353767d70a03db986600ca372a/tools/testing/selftests/mount'
gcc -Wall -O2    unprivileged-remount-test.c  -o /usr/src/perf_selftests-x8=
6_64-rhel-7.6-cd5bbb3047bf73353767d70a03db986600ca372a/tools/testing/selfte=
sts/mount/unprivileged-remount-test
TAP version 13
1..1
# selftests: mount: run_tests.sh
ok 1 selftests: mount: run_tests.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047=
bf73353767d70a03db986600ca372a/tools/testing/selftests/mount'

2019-07-06 12:56:54 make run_tests -C mqueue
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb304=
7bf73353767d70a03db986600ca372a/tools/testing/selftests/mqueue'
gcc -O2    mq_open_tests.c -lrt -lpthread -lpopt -o /usr/src/perf_selftests=
-x86_64-rhel-7.6-cd5bbb3047bf73353767d70a03db986600ca372a/tools/testing/sel=
ftests/mqueue/mq_open_tests
gcc -O2    mq_perf_tests.c -lrt -lpthread -lpopt -o /usr/src/perf_selftests=
-x86_64-rhel-7.6-cd5bbb3047bf73353767d70a03db986600ca372a/tools/testing/sel=
ftests/mqueue/mq_perf_tests
TAP version 13
1..2
# selftests: mqueue: mq_open_tests
# Using Default queue path - /test1
#=20
# Initial system state:
# 	Using queue path:		/test1
# 	RLIMIT_MSGQUEUE(soft):		819200
# 	RLIMIT_MSGQUEUE(hard):		819200
# 	Maximum Message Size:		8192
# 	Maximum Queue Size:		10
# 	Default Message Size:		8192
# 	Default Queue Size:		10
#=20
# Adjusted system state for testing:
# 	RLIMIT_MSGQUEUE(soft):		819200
# 	RLIMIT_MSGQUEUE(hard):		819200
# 	Maximum Message Size:		8192
# 	Maximum Queue Size:		10
# 	Default Message Size:		8192
# 	Default Queue Size:		10
#=20
#=20
# Test series 1, behavior when no attr struct passed to mq_open:
# Kernel supports setting defaults separately from maximums:		PASS
# Given sane values, mq_open without an attr struct succeeds:		PASS
# Kernel properly honors default setting knobs:				PASS
# Kernel properly limits default values to lesser of default/max:		PASS
# Kernel properly fails to create queue when defaults would
# exceed rlimit:								PASS
#=20
#=20
# Test series 2, behavior when attr struct is passed to mq_open:
# Queue open in excess of rlimit max when euid =3D 0 failed:		PASS
# Queue open with mq_maxmsg > limit when euid =3D 0 succeeded:		PASS
# Queue open with mq_msgsize > limit when euid =3D 0 succeeded:		PASS
# Queue open with total size > 2GB when euid =3D 0 failed:			PASS
# Queue open in excess of rlimit max when euid =3D 99 failed:		PASS
# Queue open with mq_maxmsg > limit when euid =3D 99 failed:		PASS
# Queue open with mq_msgsize > limit when euid =3D 99 failed:		PASS
# Queue open with total size > 2GB when euid =3D 99 failed:			PASS
ok 1 selftests: mqueue: mq_open_tests
# selftests: mqueue: mq_perf_tests
#=20
# Initial system state:
# 	Using queue path:			/mq_perf_tests
# 	RLIMIT_MSGQUEUE(soft):			819200
# 	RLIMIT_MSGQUEUE(hard):			819200
# 	Maximum Message Size:			8192
# 	Maximum Queue Size:			10
# 	Nice value:				0
#=20
# Adjusted system state for testing:
# 	RLIMIT_MSGQUEUE(soft):			(unlimited)
# 	RLIMIT_MSGQUEUE(hard):			(unlimited)
# 	Maximum Message Size:			16777216
# 	Maximum Queue Size:			65530
# 	Nice value:				-20
# 	Continuous mode:			(disabled)
# 	CPUs to pin:				1
#=20
# 	Queue /mq_perf_tests created:
# 		mq_flags:			O_NONBLOCK
# 		mq_maxmsg:			65530
# 		mq_msgsize:			16
# 		mq_curmsgs:			0
#=20
# 	Started mqueue performance test thread on CPU 1
# 		Max priorities:			32768
# 		Clock resolution:		1 nsec
#=20
# 	Test #1: Time send/recv message, queue empty
# 		(10000000 iterations)
# 		Send msg:			33.375121511s total time
# 						3337 nsec/msg
# 		Recv msg:			33.596921278s total time
# 						3359 nsec/msg
#=20
# 	Test #2a: Time send/recv message, queue full, constant prio
# :
# 		(100000 iterations)
# 		Filling queue...done.		0.124434748s
# 		Testing...done.
# 		Send msg:			0.372229207s total time
# 						3722 nsec/msg
# 		Recv msg:			0.382709949s total time
# 						3827 nsec/msg
# 		Draining queue...done.		0.125815185s
#=20
# 	Test #2b: Time send/recv message, queue full, increasing prio
# :
# 		(100000 iterations)
# 		Filling queue...done.		0.164290085s
# 		Testing...done.
# 		Send msg:			0.447039757s total time
# 						4470 nsec/msg
# 		Recv msg:			0.406969759s total time
# 						4069 nsec/msg
# 		Draining queue...done.		0.125690234s
#=20
# 	Test #2c: Time send/recv message, queue full, decreasing prio
# :
# 		(100000 iterations)
# 		Filling queue...done.		0.152873072s
# 		Testing...done.
# 		Send msg:			0.454784232s total time
# 						4547 nsec/msg
# 		Recv msg:			0.415623102s total time
# 						4156 nsec/msg
# 		Draining queue...done.		0.144213045s
#=20
# 	Test #2d: Time send/recv message, queue full, random prio
# :
# 		(100000 iterations)
# 		Filling queue...done.		0.227809922s
# 		Testing...done.
# 		Send msg:			0.496218027s total time
# 						4962 nsec/msg
# 		Recv msg:			0.423822059s total time
# 						4238 nsec/msg
# 		Draining queue...done.		0.156378614s
ok 2 selftests: mqueue: mq_perf_tests
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047=
bf73353767d70a03db986600ca372a/tools/testing/selftests/mqueue'

2019-07-06 12:58:25 make run_tests -C net
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb304=
7bf73353767d70a03db986600ca372a/tools/testing/selftests/net'
make --no-builtin-rules ARCH=3Dx86 -C ../../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb=
3047bf73353767d70a03db986600ca372a'
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3=
047bf73353767d70a03db986600ca372a'
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseport=
_bpf.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf73353767d70a=
03db986600ca372a/tools/testing/selftests/net/reuseport_bpf
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseport=
_bpf_cpu.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf73353767=
d70a03db986600ca372a/tools/testing/selftests/net/reuseport_bpf_cpu
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseport=
_bpf_numa.c -lnuma -o /usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf7=
3353767d70a03db986600ca372a/tools/testing/selftests/net/reuseport_bpf_numa
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseport=
_dualstack.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf733537=
67d70a03db986600ca372a/tools/testing/selftests/net/reuseport_dualstack
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseaddr=
_conflict.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf7335376=
7d70a03db986600ca372a/tools/testing/selftests/net/reuseaddr_conflict
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    tls.c  -o=
 /usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf73353767d70a03db986600=
ca372a/tools/testing/selftests/net/tls
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    socket.c =
 -o /usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf73353767d70a03db986=
600ca372a/tools/testing/selftests/net/socket
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    psock_fan=
out.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf73353767d70a0=
3db986600ca372a/tools/testing/selftests/net/psock_fanout
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    psock_tpa=
cket.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf73353767d70a=
03db986600ca372a/tools/testing/selftests/net/psock_tpacket
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    msg_zeroc=
opy.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf73353767d70a0=
3db986600ca372a/tools/testing/selftests/net/msg_zerocopy
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseport=
_addr_any.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf7335376=
7d70a03db986600ca372a/tools/testing/selftests/net/reuseport_addr_any
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/  -lpthread  =
tcp_mmap.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf73353767=
d70a03db986600ca372a/tools/testing/selftests/net/tcp_mmap
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/  -lpthread  =
tcp_inq.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf73353767d=
70a03db986600ca372a/tools/testing/selftests/net/tcp_inq
tcp_inq.c: In function =E2=80=98main=E2=80=99:
tcp_inq.c:168:4: warning: dereferencing type-punned pointer will break stri=
ct-aliasing rules [-Wstrict-aliasing]
    inq =3D *((int *) CMSG_DATA(cm));
    ^~~
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    psock_snd=
=2Ec  -o /usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf73353767d70a03=
db986600ca372a/tools/testing/selftests/net/psock_snd
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    txring_ov=
erwrite.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf73353767d=
70a03db986600ca372a/tools/testing/selftests/net/txring_overwrite
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    udpgso.c =
 -o /usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf73353767d70a03db986=
600ca372a/tools/testing/selftests/net/udpgso
udpgso.c: In function =E2=80=98send_one=E2=80=99:
udpgso.c:483:3: warning: dereferencing type-punned pointer will break stric=
t-aliasing rules [-Wstrict-aliasing]
   *((uint16_t *) CMSG_DATA(cm)) =3D gso_len;
   ^
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    udpgso_be=
nch_tx.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf73353767d7=
0a03db986600ca372a/tools/testing/selftests/net/udpgso_bench_tx
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    udpgso_be=
nch_rx.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf73353767d7=
0a03db986600ca372a/tools/testing/selftests/net/udpgso_bench_rx
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    ip_defrag=
=2Ec  -o /usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf73353767d70a03=
db986600ca372a/tools/testing/selftests/net/ip_defrag
TAP version 13
1..26
# selftests: net: reuseport_bpf
# ---- IPv4 UDP ----
# Testing EBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing EBPF mod 20...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 10: 10
# Socket 11: 11
# Socket 12: 12
# Socket 13: 13
# Socket 14: 14
# Socket 15: 15
# Socket 16: 16
# Socket 17: 17
# Socket 18: 18
# Socket 19: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 10: 30
# Socket 11: 31
# Socket 12: 32
# Socket 13: 33
# Socket 14: 34
# Socket 15: 35
# Socket 16: 36
# Socket 17: 37
# Socket 18: 38
# Socket 19: 39
# Reprograming, testing mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 0: 30
# Socket 1: 31
# Socket 2: 32
# Socket 3: 33
# Socket 4: 34
# Socket 5: 35
# Socket 6: 36
# Socket 7: 37
# Socket 8: 38
# Socket 9: 39
# Testing CBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 20...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 10: 10
# Socket 11: 11
# Socket 12: 12
# Socket 13: 13
# Socket 14: 14
# Socket 15: 15
# Socket 16: 16
# Socket 17: 17
# Socket 18: 18
# Socket 19: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 10: 30
# Socket 11: 31
# Socket 12: 32
# Socket 13: 33
# Socket 14: 34
# Socket 15: 35
# Socket 16: 36
# Socket 17: 37
# Socket 18: 38
# Socket 19: 39
# Reprograming, testing mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 0: 30
# Socket 1: 31
# Socket 2: 32
# Socket 3: 33
# Socket 4: 34
# Socket 5: 35
# Socket 6: 36
# Socket 7: 37
# Socket 8: 38
# Socket 9: 39
# Testing too many filters...
# Testing filters on non-SO_REUSEPORT socket...
# ---- IPv6 UDP ----
# Testing EBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing EBPF mod 20...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 10: 10
# Socket 11: 11
# Socket 12: 12
# Socket 13: 13
# Socket 14: 14
# Socket 15: 15
# Socket 16: 16
# Socket 17: 17
# Socket 18: 18
# Socket 19: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 10: 30
# Socket 11: 31
# Socket 12: 32
# Socket 13: 33
# Socket 14: 34
# Socket 15: 35
# Socket 16: 36
# Socket 17: 37
# Socket 18: 38
# Socket 19: 39
# Reprograming, testing mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 0: 30
# Socket 1: 31
# Socket 2: 32
# Socket 3: 33
# Socket 4: 34
# Socket 5: 35
# Socket 6: 36
# Socket 7: 37
# Socket 8: 38
# Socket 9: 39
# Testing CBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 20...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 10: 10
# Socket 11: 11
# Socket 12: 12
# Socket 13: 13
# Socket 14: 14
# Socket 15: 15
# Socket 16: 16
# Socket 17: 17
# Socket 18: 18
# Socket 19: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 10: 30
# Socket 11: 31
# Socket 12: 32
# Socket 13: 33
# Socket 14: 34
# Socket 15: 35
# Socket 16: 36
# Socket 17: 37
# Socket 18: 38
# Socket 19: 39
# Reprograming, testing mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 0: 30
# Socket 1: 31
# Socket 2: 32
# Socket 3: 33
# Socket 4: 34
# Socket 5: 35
# Socket 6: 36
# Socket 7: 37
# Socket 8: 38
# Socket 9: 39
# Testing too many filters...
# Testing filters on non-SO_REUSEPORT socket...
# ---- IPv6 UDP w/ mapped IPv4 ----
# Testing EBPF mod 20...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 10: 10
# Socket 11: 11
# Socket 12: 12
# Socket 13: 13
# Socket 14: 14
# Socket 15: 15
# Socket 16: 16
# Socket 17: 17
# Socket 18: 18
# Socket 19: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 10: 30
# Socket 11: 31
# Socket 12: 32
# Socket 13: 33
# Socket 14: 34
# Socket 15: 35
# Socket 16: 36
# Socket 17: 37
# Socket 18: 38
# Socket 19: 39
# Reprograming, testing mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 0: 30
# Socket 1: 31
# Socket 2: 32
# Socket 3: 33
# Socket 4: 34
# Socket 5: 35
# Socket 6: 36
# Socket 7: 37
# Socket 8: 38
# Socket 9: 39
# Testing EBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 20...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 10: 10
# Socket 11: 11
# Socket 12: 12
# Socket 13: 13
# Socket 14: 14
# Socket 15: 15
# Socket 16: 16
# Socket 17: 17
# Socket 18: 18
# Socket 19: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 10: 30
# Socket 11: 31
# Socket 12: 32
# Socket 13: 33
# Socket 14: 34
# Socket 15: 35
# Socket 16: 36
# Socket 17: 37
# Socket 18: 38
# Socket 19: 39
# Reprograming, testing mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 0: 30
# Socket 1: 31
# Socket 2: 32
# Socket 3: 33
# Socket 4: 34
# Socket 5: 35
# Socket 6: 36
# Socket 7: 37
# Socket 8: 38
# Socket 9: 39
# ---- IPv4 TCP ----
# Testing EBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing too many filters...
# Testing filters on non-SO_REUSEPORT socket...
# ---- IPv6 TCP ----
# Testing EBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing too many filters...
# Testing filters on non-SO_REUSEPORT socket...
# ---- IPv6 TCP w/ mapped IPv4 ----
# Testing EBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing filter add without bind...
# SUCCESS
ok 1 selftests: net: reuseport_bpf
# selftests: net: reuseport_bpf_cpu
# ---- IPv4 UDP ----
# send cpu 0, receive socket 0
# send cpu 1, receive socket 1
# send cpu 1, receive socket 1
# send cpu 0, receive socket 0
# send cpu 0, receive socket 0
# send cpu 1, receive socket 1
# ---- IPv6 UDP ----
# send cpu 0, receive socket 0
# send cpu 1, receive socket 1
# send cpu 1, receive socket 1
# send cpu 0, receive socket 0
# send cpu 0, receive socket 0
# send cpu 1, receive socket 1
# ---- IPv4 TCP ----
# send cpu 0, receive socket 0
# send cpu 1, receive socket 1
# send cpu 1, receive socket 1
# send cpu 0, receive socket 0
# send cpu 0, receive socket 0
# send cpu 1, receive socket 1
# ---- IPv6 TCP ----
# send cpu 0, receive socket 0
# send cpu 1, receive socket 1
# send cpu 1, receive socket 1
# send cpu 0, receive socket 0
# send cpu 0, receive socket 0
# send cpu 1, receive socket 1
# SUCCESS
ok 2 selftests: net: reuseport_bpf_cpu
# selftests: net: reuseport_bpf_numa
# ---- IPv4 UDP ----
# send node 0, receive socket 0
# send node 0, receive socket 0
# ---- IPv6 UDP ----
# send node 0, receive socket 0
# send node 0, receive socket 0
# ---- IPv4 TCP ----
# send node 0, receive socket 0
# send node 0, receive socket 0
# ---- IPv6 TCP ----
# send node 0, receive socket 0
# send node 0, receive socket 0
# SUCCESS
ok 3 selftests: net: reuseport_bpf_numa
# selftests: net: reuseport_dualstack
# ---- UDP IPv4 created before IPv6 ----
# ---- UDP IPv6 created before IPv4 ----
# ---- UDP IPv4 created before IPv6 (large) ----
# ---- UDP IPv6 created before IPv4 (large) ----
# ---- TCP IPv4 created before IPv6 ----
# ---- TCP IPv6 created before IPv4 ----
# SUCCESS
ok 4 selftests: net: reuseport_dualstack
# selftests: net: reuseaddr_conflict
# Opening 127.0.0.1:9999
# Opening INADDR_ANY:9999
# bind: Address already in use
# Opening in6addr_any:9999
# Opening INADDR_ANY:9999
# bind: Address already in use
# Opening INADDR_ANY:9999 after closing ipv6 socket
# bind: Address already in use
# Successok 5 selftests: net: reuseaddr_conflict
# selftests: net: tls
# [=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] Running 33 tests from 2 test cases.
# [ RUN      ] tls.sendfile
# [       OK ] tls.sendfile
# [ RUN      ] tls.send_then_sendfile
# [       OK ] tls.send_then_sendfile
# [ RUN      ] tls.recv_max
# [       OK ] tls.recv_max
# [ RUN      ] tls.recv_small
# [       OK ] tls.recv_small
# [ RUN      ] tls.msg_more
# [       OK ] tls.msg_more
# [ RUN      ] tls.sendmsg_single
# [       OK ] tls.sendmsg_single
# [ RUN      ] tls.sendmsg_large
# [       OK ] tls.sendmsg_large
# [ RUN      ] tls.sendmsg_multiple
# [       OK ] tls.sendmsg_multiple
# [ RUN      ] tls.sendmsg_multiple_stress
# [       OK ] tls.sendmsg_multiple_stress
# [ RUN      ] tls.splice_from_pipe
# [       OK ] tls.splice_from_pipe
# [ RUN      ] tls.splice_from_pipe2
# [       OK ] tls.splice_from_pipe2
# [ RUN      ] tls.send_and_splice
# [       OK ] tls.send_and_splice
# [ RUN      ] tls.splice_to_pipe
# [       OK ] tls.splice_to_pipe
# [ RUN      ] tls.recvmsg_single
# [       OK ] tls.recvmsg_single
# [ RUN      ] tls.recvmsg_single_max
# [       OK ] tls.recvmsg_single_max
# [ RUN      ] tls.recvmsg_multiple
# [       OK ] tls.recvmsg_multiple
# [ RUN      ] tls.single_send_multiple_recv
# [       OK ] tls.single_send_multiple_recv
# [ RUN      ] tls.multiple_send_single_recv
# [       OK ] tls.multiple_send_single_recv
# [ RUN      ] tls.single_send_multiple_recv_non_align
# [       OK ] tls.single_send_multiple_recv_non_align
# [ RUN      ] tls.recv_partial
# [       OK ] tls.recv_partial
# [ RUN      ] tls.recv_nonblock
# [       OK ] tls.recv_nonblock
# [ RUN      ] tls.recv_peek
# [       OK ] tls.recv_peek
# [ RUN      ] tls.recv_peek_multiple
# [       OK ] tls.recv_peek_multiple
# [ RUN      ] tls.recv_peek_multiple_records
# [       OK ] tls.recv_peek_multiple_records
# [ RUN      ] tls.recv_peek_large_buf_mult_recs
# [       OK ] tls.recv_peek_large_buf_mult_recs
# [ RUN      ] tls.recv_lowat
# [       OK ] tls.recv_lowat
# [ RUN      ] tls.pollin
# [       OK ] tls.pollin
# [ RUN      ] tls.poll_wait
# [       OK ] tls.poll_wait
# [ RUN      ] tls.blocking
# [       OK ] tls.blocking
# [ RUN      ] tls.nonblocking
# [       OK ] tls.nonblocking
# [ RUN      ] tls.control_msg
# [       OK ] tls.control_msg
# [ RUN      ] global.keysizes
# [       OK ] global.keysizes
# [ RUN      ] global.tls12
# [       OK ] global.tls12
# [=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] 33 / 33 tests passed.
# [  PASSED  ]
ok 6 selftests: net: tls
# selftests: net: run_netsocktests
# --------------------
# running socket test
# --------------------
# [PASS]
ok 7 selftests: net: run_netsocktests
# selftests: net: run_afpackettests
# --------------------
# running psock_fanout test
# --------------------
# test: control single socket
# test: control multiple sockets
# test: unique ids
#=20
# test: datapath 0x0 ports 8000,8002
# info: count=3D0,0, expect=3D0,0
# info: count=3D20,0, expect=3D15,5
# warning: incorrect queue lengths
# info: count=3D20,0, expect=3D20,5
# warning: incorrect queue lengths
# info: trying alternate ports (20)
#=20
# test: datapath 0x0 ports 8000,8003
# info: count=3D0,0, expect=3D0,0
# info: count=3D15,5, expect=3D15,5
# info: count=3D20,5, expect=3D20,5
#=20
# test: datapath 0x1000 ports 8000,8003
# info: count=3D0,0, expect=3D0,0
# info: count=3D15,5, expect=3D15,5
# info: count=3D20,15, expect=3D20,15
#=20
# test: datapath 0x1 ports 8000,8003
# info: count=3D0,0, expect=3D0,0
# info: count=3D10,10, expect=3D10,10
# info: count=3D17,18, expect=3D18,17
#=20
# test: datapath 0x3 ports 8000,8003
# info: count=3D0,0, expect=3D0,0
# info: count=3D15,5, expect=3D15,5
# info: count=3D20,15, expect=3D20,15
#=20
# test: datapath 0x6 ports 8000,8003
# info: count=3D0,0, expect=3D0,0
# info: count=3D5,15, expect=3D15,5
# info: count=3D20,15, expect=3D15,20
#=20
# test: datapath 0x7 ports 8000,8003
# info: count=3D0,0, expect=3D0,0
# info: count=3D5,15, expect=3D15,5
# info: count=3D20,15, expect=3D15,20
#=20
# test: datapath 0x2 ports 8000,8003
# info: count=3D0,0, expect=3D0,0
# info: count=3D20,0, expect=3D20,0
# info: count=3D20,0, expect=3D20,0
#=20
# test: datapath 0x2 ports 8000,8003
# info: count=3D0,0, expect=3D0,0
# info: count=3D0,20, expect=3D0,20
# info: count=3D0,20, expect=3D0,20
#=20
# test: datapath 0x2000 ports 8000,8003
# info: count=3D0,0, expect=3D0,0
# info: count=3D20,20, expect=3D20,20
# info: count=3D20,20, expect=3D20,20
# OK. All tests passed
# [PASS]
# --------------------
# running psock_tpacket test
# --------------------
# test: TPACKET_V1 with PACKET_RX_RING .................... 100 pkts (14200=
 bytes)
# test: TPACKET_V1 with PACKET_TX_RING .................... 100 pkts (14200=
 bytes)
# test: TPACKET_V2 with PACKET_RX_RING .................... 100 pkts (14200=
 bytes)
# test: TPACKET_V2 with PACKET_TX_RING .................... 100 pkts (14200=
 bytes)
# test: TPACKET_V3 with PACKET_RX_RING .................... 100 pkts (14200=
 bytes)
# test: TPACKET_V3 with PACKET_TX_RING .................... 100 pkts (14200=
 bytes)
# OK. All tests passed
# [PASS]
# --------------------
# running txring_overwrite test
# --------------------
# read: a (0x61)
# read: b (0x62)
# [PASS]
ok 8 selftests: net: run_afpackettests
# selftests: net: test_bpf.sh
# test_bpf: ok
ok 9 selftests: net: test_bpf.sh
# selftests: net: netdevice.sh
# SKIP: eth0: interface already up
# Cannot get device udp-fragmentation-offload settings: Operation not suppo=
rted
# PASS: eth0: ethtool list features
# PASS: eth0: ethtool dump
# PASS: eth0: ethtool stats
# SKIP: eth0: interface kept up
ok 10 selftests: net: netdevice.sh
# selftests: net: rtnetlink.sh
# PASS: policy routing
# PASS: route get
# PASS: tc htb hierarchy
# PASS: gre tunnel endpoint
# PASS: gretap
# PASS: ip6gretap
# PASS: erspan
# PASS: ip6erspan
# PASS: bridge setup
# PASS: ipv6 addrlabel
# PASS: set ifalias 7d322295-9f10-4c22-8950-8000bdd10fe2 for test-dummy0
# PASS: vrf
# PASS: vxlan
# PASS: fou
# PASS: macsec
# PASS: ipsec
# FAIL: ipsec_offload netdevsim doesn't support IPsec offload
# SKIP: fdb get tests: iproute2 too old
# SKIP: fdb get tests: iproute2 too old
ok 11 selftests: net: rtnetlink.sh
# selftests: net: xfrm_policy.sh
# PASS: policy before exception matches
# PASS: ping to .254 bypassed ipsec tunnel (exceptions)
# PASS: direct policy matches (exceptions)
# PASS: policy matches (exceptions)
# PASS: ping to .254 bypassed ipsec tunnel (exceptions and block policies)
# PASS: direct policy matches (exceptions and block policies)
# PASS: policy matches (exceptions and block policies)
# PASS: ping to .254 bypassed ipsec tunnel (exceptions and block policies a=
fter hresh changes)
# PASS: direct policy matches (exceptions and block policies after hresh ch=
anges)
# PASS: policy matches (exceptions and block policies after hresh changes)
# PASS: ping to .254 bypassed ipsec tunnel (exceptions and block policies a=
fter hthresh change in ns3)
# PASS: direct policy matches (exceptions and block policies after hthresh =
change in ns3)
# PASS: policy matches (exceptions and block policies after hthresh change =
in ns3)
# PASS: ping to .254 bypassed ipsec tunnel (exceptions and block policies a=
fter hresh change to normal)
# PASS: direct policy matches (exceptions and block policies after hresh ch=
ange to normal)
# PASS: policy matches (exceptions and block policies after hresh change to=
 normal)
ok 12 selftests: net: xfrm_policy.sh
# selftests: net: fib_tests.sh
#=20
# Single path route test
#     Start point
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     Nexthop device deleted
#     TEST: IPv4 fibmatch - no route                                      [=
 OK ]
#     TEST: IPv6 fibmatch - no route                                      [=
 OK ]
#=20
# Multipath route test
#     Start point
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     One nexthop device deleted
#     TEST: IPv4 - multipath route removed on delete                      [=
 OK ]
#     TEST: IPv6 - multipath down to single path                          [=
 OK ]
#     Second nexthop device deleted
#     TEST: IPv6 - no route                                               [=
 OK ]
#=20
# Single path, admin down
#     Start point
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     Route deleted on down
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#=20
# Admin down multipath
#     Verify start point
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     One device down, one up
#     TEST: IPv4 fibmatch on down device                                  [=
 OK ]
#     TEST: IPv6 fibmatch on down device                                  [=
 OK ]
#     TEST: IPv4 fibmatch on up device                                    [=
 OK ]
#     TEST: IPv6 fibmatch on up device                                    [=
 OK ]
#     TEST: IPv4 flags on down device                                     [=
 OK ]
#     TEST: IPv6 flags on down device                                     [=
 OK ]
#     TEST: IPv4 flags on up device                                       [=
 OK ]
#     TEST: IPv6 flags on up device                                       [=
 OK ]
#     Other device down and up
#     TEST: IPv4 fibmatch on down device                                  [=
 OK ]
#     TEST: IPv6 fibmatch on down device                                  [=
 OK ]
#     TEST: IPv4 fibmatch on up device                                    [=
 OK ]
#     TEST: IPv6 fibmatch on up device                                    [=
 OK ]
#     TEST: IPv4 flags on down device                                     [=
 OK ]
#     TEST: IPv6 flags on down device                                     [=
 OK ]
#     TEST: IPv4 flags on up device                                       [=
 OK ]
#     TEST: IPv6 flags on up device                                       [=
 OK ]
#     Both devices down
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#=20
# Local carrier tests - single path
#     Start point
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     TEST: IPv4 - no linkdown flag                                       [=
 OK ]
#     TEST: IPv6 - no linkdown flag                                       [=
 OK ]
#     Carrier off on nexthop
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     TEST: IPv4 - linkdown flag set                                      [=
 OK ]
#     TEST: IPv6 - linkdown flag set                                      [=
 OK ]
#     Route to local address with carrier down
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     TEST: IPv4 linkdown flag set                                        [=
 OK ]
#     TEST: IPv6 linkdown flag set                                        [=
 OK ]
#=20
# Single path route carrier test
#     Start point
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     TEST: IPv4 no linkdown flag                                         [=
 OK ]
#     TEST: IPv6 no linkdown flag                                         [=
 OK ]
#     Carrier down
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     TEST: IPv4 linkdown flag set                                        [=
 OK ]
#     TEST: IPv6 linkdown flag set                                        [=
 OK ]
#     Second address added with carrier down
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     TEST: IPv4 linkdown flag set                                        [=
 OK ]
#     TEST: IPv6 linkdown flag set                                        [=
 OK ]
#=20
# IPv4 nexthop tests
# <<< write me >>>
#=20
# IPv6 nexthop tests
#     TEST: Directly connected nexthop, unicast address                   [=
 OK ]
#     TEST: Directly connected nexthop, unicast address with device       [=
 OK ]
#     TEST: Gateway is linklocal address                                  [=
 OK ]
#     TEST: Gateway is linklocal address, no device                       [=
 OK ]
#     TEST: Gateway can not be local unicast address                      [=
 OK ]
#     TEST: Gateway can not be local unicast address, with device         [=
 OK ]
#     TEST: Gateway can not be a local linklocal address                  [=
 OK ]
#     TEST: Gateway can be local address in a VRF                         [=
 OK ]
#     TEST: Gateway can be local address in a VRF, with device            [=
 OK ]
#     TEST: Gateway can be local linklocal address in a VRF               [=
 OK ]
#     TEST: Redirect to VRF lookup                                        [=
 OK ]
#     TEST: VRF route, gateway can be local address in default VRF        [=
 OK ]
#     TEST: VRF route, gateway can not be a local address                 [=
 OK ]
#     TEST: VRF route, gateway can not be a local addr with device        [=
 OK ]
#=20
# IPv6 route add / append tests
#     TEST: Attempt to add duplicate route - gw                           [=
 OK ]
#     TEST: Attempt to add duplicate route - dev only                     [=
 OK ]
#     TEST: Attempt to add duplicate route - reject route                 [=
 OK ]
#     TEST: Append nexthop to existing route - gw                         [=
 OK ]
#     TEST: Add multipath route                                           [=
 OK ]
#     TEST: Attempt to add duplicate multipath route                      [=
 OK ]
#     TEST: Route add with different metrics                              [=
 OK ]
#     TEST: Route delete with metric                                      [=
 OK ]
#=20
# IPv6 route replace tests
#     TEST: Single path with single path                                  [=
 OK ]
#     TEST: Single path with multipath                                    [=
 OK ]
#     TEST: Single path with single path via multipath attribute          [=
 OK ]
#     TEST: Invalid nexthop                                               [=
 OK ]
#     TEST: Single path - replace of non-existent route                   [=
 OK ]
#     TEST: Multipath with multipath                                      [=
 OK ]
#     TEST: Multipath with single path                                    [=
 OK ]
#     TEST: Multipath with single path via multipath attribute            [=
 OK ]
#     TEST: Multipath - invalid first nexthop                             [=
 OK ]
#     TEST: Multipath - invalid second nexthop                            [=
 OK ]
#     TEST: Multipath - replace of non-existent route                     [=
 OK ]
#=20
# IPv4 route add / append tests
#     TEST: Attempt to add duplicate route - gw                           [=
 OK ]
#     TEST: Attempt to add duplicate route - dev only                     [=
 OK ]
#     TEST: Attempt to add duplicate route - reject route                 [=
 OK ]
#     TEST: Add new nexthop for existing prefix                           [=
 OK ]
#     TEST: Append nexthop to existing route - gw                         [=
 OK ]
#     TEST: Append nexthop to existing route - dev only                   [=
 OK ]
#     TEST: Append nexthop to existing route - reject route               [=
 OK ]
#     TEST: Append nexthop to existing reject route - gw                  [=
 OK ]
#     TEST: Append nexthop to existing reject route - dev only            [=
 OK ]
#     TEST: add multipath route                                           [=
 OK ]
#     TEST: Attempt to add duplicate multipath route                      [=
 OK ]
#     TEST: Route add with different metrics                              [=
 OK ]
#     TEST: Route delete with metric                                      [=
 OK ]
#=20
# IPv4 route replace tests
#     TEST: Single path with single path                                  [=
 OK ]
#     TEST: Single path with multipath                                    [=
 OK ]
#     TEST: Single path with reject route                                 [=
 OK ]
#     TEST: Single path with single path via multipath attribute          [=
 OK ]
#     TEST: Invalid nexthop                                               [=
 OK ]
#     TEST: Single path - replace of non-existent route                   [=
 OK ]
#     TEST: Multipath with multipath                                      [=
 OK ]
#     TEST: Multipath with single path                                    [=
 OK ]
#     TEST: Multipath with single path via multipath attribute            [=
 OK ]
#     TEST: Multipath with reject route                                   [=
 OK ]
#     TEST: Multipath - invalid first nexthop                             [=
 OK ]
#     TEST: Multipath - invalid second nexthop                            [=
 OK ]
#     TEST: Multipath - replace of non-existent route                     [=
 OK ]
#=20
# IPv6 prefix route tests
#     TEST: Default metric                                                [=
 OK ]
#     TEST: User specified metric on first device                         [=
 OK ]
#     TEST: User specified metric on second device                        [=
 OK ]
#     TEST: Delete of address on first device                             [=
 OK ]
#     TEST: Modify metric of address                                      [=
 OK ]
#     TEST: Prefix route removed on link down                             [=
 OK ]
#     TEST: Prefix route with metric on link up                           [=
 OK ]
#=20
# IPv4 prefix route tests
#     TEST: Default metric                                                [=
 OK ]
#     TEST: User specified metric on first device                         [=
 OK ]
#     TEST: User specified metric on second device                        [=
 OK ]
#     TEST: Delete of address on first device                             [=
 OK ]
#     TEST: Modify metric of address                                      [=
 OK ]
#     TEST: Prefix route removed on link down                             [=
 OK ]
#     TEST: Prefix route with metric on link up                           [=
 OK ]
#=20
# IPv6 routes with metrics
#     TEST: Single path route with mtu metric                             [=
 OK ]
#     TEST: Multipath route via 2 single routes with mtu metric on first  [=
 OK ]
#     TEST: Multipath route via 2 single routes with mtu metric on 2nd    [=
 OK ]
#     TEST:     MTU of second leg                                         [=
 OK ]
#     TEST: Multipath route with mtu metric                               [=
 OK ]
#     TEST: Using route with mtu metric                                   [=
 OK ]
#     TEST: Invalid metric (fails metric_convert)                         [=
 OK ]
#=20
# IPv4 route add / append tests
#     TEST: Single path route with mtu metric                             [=
 OK ]
#     TEST: Multipath route with mtu metric                               [=
 OK ]
#     TEST: Using route with mtu metric                                   [=
 OK ]
#     TEST: Invalid metric (fails metric_convert)                         [=
 OK ]
#=20
# IPv4 route with IPv6 gateway tests
#     TEST: Single path route with IPv6 gateway                           [=
 OK ]
#     TEST: Single path route with IPv6 gateway - ping                    [=
 OK ]
#     TEST: Single path route delete                                      [=
 OK ]
#     TEST: Multipath route add - v6 nexthop then v4                      [=
 OK ]
#     TEST:     Multipath route delete - nexthops in wrong order          [=
 OK ]
#     TEST:     Multipath route delete exact match                        [=
 OK ]
#     TEST: Multipath route add - v4 nexthop then v6                      [=
 OK ]
#     TEST:     Multipath route delete - nexthops in wrong order          [=
 OK ]
#     TEST:     Multipath route delete exact match                        [=
 OK ]
#=20
# Tests passed: 150
# Tests failed:   0
ok 13 selftests: net: fib_tests.sh
# selftests: net: fib-onlink-tests.sh
#=20
# ########################################
# Configuring interfaces
# Error: netdevsim: Exceeded number of supported fib entries.
not ok 14 selftests: net: fib-onlink-tests.sh
# selftests: net: pmtu.sh
# Error: Nexthop has invalid gateway.
# Error: Nexthop has invalid gateway.
# Error: Nexthop has invalid gateway.
# RTNETLINK answers: Network is unreachable
# TEST: ipv4: PMTU exceptions                                         [FAIL]
#   PMTU exception wasn't created after exceeding MTU
# Error: Nexthop has invalid gateway.
# Error: Nexthop has invalid gateway.
# Error: Nexthop has invalid gateway.
# TEST: ipv6: PMTU exceptions                                         [ OK ]
# Error: Nexthop has invalid gateway.
# Error: Nexthop has invalid gateway.
# Error: Nexthop has invalid gateway.
# RTNETLINK answers: Network is unreachable
# TEST: IPv4 over vxlan4: PMTU exceptions                             [FAIL]
#   PMTU exception wasn't created after exceeding link layer MTU on vxlan i=
nterface
# Error: Nexthop has invalid gateway.
# Error: Nexthop has invalid gateway.
# Error: Nexthop has invalid gateway.
# TEST: IPv6 over vxlan4: PMTU exceptions                             [FAIL]
#   PMTU exception wasn't created after exceeding link layer MTU on vxlan i=
nterface
# Error: Nexthop has invalid gateway.
# Error: Nexthop has invalid gateway.
# Error: Nexthop has invalid gateway.
# RTNETLINK answers: Network is unreachable
# TEST: IPv4 over vxlan6: PMTU exceptions                             [FAIL]
#   PMTU exception wasn't created after exceeding link layer MTU on vxlan i=
nterface
# Error: Nexthop has invalid gateway.
# Error: Nexthop has invalid gateway.
# Error: Nexthop has invalid gateway.
# TEST: IPv6 over vxlan6: PMTU exceptions                             [ OK ]
# Error: Nexthop has invalid gateway.
# Error: Nexthop has invalid gateway.
# Error: Nexthop has invalid gateway.
# RTNETLINK answers: Network is unreachable
# TEST: IPv4 over geneve4: PMTU exceptions                            [FAIL]
#   PMTU exception wasn't created after exceeding link layer MTU on geneve =
interface
# Error: Nexthop has invalid gateway.
# Error: Nexthop has invalid gateway.
# Error: Nexthop has invalid gateway.
# TEST: IPv6 over geneve4: PMTU exceptions                            [FAIL]
#   PMTU exception wasn't created after exceeding link layer MTU on geneve =
interface
# Error: Nexthop has invalid gateway.
# Error: Nexthop has invalid gateway.
# Error: Nexthop has invalid gateway.
# RTNETLINK answers: Network is unreachable
# TEST: IPv4 over geneve6: PMTU exceptions                            [FAIL]
#   PMTU exception wasn't created after exceeding link layer MTU on geneve =
interface
# Error: Nexthop has invalid gateway.
# Error: Nexthop has invalid gateway.
# Error: Nexthop has invalid gateway.
# TEST: IPv6 over geneve6: PMTU exceptions                            [ OK ]
# Error: Nexthop has invalid gateway.
# Error: Nexthop has invalid gateway.
# Error: Nexthop has invalid gateway.
# RTNETLINK answers: Network is unreachable
# TEST: IPv4 over fou4: PMTU exceptions                               [FAIL]
#   PMTU exception wasn't created after exceeding link layer MTU on fou int=
erface
# Error: Nexthop has invalid gateway.
# Error: Nexthop has invalid gateway.
# Error: Nexthop has invalid gateway.
# TEST: IPv6 over fou4: PMTU exceptions                               [FAIL]
#   PMTU exception wasn't created after exceeding link layer MTU on fou int=
erface
# Error: Nexthop has invalid gateway.
# Error: Nexthop has invalid gateway.
# Error: Nexthop has invalid gateway.
# RTNETLINK answers: Network is unreachable
# TEST: IPv4 over fou6: PMTU exceptions                               [FAIL]
#   PMTU exception wasn't created after exceeding link layer MTU on fou int=
erface
# Error: Nexthop has invalid gateway.
# Error: Nexthop has invalid gateway.
# Error: Nexthop has invalid gateway.
# TEST: IPv6 over fou6: PMTU exceptions                               [ OK ]
# Error: Nexthop has invalid gateway.
# Error: Nexthop has invalid gateway.
# Error: Nexthop has invalid gateway.
# RTNETLINK answers: Network is unreachable
# TEST: IPv4 over gue4: PMTU exceptions                               [FAIL]
#   PMTU exception wasn't created after exceeding link layer MTU on gue int=
erface
# Error: Nexthop has invalid gateway.
# Error: Nexthop has invalid gateway.
# Error: Nexthop has invalid gateway.
# TEST: IPv6 over gue4: PMTU exceptions                               [FAIL]
#   PMTU exception wasn't created after exceeding link layer MTU on gue int=
erface
# Error: Nexthop has invalid gateway.
# Error: Nexthop has invalid gateway.
# Error: Nexthop has invalid gateway.
# RTNETLINK answers: Network is unreachable
# TEST: IPv4 over gue6: PMTU exceptions                               [FAIL]
#   PMTU exception wasn't created after exceeding link layer MTU on gue int=
erface
# Error: Nexthop has invalid gateway.
# Error: Nexthop has invalid gateway.
# Error: Nexthop has invalid gateway.
# TEST: IPv6 over gue6: PMTU exceptions                               [ OK ]
# TEST: vti6: PMTU exceptions                                         [ OK ]
# RTNETLINK answers: Network is unreachable
# RTNETLINK answers: Network is unreachable
# TEST: vti4: PMTU exceptions                                         [FAIL]
#   PMTU exception wasn't created after exceeding PMTU (IP payload length 1=
447)
# TEST: vti4: default MTU assignment                                  [ OK ]
# TEST: vti6: default MTU assignment                                  [ OK ]
# TEST: vti4: MTU setting on link creation                            [ OK ]
# TEST: vti6: MTU setting on link creation                            [ OK ]
# TEST: vti6: MTU changes on link changes                             [ OK ]
# Error: Nexthop has invalid gateway.
# Error: Nexthop has invalid gateway.
# Error: Nexthop has invalid gateway.
# TEST: ipv4: cleanup of cached exceptions                            [ OK ]
# Error: Nexthop has invalid gateway.
# Error: Nexthop has invalid gateway.
# Error: Nexthop has invalid gateway.
# TEST: ipv6: cleanup of cached exceptions                            [ OK ]
not ok 15 selftests: net: pmtu.sh
# selftests: net: udpgso.sh
# ipv4 cmsg
# ./udpgso: bind: Cannot assign requested address
# ipv4 setsockopt
# ./udpgso: bind: Cannot assign requested address
# ipv6 cmsg
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv6 tx:1 gso:0=20
# ipv6 tx:1452 gso:0=20
# ipv6 tx:1453 gso:0 (fail)
# ipv6 tx:1452 gso:1452 (fail)
# ipv6 tx:1453 gso:1452=20
# ipv6 tx:2904 gso:1452=20
# ipv6 tx:2905 gso:1452=20
# ipv6 tx:65340 gso:1452=20
# ipv6 tx:65527 gso:1452=20
# ipv6 tx:65528 gso:1452 (fail)
# ipv6 tx:1 gso:1 (fail)
# ipv6 tx:2 gso:1=20
# ipv6 tx:5 gso:2=20
# ipv6 tx:16 gso:1=20
# ipv6 tx:17 gso:1 (fail)
# OK
# ipv6 setsockopt
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv6 tx:1 gso:0=20
# ipv6 tx:1452 gso:0=20
# ipv6 tx:1453 gso:0 (fail)
# ipv6 tx:1452 gso:1452 (fail)
# ipv6 tx:1453 gso:1452=20
# ipv6 tx:2904 gso:1452=20
# ipv6 tx:2905 gso:1452=20
# ipv6 tx:65340 gso:1452=20
# ipv6 tx:65527 gso:1452=20
# ipv6 tx:65528 gso:1452 (fail)
# ipv6 tx:1 gso:1 (fail)
# ipv6 tx:2 gso:1=20
# ipv6 tx:5 gso:2=20
# ipv6 tx:16 gso:1=20
# ipv6 tx:17 gso:1 (fail)
# OK
# ipv4 connected
# ./udpgso: bind: Cannot assign requested address
# ipv4 msg_more
# ./udpgso: bind: Cannot assign requested address
# ipv6 msg_more
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv6 tx:1 gso:0=20
# ipv6 tx:1452 gso:0=20
# ipv6 tx:1453 gso:0 (fail)
# ipv6 tx:1452 gso:1452 (fail)
# ipv6 tx:1453 gso:1452=20
# ipv6 tx:2904 gso:1452=20
# ipv6 tx:2905 gso:1452=20
# ipv6 tx:65340 gso:1452=20
# ipv6 tx:65527 gso:1452=20
# ipv6 tx:65528 gso:1452 (fail)
# ipv6 tx:1 gso:1 (fail)
# ipv6 tx:2 gso:1=20
# ipv6 tx:5 gso:2=20
# ipv6 tx:16 gso:1=20
# ipv6 tx:17 gso:1 (fail)
# OK
ok 16 selftests: net: udpgso.sh
# selftests: net: ip_defrag.sh
not ok 17 selftests: net: ip_defrag.sh
# selftests: net: udpgso_bench.sh
# ipv4
# tcp
# ./udpgso_bench_tx: connect: Network is unreachable
# tcp zerocopy
# ./udpgso_bench_tx: connect: Network is unreachable
# udp
# ./udpgso_bench_tx: connect: Network is unreachable
# udp gso
# ./udpgso_bench_tx: connect: Network is unreachable
# udp gso zerocopy
# ./udpgso_bench_tx: connect: Network is unreachable
# ipv6
# tcp
# ./udpgso_bench_tx: connect: Network is unreachable
# tcp zerocopy
# ./udpgso_bench_tx: connect: Network is unreachable
# udp
# udp rx:    121 MB/s    88435 calls/s
# udp tx:    142 MB/s   103974 calls/s   2418 msg/s
# udp rx:    150 MB/s   109598 calls/s
# udp tx:    170 MB/s   124184 calls/s   2888 msg/s
# udp rx:    144 MB/s   105370 calls/s
# udp tx:    147 MB/s   107457 calls/s   2499 msg/s
# udp rx:    162 MB/s   118184 calls/s
# udp gso
# udp rx:    517 MB/s   377375 calls/s
# udp tx:    567 MB/s     9633 calls/s   9633 msg/s
# udp rx:    439 MB/s   320227 calls/s
# udp tx:    505 MB/s     8580 calls/s   8580 msg/s
# udp rx:    560 MB/s   408331 calls/s
# udp tx:    626 MB/s    10624 calls/s  10624 msg/s
# udp rx:    313 MB/s   228447 calls/s
# udp gso zerocopy
# udp rx:    307 MB/s   224382 calls/s
# udp tx:    381 MB/s     6472 calls/s   6472 msg/s
# udp rx:    331 MB/s   241943 calls/s
# udp tx:    404 MB/s     6853 calls/s   6853 msg/s
# udp rx:    330 MB/s   241317 calls/s
# udp tx:    418 MB/s     7106 calls/s   7106 msg/s
# udp rx:    388 MB/s   283618 calls/s
ok 18 selftests: net: udpgso_bench.sh
# selftests: net: fib_rule_tests.sh
#=20
# ######################################################################
# TEST SECTION: IPv4 fib rule
# ######################################################################
# Error: netdevsim: Exceeded number of supported fib entries.
#=20
#     TEST: rule4 check: oif dummy0                             [FAIL]
#=20
#     TEST: rule4 del by pref: oif dummy0                       [ OK ]
# net.ipv4.ip_forward =3D 1
# net.ipv4.conf.dummy0.rp_filter =3D 0
# RTNETLINK answers: Network is unreachable
#=20
#     TEST: rule4 check: from 192.51.100.3 iif dummy0           [FAIL]
#=20
#     TEST: rule4 del by pref: from 192.51.100.3 iif dummy0     [ OK ]
# net.ipv4.ip_forward =3D 0
# RTNETLINK answers: Network is unreachable
#=20
#     TEST: rule4 check: tos 0x10                               [FAIL]
#=20
#     TEST: rule4 del by pref: tos 0x10                         [ OK ]
# RTNETLINK answers: Network is unreachable
#=20
#     TEST: rule4 check: fwmark 0x64                            [FAIL]
#=20
#     TEST: rule4 del by pref: fwmark 0x64                      [ OK ]
# RTNETLINK answers: Network is unreachable
#=20
#     TEST: rule4 check: uidrange 100-100                       [FAIL]
#=20
#     TEST: rule4 del by pref: uidrange 100-100                 [ OK ]
# RTNETLINK answers: Network is unreachable
#=20
#     TEST: rule4 check: sport 666 dport 777                    [FAIL]
#=20
#     TEST: rule4 del by pref: sport 666 dport 777              [ OK ]
# RTNETLINK answers: Network is unreachable
#=20
#     TEST: rule4 check: ipproto tcp                            [FAIL]
#=20
#     TEST: rule4 del by pref: ipproto tcp                      [ OK ]
# RTNETLINK answers: Network is unreachable
#=20
#     TEST: rule4 check: ipproto icmp                           [FAIL]
#=20
#     TEST: rule4 del by pref: ipproto icmp                     [ OK ]
#=20
# ######################################################################
# TEST SECTION: IPv6 fib rule
# ######################################################################
#=20
#     TEST: rule6 check: oif dummy0                             [ OK ]
#=20
#     TEST: rule6 del by pref: oif dummy0                       [ OK ]
#=20
#     TEST: rule6 check: from 2001:db8:1::3 iif dummy0          [ OK ]
#=20
#     TEST: rule6 del by pref: from 2001:db8:1::3 iif dummy0    [ OK ]
#=20
#     TEST: rule6 check: tos 0x10                               [ OK ]
#=20
#     TEST: rule6 del by pref: tos 0x10                         [ OK ]
#=20
#     TEST: rule6 check: fwmark 0x64                            [ OK ]
#=20
#     TEST: rule6 del by pref: fwmark 0x64                      [ OK ]
#=20
#     TEST: rule6 check: uidrange 100-100                       [ OK ]
#=20
#     TEST: rule6 del by pref: uidrange 100-100                 [ OK ]
#=20
#     TEST: rule6 check: sport 666 dport 777                    [ OK ]
#=20
#     TEST: rule6 del by pref: sport 666 dport 777              [ OK ]
#=20
#     TEST: rule6 check: ipproto tcp                            [ OK ]
#=20
#     TEST: rule6 del by pref: ipproto tcp                      [ OK ]
#=20
#     TEST: rule6 check: ipproto ipv6-icmp                      [ OK ]
#=20
#     TEST: rule6 del by pref: ipproto ipv6-icmp                [ OK ]
#=20
# Tests passed:  24
# Tests failed:   8
not ok 19 selftests: net: fib_rule_tests.sh
# selftests: net: msg_zerocopy.sh
# ipv4 tcp -t 1
# ./msg_zerocopy: setaffinity 2
# ./msg_zerocopy: setaffinity 3
not ok 20 selftests: net: msg_zerocopy.sh
# selftests: net: psock_snd.sh
# dgram
# tx: 128
# rx: 142
# ./psock_snd: recv: Resource temporarily unavailable
not ok 21 selftests: net: psock_snd.sh
# selftests: net: udpgro_bench.sh
# Missing xdp_dummy helper. Build bpf selftest first
not ok 22 selftests: net: udpgro_bench.sh
# selftests: net: udpgro.sh
# Missing xdp_dummy helper. Build bpf selftest first
not ok 23 selftests: net: udpgro.sh
# selftests: net: test_vxlan_under_vrf.sh
# Checking HV connectivity                                           [FAIL]
# Cannot remove namespace file "/var/run/netns/vm-1": No such file or direc=
tory
# Cannot remove namespace file "/var/run/netns/vm-2": No such file or direc=
tory
not ok 24 selftests: net: test_vxlan_under_vrf.sh
# selftests: net: reuseport_addr_any.sh
# UDP IPv4 ... ./reuseport_addr_any: failed to bind receive socket: Cannot =
assign requested address
not ok 25 selftests: net: reuseport_addr_any.sh
# selftests: net: test_vxlan_fdb_changelink.sh
# expected two remotes after fdb append	[ OK ]
# expected two remotes after link set	[ OK ]
ok 26 selftests: net: test_vxlan_fdb_changelink.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047=
bf73353767d70a03db986600ca372a/tools/testing/selftests/net'

2019-07-06 13:01:47 make run_tests -C netfilter
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb304=
7bf73353767d70a03db986600ca372a/tools/testing/selftests/netfilter'
TAP version 13
1..5
# selftests: netfilter: nft_trans_stress.sh
# SKIP: Could not run test without nft tool
not ok 1 selftests: netfilter: nft_trans_stress.sh # SKIP
# selftests: netfilter: nft_nat.sh
# SKIP: Could not run test without nft tool
not ok 2 selftests: netfilter: nft_nat.sh # SKIP
# selftests: netfilter: bridge_brouter.sh
# SKIP: Could not run test without ebtables
not ok 3 selftests: netfilter: bridge_brouter.sh # SKIP
# selftests: netfilter: conntrack_icmp_related.sh
# SKIP: Could not run test without nft tool
not ok 4 selftests: netfilter: conntrack_icmp_related.sh # SKIP
# selftests: netfilter: nft_flowtable.sh
# SKIP: Could not run test without nft tool
not ok 5 selftests: netfilter: nft_flowtable.sh # SKIP
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047=
bf73353767d70a03db986600ca372a/tools/testing/selftests/netfilter'

2019-07-06 13:01:47 make run_tests -C nsfs
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb304=
7bf73353767d70a03db986600ca372a/tools/testing/selftests/nsfs'
gcc -Wall -Werror    owner.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-cd=
5bbb3047bf73353767d70a03db986600ca372a/tools/testing/selftests/nsfs/owner
gcc -Wall -Werror    pidns.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-cd=
5bbb3047bf73353767d70a03db986600ca372a/tools/testing/selftests/nsfs/pidns
TAP version 13
1..2
# selftests: nsfs: owner
ok 1 selftests: nsfs: owner
# selftests: nsfs: pidns
ok 2 selftests: nsfs: pidns
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047=
bf73353767d70a03db986600ca372a/tools/testing/selftests/nsfs'

2019-07-06 13:01:48 make run_tests -C pidfd
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb304=
7bf73353767d70a03db986600ca372a/tools/testing/selftests/pidfd'
gcc -g -I../../../../usr/include/    pidfd_test.c  -o /usr/src/perf_selftes=
ts-x86_64-rhel-7.6-cd5bbb3047bf73353767d70a03db986600ca372a/tools/testing/s=
elftests/pidfd/pidfd_test
TAP version 13
1..1
# selftests: pidfd: pidfd_test
# TAP version 13
# 1..4
# ok 1 pidfd_send_signal check for support test: pidfd_send_signal() syscal=
l is supported. Tests can be executed
# ok 2 pidfd_send_signal send SIGUSR1 test: Sent signal
# ok 3 pidfd_send_signal signal exited process test: Failed to send signal =
as expected
# ok 4 pidfd_send_signal signal recycled pid test: Failed to signal recycle=
d pid as expected
# # Pass 4 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
ok 1 selftests: pidfd: pidfd_test
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047=
bf73353767d70a03db986600ca372a/tools/testing/selftests/pidfd'
ignored_by_lkp powerpc test
prctl test: not in Makefile
2019-07-06 13:02:02 make TARGETS=3Dprctl
make --no-builtin-rules ARCH=3Dx86 -C ../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb=
3047bf73353767d70a03db986600ca372a'
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3=
047bf73353767d70a03db986600ca372a'
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb=
3047bf73353767d70a03db986600ca372a/tools/testing/selftests/prctl'
Makefile:14: warning: overriding recipe for target 'clean'
=2E./lib.mk:123: warning: ignoring old recipe for target 'clean'
gcc     disable-tsc-ctxt-sw-stress-test.c   -o disable-tsc-ctxt-sw-stress-t=
est
gcc     disable-tsc-on-off-stress-test.c   -o disable-tsc-on-off-stress-test
gcc     disable-tsc-test.c   -o disable-tsc-test
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3=
047bf73353767d70a03db986600ca372a/tools/testing/selftests/prctl'

2019-07-06 13:02:05 make run_tests -C prctl
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb304=
7bf73353767d70a03db986600ca372a/tools/testing/selftests/prctl'
Makefile:14: warning: overriding recipe for target 'clean'
=2E./lib.mk:123: warning: ignoring old recipe for target 'clean'
TAP version 13
1..3
# selftests: prctl: disable-tsc-ctxt-sw-stress-test
# [No further output means we're allright]
ok 1 selftests: prctl: disable-tsc-ctxt-sw-stress-test
# selftests: prctl: disable-tsc-on-off-stress-test
# [No further output means we're allright]
ok 2 selftests: prctl: disable-tsc-on-off-stress-test
# selftests: prctl: disable-tsc-test
# rdtsc() =3D=3D 994864301214
# prctl(PR_GET_TSC, &tsc_val); tsc_val =3D=3D PR_TSC_ENABLE
# rdtsc() =3D=3D 994864551859
# prctl(PR_SET_TSC, PR_TSC_ENABLE)
# rdtsc() =3D=3D 994864563769
# prctl(PR_SET_TSC, PR_TSC_SIGSEGV)
# rdtsc() =3D=3D [ SIG_SEGV ]
# prctl(PR_GET_TSC, &tsc_val); tsc_val =3D=3D PR_TSC_SIGSEGV
# prctl(PR_SET_TSC, PR_TSC_ENABLE)
# rdtsc() =3D=3D 994864698547
ok 3 selftests: prctl: disable-tsc-test
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047=
bf73353767d70a03db986600ca372a/tools/testing/selftests/prctl'

2019-07-06 13:02:26 make run_tests -C proc
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb304=
7bf73353767d70a03db986600ca372a/tools/testing/selftests/proc'
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    fd-001-lookup.c  -o /us=
r/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf73353767d70a03db986600ca37=
2a/tools/testing/selftests/proc/fd-001-lookup
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    fd-002-posix-eq.c  -o /=
usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf73353767d70a03db986600ca=
372a/tools/testing/selftests/proc/fd-002-posix-eq
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    fd-003-kthread.c  -o /u=
sr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf73353767d70a03db986600ca3=
72a/tools/testing/selftests/proc/fd-003-kthread
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-loadavg-001.c  -o =
/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf73353767d70a03db986600c=
a372a/tools/testing/selftests/proc/proc-loadavg-001
proc-loadavg-001.c:17:0: warning: "_GNU_SOURCE" redefined
 #define _GNU_SOURCE
=20
<command-line>:0:0: note: this is the location of the previous definition
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-pid-vm.c  -o /usr/=
src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf73353767d70a03db986600ca372a=
/tools/testing/selftests/proc/proc-pid-vm
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-self-map-files-001=
=2Ec  -o /usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf73353767d70a03=
db986600ca372a/tools/testing/selftests/proc/proc-self-map-files-001
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-self-map-files-002=
=2Ec  -o /usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf73353767d70a03=
db986600ca372a/tools/testing/selftests/proc/proc-self-map-files-002
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-self-syscall.c  -o=
 /usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf73353767d70a03db986600=
ca372a/tools/testing/selftests/proc/proc-self-syscall
proc-self-syscall.c:16:0: warning: "_GNU_SOURCE" redefined
 #define _GNU_SOURCE
=20
<command-line>:0:0: note: this is the location of the previous definition
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-self-wchan.c  -o /=
usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf73353767d70a03db986600ca=
372a/tools/testing/selftests/proc/proc-self-wchan
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-uptime-001.c  -o /=
usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf73353767d70a03db986600ca=
372a/tools/testing/selftests/proc/proc-uptime-001
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-uptime-002.c  -o /=
usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf73353767d70a03db986600ca=
372a/tools/testing/selftests/proc/proc-uptime-002
proc-uptime-002.c:18:0: warning: "_GNU_SOURCE" redefined
 #define _GNU_SOURCE
=20
<command-line>:0:0: note: this is the location of the previous definition
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    read.c  -o /usr/src/per=
f_selftests-x86_64-rhel-7.6-cd5bbb3047bf73353767d70a03db986600ca372a/tools/=
testing/selftests/proc/read
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    self.c  -o /usr/src/per=
f_selftests-x86_64-rhel-7.6-cd5bbb3047bf73353767d70a03db986600ca372a/tools/=
testing/selftests/proc/self
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    setns-dcache.c  -o /usr=
/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf73353767d70a03db986600ca372=
a/tools/testing/selftests/proc/setns-dcache
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    thread-self.c  -o /usr/=
src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf73353767d70a03db986600ca372a=
/tools/testing/selftests/proc/thread-self
TAP version 13
1..15
# selftests: proc: fd-001-lookup
ok 1 selftests: proc: fd-001-lookup
# selftests: proc: fd-002-posix-eq
ok 2 selftests: proc: fd-002-posix-eq
# selftests: proc: fd-003-kthread
ok 3 selftests: proc: fd-003-kthread
# selftests: proc: proc-loadavg-001
ok 4 selftests: proc: proc-loadavg-001
# selftests: proc: proc-pid-vm
ok 5 selftests: proc: proc-pid-vm
# selftests: proc: proc-self-map-files-001
ok 6 selftests: proc: proc-self-map-files-001
# selftests: proc: proc-self-map-files-002
ok 7 selftests: proc: proc-self-map-files-002
# selftests: proc: proc-self-syscall
ok 8 selftests: proc: proc-self-syscall
# selftests: proc: proc-self-wchan
ok 9 selftests: proc: proc-self-wchan
# selftests: proc: proc-uptime-001
ok 10 selftests: proc: proc-uptime-001
# selftests: proc: proc-uptime-002
ok 11 selftests: proc: proc-uptime-002
# selftests: proc: read
ok 12 selftests: proc: read
# selftests: proc: self
ok 13 selftests: proc: self
# selftests: proc: setns-dcache
ok 14 selftests: proc: setns-dcache
# selftests: proc: thread-self
ok 15 selftests: proc: thread-self
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047=
bf73353767d70a03db986600ca372a/tools/testing/selftests/proc'

2019-07-06 13:02:33 make run_tests -C pstore
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb304=
7bf73353767d70a03db986600ca372a/tools/testing/selftests/pstore'
TAP version 13
1..2
# selftests: pstore: pstore_tests
# =3D=3D=3D Pstore unit tests (pstore_tests) =3D=3D=3D
# UUID=3Dd5d4d328-eeb2-498b-9a82-98e73b6ea1d1
# Checking pstore backend is registered ... ok
# 	backend=3Dramoops
# 	cmdline=3Dip=3D::::vm-snb-8G-414::dhcp root=3D/dev/ram0 user=3Dlkp job=
=3D/lkp/jobs/scheduled/vm-snb-8G-414/kernel_selftests-kselftests-02-debian-=
x86_64-2018-04-03.cgz-cd5bbb30-20190706-7286-azbicy-8.yaml ARCH=3Dx86_64 kc=
onfig=3Dx86_64-rhel-7.6 branch=3Dlinux-devel/devel-catchup-201907030021 com=
mit=3Dcd5bbb3047bf73353767d70a03db986600ca372a BOOT_IMAGE=3D/pkg/linux/x86_=
64-rhel-7.6/gcc-7/cd5bbb3047bf73353767d70a03db986600ca372a/vmlinuz-5.2.0-rc=
4-00289-gcd5bbb3047bf7 erst_disable max_uptime=3D3600 RESULT_ROOT=3D/result=
/kernel_selftests/kselftests-02/vm-snb-8G/debian-x86_64-2018-04-03.cgz/x86_=
64-rhel-7.6/gcc-7/cd5bbb3047bf73353767d70a03db986600ca372a/8 LKP_SERVER=3Di=
nn debug apic=3Ddebug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=
=3D100 net.ifnames=3D0 printk.devkmsg=3Don panic=3D-1 softlockup_panic=3D1 =
nmi_watchdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 drbd.=
minor_count=3D8 systemd.log_level=3Derr ignore_loglevel console=3Dtty0 earl=
yprintk=3DttyS0,115200 console=3DttyS0,115200 vga=3Dnormal rw rcuperf.shutd=
own=3D0
# Checking pstore console is registered ... ok
# Checking /dev/pmsg0 exists ... ok
# Writing unique string to /dev/pmsg0 ... ok
ok 1 selftests: pstore: pstore_tests
# selftests: pstore: pstore_post_reboot_tests
# =3D=3D=3D Pstore unit tests (pstore_post_reboot_tests) =3D=3D=3D
# UUID=3D2d542220-c996-4eee-9833-4b03a6f11268
# Checking pstore backend is registered ... ok
# 	backend=3Dramoops
# 	cmdline=3Dip=3D::::vm-snb-8G-414::dhcp root=3D/dev/ram0 user=3Dlkp job=
=3D/lkp/jobs/scheduled/vm-snb-8G-414/kernel_selftests-kselftests-02-debian-=
x86_64-2018-04-03.cgz-cd5bbb30-20190706-7286-azbicy-8.yaml ARCH=3Dx86_64 kc=
onfig=3Dx86_64-rhel-7.6 branch=3Dlinux-devel/devel-catchup-201907030021 com=
mit=3Dcd5bbb3047bf73353767d70a03db986600ca372a BOOT_IMAGE=3D/pkg/linux/x86_=
64-rhel-7.6/gcc-7/cd5bbb3047bf73353767d70a03db986600ca372a/vmlinuz-5.2.0-rc=
4-00289-gcd5bbb3047bf7 erst_disable max_uptime=3D3600 RESULT_ROOT=3D/result=
/kernel_selftests/kselftests-02/vm-snb-8G/debian-x86_64-2018-04-03.cgz/x86_=
64-rhel-7.6/gcc-7/cd5bbb3047bf73353767d70a03db986600ca372a/8 LKP_SERVER=3Di=
nn debug apic=3Ddebug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=
=3D100 net.ifnames=3D0 printk.devkmsg=3Don panic=3D-1 softlockup_panic=3D1 =
nmi_watchdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 drbd.=
minor_count=3D8 systemd.log_level=3Derr ignore_loglevel console=3Dtty0 earl=
yprintk=3DttyS0,115200 console=3DttyS0,115200 vga=3Dnormal rw rcuperf.shutd=
own=3D0
# pstore_crash_test has not been executed yet. we skip further tests.
not ok 2 selftests: pstore: pstore_post_reboot_tests # SKIP
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047=
bf73353767d70a03db986600ca372a/tools/testing/selftests/pstore'
ptp test: not in Makefile
2019-07-06 13:02:34 make TARGETS=3Dptp
make --no-builtin-rules ARCH=3Dx86 -C ../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb=
3047bf73353767d70a03db986600ca372a'
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3=
047bf73353767d70a03db986600ca372a'
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb=
3047bf73353767d70a03db986600ca372a/tools/testing/selftests/ptp'
Makefile:10: warning: overriding recipe for target 'clean'
=2E./lib.mk:123: warning: ignoring old recipe for target 'clean'
gcc -I../../../../usr/include/    testptp.c  -lrt -o testptp
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3=
047bf73353767d70a03db986600ca372a/tools/testing/selftests/ptp'

2019-07-06 13:02:36 make run_tests -C ptp
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb304=
7bf73353767d70a03db986600ca372a/tools/testing/selftests/ptp'
Makefile:10: warning: overriding recipe for target 'clean'
=2E./lib.mk:123: warning: ignoring old recipe for target 'clean'
TAP version 13
1..1
# selftests: ptp: testptp
# opening /dev/ptp0: No such file or directory
not ok 1 selftests: ptp: testptp
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047=
bf73353767d70a03db986600ca372a/tools/testing/selftests/ptp'

2019-07-06 13:02:36 make run_tests -C ptrace
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb304=
7bf73353767d70a03db986600ca372a/tools/testing/selftests/ptrace'
gcc -iquote../../../../include/uapi -Wall    peeksiginfo.c  -o /usr/src/per=
f_selftests-x86_64-rhel-7.6-cd5bbb3047bf73353767d70a03db986600ca372a/tools/=
testing/selftests/ptrace/peeksiginfo
TAP version 13
1..1
# selftests: ptrace: peeksiginfo
# PASS
ok 1 selftests: ptrace: peeksiginfo
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047=
bf73353767d70a03db986600ca372a/tools/testing/selftests/ptrace'

2019-07-06 13:02:36 make run_tests -C rtc
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb304=
7bf73353767d70a03db986600ca372a/tools/testing/selftests/rtc'
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  rtctest.c  -o /usr/src=
/perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf73353767d70a03db986600ca372a/to=
ols/testing/selftests/rtc/rtctest
gcc -O3 -Wl,-no-as-needed -Wall  -lrt -lpthread -lm  setdate.c  -o /usr/src=
/perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf73353767d70a03db986600ca372a/to=
ols/testing/selftests/rtc/setdate
TAP version 13
1..1
# selftests: rtc: rtctest
# rtctest.c:49:rtc.date_read:Current RTC date/time is 06/07/2019 13:02:37.
# rtctest.c:137:rtc.alarm_alm_set:Alarm time now set to 13:02:46.
# rtctest.c:156:rtc.alarm_alm_set:data: 1a0
# rtctest.c:195:rtc.alarm_wkalm_set:Alarm time now set to 06/07/2019 13:02:=
49.
# rtctest.c:239:rtc.alarm_alm_set_minute:Alarm time now set to 13:03:00.
# rtctest.c:258:rtc.alarm_alm_set_minute:data: 1a0
# rtctest.c:297:rtc.alarm_wkalm_set_minute:Alarm time now set to 06/07/2019=
 13:04:00.
# [=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] Running 7 tests from 2 test cases.
# [ RUN      ] rtc.date_read
# [       OK ] rtc.date_read
# [ RUN      ] rtc.uie_read
# [       OK ] rtc.uie_read
# [ RUN      ] rtc.uie_select
# [       OK ] rtc.uie_select
# [ RUN      ] rtc.alarm_alm_set
# [       OK ] rtc.alarm_alm_set
# [ RUN      ] rtc.alarm_wkalm_set
# [       OK ] rtc.alarm_wkalm_set
# [ RUN      ] rtc.alarm_alm_set_minute
# [       OK ] rtc.alarm_alm_set_minute
# [ RUN      ] rtc.alarm_wkalm_set_minute
# [       OK ] rtc.alarm_wkalm_set_minute
# [=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] 7 / 7 tests passed.
# [  PASSED  ]
ok 1 selftests: rtc: rtctest
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047=
bf73353767d70a03db986600ca372a/tools/testing/selftests/rtc'
safesetid test: not in Makefile
2019-07-06 13:03:59 make TARGETS=3Dsafesetid
make --no-builtin-rules ARCH=3Dx86 -C ../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb=
3047bf73353767d70a03db986600ca372a'
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3=
047bf73353767d70a03db986600ca372a'
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb=
3047bf73353767d70a03db986600ca372a/tools/testing/selftests/safesetid'
gcc -Wall -lcap -O2    safesetid-test.c  -o /usr/src/perf_selftests-x86_64-=
rhel-7.6-cd5bbb3047bf73353767d70a03db986600ca372a/tools/testing/selftests/s=
afesetid/safesetid-test
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3=
047bf73353767d70a03db986600ca372a/tools/testing/selftests/safesetid'

2019-07-06 13:04:03 make run_tests -C safesetid
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb304=
7bf73353767d70a03db986600ca372a/tools/testing/selftests/safesetid'
TAP version 13
1..1
# selftests: safesetid: run_tests.sh
# Warning: file run_tests.sh is missing!
not ok 1 selftests: safesetid: run_tests.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047=
bf73353767d70a03db986600ca372a/tools/testing/selftests/safesetid'

2019-07-06 13:04:03 make run_tests -C seccomp
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb304=
7bf73353767d70a03db986600ca372a/tools/testing/selftests/seccomp'
gcc -Wl,-no-as-needed -Wall  seccomp_bpf.c -lpthread -o seccomp_bpf
gcc -Wl,-no-as-needed -Wall    seccomp_benchmark.c   -o seccomp_benchmark
TAP version 13
1..2
# selftests: seccomp: seccomp_bpf
# [=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] Running 74 tests from 1 test cases.
# [ RUN      ] global.mode_strict_support
# [       OK ] global.mode_strict_support
# [ RUN      ] global.mode_strict_cannot_call_prctl
# [       OK ] global.mode_strict_cannot_call_prctl
# [ RUN      ] global.no_new_privs_support
# [       OK ] global.no_new_privs_support
# [ RUN      ] global.mode_filter_support
# [       OK ] global.mode_filter_support
# [ RUN      ] global.mode_filter_without_nnp
# [       OK ] global.mode_filter_without_nnp
# [ RUN      ] global.filter_size_limits
# [       OK ] global.filter_size_limits
# [ RUN      ] global.filter_chain_limits
# [       OK ] global.filter_chain_limits
# [ RUN      ] global.mode_filter_cannot_move_to_strict
# [       OK ] global.mode_filter_cannot_move_to_strict
# [ RUN      ] global.mode_filter_get_seccomp
# [       OK ] global.mode_filter_get_seccomp
# [ RUN      ] global.ALLOW_all
# [       OK ] global.ALLOW_all
# [ RUN      ] global.empty_prog
# [       OK ] global.empty_prog
# [ RUN      ] global.log_all
# [       OK ] global.log_all
# [ RUN      ] global.unknown_ret_is_kill_inside
# [       OK ] global.unknown_ret_is_kill_inside
# [ RUN      ] global.unknown_ret_is_kill_above_allow
# [       OK ] global.unknown_ret_is_kill_above_allow
# [ RUN      ] global.KILL_all
# [       OK ] global.KILL_all
# [ RUN      ] global.KILL_one
# [       OK ] global.KILL_one
# [ RUN      ] global.KILL_one_arg_one
# [       OK ] global.KILL_one_arg_one
# [ RUN      ] global.KILL_one_arg_six
# [       OK ] global.KILL_one_arg_six
# [ RUN      ] global.KILL_thread
# seccomp_bpf.c:1781:TRACE_syscall.ptrace_syscall_redirected:Expected 0 (0)=
 =3D=3D msg (1)
# seccomp_bpf.c:1781:TRACE_syscall.ptrace_syscall_redirected:Expected 0 (0)=
 =3D=3D msg (2)
# seccomp_bpf.c:1781:TRACE_syscall.ptrace_syscall_redirected:Expected 0 (0)=
 =3D=3D msg (1)
# seccomp_bpf.c:1781:TRACE_syscall.ptrace_syscall_redirected:Expected 0 (0)=
 =3D=3D msg (2)
# seccomp_bpf.c:1781:TRACE_syscall.ptrace_syscall_redirected:Expected 0 (0)=
 =3D=3D msg (1)
# seccomp_bpf.c:1781:TRACE_syscall.ptrace_syscall_redirected:Expected 0 (0)=
 =3D=3D msg (2)
# seccomp_bpf.c:1781:TRACE_syscall.ptrace_syscall_redirected:Expected 0 (0)=
 =3D=3D msg (1)
# TRACE_syscall.ptrace_syscall_redirected: Test failed at step #15
# seccomp_bpf.c:1781:TRACE_syscall.ptrace_syscall_errno:Expected 0 (0) =3D=
=3D msg (1)
# seccomp_bpf.c:1781:TRACE_syscall.ptrace_syscall_errno:Expected 0 (0) =3D=
=3D msg (2)
# seccomp_bpf.c:1781:TRACE_syscall.ptrace_syscall_errno:Expected 0 (0) =3D=
=3D msg (1)
# seccomp_bpf.c:1781:TRACE_syscall.ptrace_syscall_errno:Expected 0 (0) =3D=
=3D msg (2)
# seccomp_bpf.c:1781:TRACE_syscall.ptrace_syscall_errno:Expected 0 (0) =3D=
=3D msg (1)
# seccomp_bpf.c:1781:TRACE_syscall.ptrace_syscall_errno:Expected 0 (0) =3D=
=3D msg (2)
# seccomp_bpf.c:1781:TRACE_syscall.ptrace_syscall_errno:Expected 0 (0) =3D=
=3D msg (1)
# TRACE_syscall.ptrace_syscall_errno: Test failed at step #15
# seccomp_bpf.c:1781:TRACE_syscall.ptrace_syscall_faked:Expected 0 (0) =3D=
=3D msg (1)
# seccomp_bpf.c:1781:TRACE_syscall.ptrace_syscall_faked:Expected 0 (0) =3D=
=3D msg (2)
# seccomp_bpf.c:1781:TRACE_syscall.ptrace_syscall_faked:Expected 0 (0) =3D=
=3D msg (1)
# seccomp_bpf.c:1781:TRACE_syscall.ptrace_syscall_faked:Expected 0 (0) =3D=
=3D msg (2)
# seccomp_bpf.c:1781:TRACE_syscall.ptrace_syscall_faked:Expected 0 (0) =3D=
=3D msg (1)
# seccomp_bpf.c:1781:TRACE_syscall.ptrace_syscall_faked:Expected 0 (0) =3D=
=3D msg (2)
# seccomp_bpf.c:1781:TRACE_syscall.ptrace_syscall_faked:Expected 0 (0) =3D=
=3D msg (1)
# TRACE_syscall.ptrace_syscall_faked: Test failed at step #15
# [=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] Running 74 tests from 1 test cases.
# [ RUN      ] global.mode_strict_support
# [       OK ] global.mode_strict_support
# [ RUN      ] global.mode_strict_cannot_call_prctl
# [       OK ] global.mode_strict_cannot_call_prctl
# [ RUN      ] global.no_new_privs_support
# [       OK ] global.no_new_privs_support
# [ RUN      ] global.mode_filter_support
# [       OK ] global.mode_filter_support
# [ RUN      ] global.mode_filter_without_nnp
# [       OK ] global.mode_filter_without_nnp
# [ RUN      ] global.filter_size_limits
# [       OK ] global.filter_size_limits
# [ RUN      ] global.filter_chain_limits
# [       OK ] global.filter_chain_limits
# [ RUN      ] global.mode_filter_cannot_move_to_strict
# [       OK ] global.mode_filter_cannot_move_to_strict
# [ RUN      ] global.mode_filter_get_seccomp
# [       OK ] global.mode_filter_get_seccomp
# [ RUN      ] global.ALLOW_all
# [       OK ] global.ALLOW_all
# [ RUN      ] global.empty_prog
# [       OK ] global.empty_prog
# [ RUN      ] global.log_all
# [       OK ] global.log_all
# [ RUN      ] global.unknown_ret_is_kill_inside
# [       OK ] global.unknown_ret_is_kill_inside
# [ RUN      ] global.unknown_ret_is_kill_above_allow
# [       OK ] global.unknown_ret_is_kill_above_allow
# [ RUN      ] global.KILL_all
# [       OK ] global.KILL_all
# [ RUN      ] global.KILL_one
# [       OK ] global.KILL_one
# [ RUN      ] global.KILL_one_arg_one
# [       OK ] global.KILL_one_arg_one
# [ RUN      ] global.KILL_one_arg_six
# [       OK ] global.KILL_one_arg_six
# [ RUN      ] global.KILL_thread
# [       OK ] global.KILL_thread
# [ RUN      ] global.KILL_process
# [       OK ] global.KILL_process
# [ RUN      ] global.arg_out_of_range
# [       OK ] global.arg_out_of_range
# [ RUN      ] global.ERRNO_valid
# [       OK ] global.ERRNO_valid
# [ RUN      ] global.ERRNO_zero
# [       OK ] global.ERRNO_zero
# [ RUN      ] global.ERRNO_capped
# [       OK ] global.ERRNO_capped
# [ RUN      ] global.ERRNO_order
# [       OK ] global.ERRNO_order
# [ RUN      ] TRAP.dfl
# [       OK ] TRAP.dfl
# [ RUN      ] TRAP.ign
# [       OK ] TRAP.ign
# [ RUN      ] TRAP.handler
# [       OK ] TRAP.handler
# [ RUN      ] precedence.allow_ok
# [       OK ] precedence.allow_ok
# [ RUN      ] precedence.kill_is_highest
# [       OK ] precedence.kill_is_highest
# [ RUN      ] precedence.kill_is_highest_in_any_order
# [       OK ] precedence.kill_is_highest_in_any_order
# [ RUN      ] precedence.trap_is_second
# [       OK ] precedence.trap_is_second
# [ RUN      ] precedence.trap_is_second_in_any_order
# [       OK ] precedence.trap_is_second_in_any_order
# [ RUN      ] precedence.errno_is_third
# [       OK ] precedence.errno_is_third
# [ RUN      ] precedence.errno_is_third_in_any_order
# [       OK ] precedence.errno_is_third_in_any_order
# [ RUN      ] precedence.trace_is_fourth
# [       OK ] precedence.trace_is_fourth
# [ RUN      ] precedence.trace_is_fourth_in_any_order
# [       OK ] precedence.trace_is_fourth_in_any_order
# [ RUN      ] precedence.log_is_fifth
# [       OK ] precedence.log_is_fifth
# [ RUN      ] precedence.log_is_fifth_in_any_order
# [       OK ] precedence.log_is_fifth_in_any_order
# [ RUN      ] TRACE_poke.read_has_side_effects
# [       OK ] TRACE_poke.read_has_side_effects
# [ RUN      ] TRACE_poke.getpid_runs_normally
# [       OK ] TRACE_poke.getpid_runs_normally
# [ RUN      ] TRACE_syscall.ptrace_syscall_redirected
# [     FAIL ] TRACE_syscall.ptrace_syscall_redirected
# [ RUN      ] TRACE_syscall.ptrace_syscall_errno
# [     FAIL ] TRACE_syscall.ptrace_syscall_errno
# [ RUN      ] TRACE_syscall.ptrace_syscall_faked
# [     FAIL ] TRACE_syscall.ptrace_syscall_faked
# [ RUN      ] TRACE_syscall.syscall_allowed
# [       OK ] TRACE_syscall.syscall_allowed
# [ RUN      ] TRACE_syscall.syscall_redirected
# [       OK ] TRACE_syscall.syscall_redirected
# [ RUN      ] TRACE_syscall.syscall_errno
# [       OK ] TRACE_syscall.syscall_errno
# [ RUN      ] TRACE_syscall.syscall_faked
# [       OK ] TRACE_syscall.syscall_faked
# [ RUN      ] TRACE_syscall.skip_after_RET_TRACE
# [       OK ] TRACE_syscall.skip_after_RET_TRACE
# [ RUN      ] TRACE_syscall.kill_after_RET_TRACE
# [       OK ] TRACE_syscall.kill_after_RET_TRACE
# [ RUN      ] TRACE_syscall.skip_aseccomp_bpf.c:1781:TRACE_syscall.skip_af=
ter_ptrace:Expected 0 (0) =3D=3D msg (1)
# seccomp_bpf.c:1781:TRACE_syscall.skip_after_ptrace:Expected 0 (0) =3D=3D =
msg (2)
# seccomp_bpf.c:1781:TRACE_syscall.skip_after_ptrace:Expected 0 (0) =3D=3D =
msg (1)
# seccomp_bpf.c:1781:TRACE_syscall.skip_after_ptrace:Expected 0 (0) =3D=3D =
msg (2)
# seccomp_bpf.c:1781:TRACE_syscall.skip_after_ptrace:Expected 0 (0) =3D=3D =
msg (1)
# seccomp_bpf.c:1781:TRACE_syscall.skip_after_ptrace:Expected 0 (0) =3D=3D =
msg (2)
# seccomp_bpf.c:1781:TRACE_syscall.skip_after_ptrace:Expected 0 (0) =3D=3D =
msg (1)
# seccomp_bpf.c:1781:TRACE_syscall.skip_after_ptrace:Expected 0 (0) =3D=3D =
msg (2)
# seccomp_bpf.c:1781:TRACE_syscall.skip_after_ptrace:Expected 0 (0) =3D=3D =
msg (1)
# seccomp_bpf.c:1781:TRACE_syscall.skip_after_ptrace:Expected 0 (0) =3D=3D =
msg (2)
# seccomp_bpf.c:1781:TRACE_syscall.skip_after_ptrace:Expected 0 (0) =3D=3D =
msg (1)
# TRACE_syscall.skip_after_ptrace: Test failed at step #17
# seccomp_bpf.c:1781:TRACE_syscall.kill_after_ptrace:Expected 0 (0) =3D=3D =
msg (1)
# seccomp_bpf.c:1781:TRACE_syscall.kill_after_ptrace:Expected 0 (0) =3D=3D =
msg (2)
# seccomp_bpf.c:1781:TRACE_syscall.kill_after_ptrace:Expected 0 (0) =3D=3D =
msg (1)
# seccomp_bpf.c:1781:TRACE_syscall.kill_after_ptrace:Expected 0 (0) =3D=3D =
msg (2)
# seccomp_bpf.c:1781:TRACE_syscall.kill_after_ptrace:Expected 0 (0) =3D=3D =
msg (1)
# seccomp_bpf.c:1781:TRACE_syscall.kill_after_ptrace:Expected 0 (0) =3D=3D =
msg (2)
# seccomp_bpf.c:1781:TRACE_syscall.kill_after_ptrace:Expected 0 (0) =3D=3D =
msg (1)
# seccomp_bpf.c:1781:TRACE_syscall.kill_after_ptrace:Expected 0 (0) =3D=3D =
msg (2)
# seccomp_bpf.c:1781:TRACE_syscall.kill_after_ptrace:Expected 0 (0) =3D=3D =
msg (1)
# fter_ptrace
# [     FAIL ] TRACE_syscall.skip_after_ptrace
# [ RUN      ] TRACE_syscall.kill_after_ptrace
# [       OK ] TRACE_syscall.kill_after_ptrace
# [ RUN      ] global.seccomp_syscall
# [       OK ] global.seccomp_syscall
# [ RUN      ] global.seccomp_syscall_mode_lock
# [       OK ] global.seccomp_syscall_mode_lock
# [ RUN      ] global.detect_seccomp_filter_flags
# [       OK ] global.detect_seccomp_filter_flags
# [ RUN      ] global.TSYNC_first
# [       OK ] global.TSYNC_first
# [ RUN      ] TSYNC.siblings_fail_prctl
# [       OK ] TSYNC.siblings_fail_prctl
# [ RUN      ] TSYNC.two_siblings_with_ancestor
# [       OK ] TSYNC.two_siblings_with_ancestor
# [ RUN      ] TSYNC.two_sibling_want_nnp
# [       OK ] TSYNC.two_sibling_want_nnp
# [ RUN      ] TSYNC.two_siblings_with_no_filter
# [       OK ] TSYNC.two_siblings_with_no_filter
# [ RUN      ] TSYNC.two_siblings_with_one_divergence
# [       OK ] TSYNC.two_siblings_with_one_divergence
# [ RUN      ] TSYNC.two_siblings_not_under_filter
# [       OK ] TSYNC.two_siblings_not_under_filter
# [ RUN      ] global.syscall_restart
# [       OK ] global.syscall_restart
# [ RUN      ] global.filter_flag_log
# [       OK ] global.filter_flag_log
# [ RUN      ] global.get_action_avail
# [       OK ] global.get_action_avail
# [ RUN      ] global.get_metadata
# [       OK ] global.get_metadata
# [ RUN      ] global.user_notification_basic
# fter_ptrace
# [     FAIL ] TRACE_syscall.skip_after_ptrace
# [ RUN      ] TRACE_syscall.kill_after_ptrace
# [       OK ] TRACE_syscall.kill_after_ptrace
# [ RUN      ] global.seccomp_syscall
# [       OK ] global.seccomp_syscall
# [ RUN      ] global.seccomp_syscall_mode_lock
# [       OK ] global.seccomp_syscall_mode_lock
# [ RUN      ] global.detect_seccomp_filter_flags
# [       OK ] global.detect_seccomp_filter_flags
# [ RUN      ] global.TSYNC_first
# [       OK ] global.TSYNC_first
# [ RUN      ] TSYNC.siblings_fail_prctl
# [       OK ] TSYNC.siblings_fail_prctl
# [ RUN      ] TSYNC.two_siblings_with_ancestor
# [       OK ] TSYNC.two_siblings_with_ancestor
# [ RUN      ] TSYNC.two_sibling_want_nnp
# [       OK ] TSYNC.two_sibling_want_nnp
# [ RUN      ] TSYNC.two_siblings_with_no_filter
# [       OK ] TSYNC.two_siblings_with_no_filter
# [ RUN      ] TSYNC.two_siblings_with_one_divergence
# [       OK ] TSYNC.two_siblings_with_one_divergence
# [ RUN      ] TSYNC.two_siblings_not_under_filter
# [       OK ] TSYNC.two_siblings_not_under_filter
# [ RUN      ] global.syscall_restart
# [       OK ] global.syscall_restart
# [ RUN      ] global.filter_flag_log
# [       OK ] global.filter_flag_log
# [ RUN      ] global.get_action_avail
# [       OK ] global.get_action_avail
# [ RUN      ] global.get_metadata
# [       OK ] global.get_metadata
# [ RUN      ] global.user_notification_basic
# fter_ptrace
# [     FAIL ] TRACE_syscall.skip_after_ptrace
# [ RUN      ] TRACE_syscall.kill_after_ptrace
# [       OK ] TRACE_syscall.kill_after_ptrace
# [ RUN      ] global.seccomp_syscall
# [       OK ] global.seccomp_syscall
# [ RUN      ] global.seccomp_syscall_mode_lock
# [       OK ] global.seccomp_syscall_mode_lock
# [ RUN      ] global.detect_seccomp_filter_flags
# [       OK ] global.detect_seccomp_filter_flags
# [ RUN      ] global.TSYNC_first
# [       OK ] global.TSYNC_first
# [ RUN      ] TSYNC.siblings_fail_prctl
# [       OK ] TSYNC.siblings_fail_prctl
# [ RUN      ] TSYNC.two_siblings_with_ancestor
# [       OK ] TSYNC.two_siblings_with_ancestor
# [ RUN      ] TSYNC.two_sibling_want_nnp
# [       OK ] TSYNC.two_sibling_want_nnp
# [ RUN      ] TSYNC.two_siblings_with_no_filter
# [       OK ] TSYNC.two_siblings_with_no_filter
# [ RUN      ] TSYNC.two_siblings_with_one_divergence
# [       OK ] TSYNC.two_siblings_with_one_divergence
# [ RUN      ] TSYNC.two_siblings_not_under_filter
# [       OK ] TSYNC.two_siblings_not_under_filter
# [ RUN      ] global.syscall_restart
# [       OK ] global.syscall_restart
# [ RUN      ] global.filter_flag_log
# [       OK ] global.filter_flag_log
# [ RUN      ] global.get_action_avail
# [       OK ] global.get_action_avail
# [ RUN      ] global.get_metadata
# [       OK ] global.get_metadata
# [ RUN      ] global.user_notification_basic
# [       OK ] global.user_notification_basic
# [ RUN      ] global.user_notification_kill_in_middle
# [       OK ] global.user_notification_kill_in_middle
# [ RUN      ] global.user_notification_signal
# fter_ptrace
# [     FAIL ] TRACE_syscall.skip_after_ptrace
# [ RUN      ] TRACE_syscall.kill_after_ptrace
# [       OK ] TRACE_syscall.kill_after_ptrace
# [ RUN      ] global.seccomp_syscall
# [       OK ] global.seccomp_syscall
# [ RUN      ] global.seccomp_syscall_mode_lock
# [       OK ] global.seccomp_syscall_mode_lock
# [ RUN      ] global.detect_seccomp_filter_flags
# [       OK ] global.detect_seccomp_filter_flags
# [ RUN      ] global.TSYNC_first
# [       OK ] global.TSYNC_first
# [ RUN      ] TSYNC.siblings_fail_prctl
# [       OK ] TSYNC.siblings_fail_prctl
# [ RUN      ] TSYNC.two_siblings_with_ancestor
# [       OK ] TSYNC.two_siblings_with_ancestor
# [ RUN      ] TSYNC.two_sibling_want_nnp
# [       OK ] TSYNC.two_sibling_want_nnp
# [ RUN      ] TSYNC.two_siblings_with_no_filter
# [       OK ] TSYNC.two_siblings_with_no_filter
# [ RUN      ] TSYNC.two_siblings_with_one_divergence
# [       OK ] TSYNC.two_siblings_with_one_divergence
# [ RUN      ] TSYNC.two_siblings_not_under_filter
# [       OK ] TSYNC.two_siblings_not_under_filter
# [ RUN      ] global.syscall_restart
# [       OK ] global.syscall_restart
# [ RUN      ] global.filter_flag_log
# [       OK ] global.filter_flag_log
# [ RUN      ] global.get_action_avail
# [       OK ] global.get_action_avail
# [ RUN      ] global.get_metadata
# [       OK ] global.get_metadata
# [ RUN      ] global.user_notification_basic
# [       OK ] global.user_notification_basic
# [ RUN      ] global.user_notification_kill_in_middle
# [       OK ] global.user_notification_kill_in_middle
# [ RUN      ] global.user_notification_signal
# [       OK ] global.user_notification_signal
# [ RUN      ] global.user_notification_closed_listener
# fter_ptrace
# [     FAIL ] TRACE_syscall.skip_after_ptrace
# [ RUN      ] TRACE_syscall.kill_after_ptrace
# [       OK ] TRACE_syscall.kill_after_ptrace
# [ RUN      ] global.seccomp_syscall
# [       OK ] global.seccomp_syscall
# [ RUN      ] global.seccomp_syscall_mode_lock
# [       OK ] global.seccomp_syscall_mode_lock
# [ RUN      ] global.detect_seccomp_filter_flags
# [       OK ] global.detect_seccomp_filter_flags
# [ RUN      ] global.TSYNC_first
# [       OK ] global.TSYNC_first
# [ RUN      ] TSYNC.siblings_fail_prctl
# [       OK ] TSYNC.siblings_fail_prctl
# [ RUN      ] TSYNC.two_siblings_with_ancestor
# [       OK ] TSYNC.two_siblings_with_ancestor
# [ RUN      ] TSYNC.two_sibling_want_nnp
# [       OK ] TSYNC.two_sibling_want_nnp
# [ RUN      ] TSYNC.two_siblings_with_no_filter
# [       OK ] TSYNC.two_siblings_with_no_filter
# [ RUN      ] TSYNC.two_siblings_with_one_divergence
# [       OK ] TSYNC.two_siblings_with_one_divergence
# [ RUN      ] TSYNC.two_siblings_not_under_filter
# [       OK ] TSYNC.two_siblings_not_under_filter
# [ RUN      ] global.syscall_restart
# [       OK ] global.syscall_restart
# [ RUN      ] global.filter_flag_log
# [       OK ] global.filter_flag_log
# [ RUN      ] global.get_action_avail
# [       OK ] global.get_action_avail
# [ RUN      ] global.get_metadata
# [       OK ] global.get_metadata
# [ RUN      ] global.user_notification_basic
# [       OK ] global.user_notification_basic
# [ RUN      ] global.user_notification_kill_in_middle
# [       OK ] global.user_notification_kill_in_middle
# [ RUN      ] global.user_notification_signal
# [       OK ] global.user_notification_signal
# [ RUN      ] global.user_notification_closed_listener
# [       OK ] global.user_notification_closed_listener
# [ RUN      ] global.user_notification_child_pid_ns
# fter_ptrace
# [     FAIL ] TRACE_syscall.skip_after_ptrace
# [ RUN      ] TRACE_syscall.kill_after_ptrace
# [       OK ] TRACE_syscall.kill_after_ptrace
# [ RUN      ] global.seccomp_syscall
# [       OK ] global.seccomp_syscall
# [ RUN      ] global.seccomp_syscall_mode_lock
# [       OK ] global.seccomp_syscall_mode_lock
# [ RUN      ] global.detect_seccomp_filter_flags
# [       OK ] global.detect_seccomp_filter_flags
# [ RUN      ] global.TSYNC_first
# [       OK ] global.TSYNC_first
# [ RUN      ] TSYNC.siblings_fail_prctl
# [       OK ] TSYNC.siblings_fail_prctl
# [ RUN      ] TSYNC.two_siblings_with_ancestor
# [       OK ] TSYNC.two_siblings_with_ancestor
# [ RUN      ] TSYNC.two_sibling_want_nnp
# [       OK ] TSYNC.two_sibling_want_nnp
# [ RUN      ] TSYNC.two_siblings_with_no_filter
# [       OK ] TSYNC.two_siblings_with_no_filter
# [ RUN      ] TSYNC.two_siblings_with_one_divergence
# [       OK ] TSYNC.two_siblings_with_one_divergence
# [ RUN      ] TSYNC.two_siblings_not_under_filter
# [       OK ] TSYNC.two_siblings_not_under_filter
# [ RUN      ] global.syscall_restart
# [       OK ] global.syscall_restart
# [ RUN      ] global.filter_flag_log
# [       OK ] global.filter_flag_log
# [ RUN      ] global.get_action_avail
# [       OK ] global.get_action_avail
# [ RUN      ] global.get_metadata
# [       OK ] global.get_metadata
# [ RUN      ] global.user_notification_basic
# [       OK ] global.user_notification_basic
# [ RUN      ] global.user_notification_kill_in_middle
# [       OK ] global.user_notification_kill_in_middle
# [ RUN      ] global.user_notification_signal
# [       OK ] global.user_notification_signal
# [ RUN      ] global.user_notification_closed_listener
# [       OK ] global.user_notification_closed_listener
# [ RUN      ] global.user_notification_child_pid_ns
# [       OK ] global.user_notification_child_pid_ns
# [ RUN      ] global.user_notification_sibling_pid_ns
# fter_ptrace
# [     FAIL ] TRACE_syscall.skip_after_ptrace
# [ RUN      ] TRACE_syscall.kill_after_ptrace
# [       OK ] TRACE_syscall.kill_after_ptrace
# [ RUN      ] global.seccomp_syscall
# [       OK ] global.seccomp_syscall
# [ RUN      ] global.seccomp_syscall_mode_lock
# [       OK ] global.seccomp_syscall_mode_lock
# [ RUN      ] global.detect_seccomp_filter_flags
# [       OK ] global.detect_seccomp_filter_flags
# [ RUN      ] global.TSYNC_first
# [       OK ] global.TSYNC_first
# [ RUN      ] TSYNC.siblings_fail_prctl
# [       OK ] TSYNC.siblings_fail_prctl
# [ RUN      ] TSYNC.two_siblings_with_ancestor
# [       OK ] TSYNC.two_siblings_with_ancestor
# [ RUN      ] TSYNC.two_sibling_want_nnp
# [       OK ] TSYNC.two_sibling_want_nnp
# [ RUN      ] TSYNC.two_siblings_with_no_filter
# [       OK ] TSYNC.two_siblings_with_no_filter
# [ RUN      ] TSYNC.two_siblings_with_one_divergence
# [       OK ] TSYNC.two_siblings_with_one_divergence
# [ RUN      ] TSYNC.two_siblings_not_under_filter
# [       OK ] TSYNC.two_siblings_not_under_filter
# [ RUN      ] global.syscall_restart
# [       OK ] global.syscall_restart
# [ RUN      ] global.filter_flag_log
# [       OK ] global.filter_flag_log
# [ RUN      ] global.get_action_avail
# [       OK ] global.get_action_avail
# [ RUN      ] global.get_metadata
# [       OK ] global.get_metadata
# [ RUN      ] global.user_notification_basic
# [       OK ] global.user_notification_basic
# [ RUN      ] global.user_notification_kill_in_middle
# [       OK ] global.user_notification_kill_in_middle
# [ RUN      ] global.user_notification_signal
# [       OK ] global.user_notification_signal
# [ RUN      ] global.user_notification_closed_listener
# [       OK ] global.user_notification_closed_listener
# [ RUN      ] global.user_notification_child_pid_ns
# [       OK ] global.user_notification_child_pid_ns
# [ RUN      ] global.user_notification_sibling_pid_ns
# fter_ptrace
# [     FAIL ] TRACE_syscall.skip_after_ptrace
# [ RUN      ] TRACE_syscall.kill_after_ptrace
# [       OK ] TRACE_syscall.kill_after_ptrace
# [ RUN      ] global.seccomp_syscall
# [       OK ] global.seccomp_syscall
# [ RUN      ] global.seccomp_syscall_mode_lock
# [       OK ] global.seccomp_syscall_mode_lock
# [ RUN      ] global.detect_seccomp_filter_flags
# [       OK ] global.detect_seccomp_filter_flags
# [ RUN      ] global.TSYNC_first
# [       OK ] global.TSYNC_first
# [ RUN      ] TSYNC.siblings_fail_prctl
# [       OK ] TSYNC.siblings_fail_prctl
# [ RUN      ] TSYNC.two_siblings_with_ancestor
# [       OK ] TSYNC.two_siblings_with_ancestor
# [ RUN      ] TSYNC.two_sibling_want_nnp
# [       OK ] TSYNC.two_sibling_want_nnp
# [ RUN      ] TSYNC.two_siblings_with_no_filter
# [       OK ] TSYNC.two_siblings_with_no_filter
# [ RUN      ] TSYNC.two_siblings_with_one_divergence
# [       OK ] TSYNC.two_siblings_with_one_divergence
# [ RUN      ] TSYNC.two_siblings_not_under_filter
# [       OK ] TSYNC.two_siblings_not_under_filter
# [ RUN      ] global.syscall_restart
# [       OK ] global.syscall_restart
# [ RUN      ] global.filter_flag_log
# [       OK ] global.filter_flag_log
# [ RUN      ] global.get_action_avail
# [       OK ] global.get_action_avail
# [ RUN      ] global.get_metadata
# [       OK ] global.get_metadata
# [ RUN      ] global.user_notification_basic
# [       OK ] global.user_notification_basic
# [ RUN      ] global.user_notification_kill_in_middle
# [       OK ] global.user_notification_kill_in_middle
# [ RUN      ] global.user_notification_signal
# [       OK ] global.user_notification_signal
# [ RUN      ] global.user_notification_closed_listener
# [       OK ] global.user_notification_closed_listener
# [ RUN      ] global.user_notification_child_pid_ns
# [       OK ] global.user_notification_child_pid_ns
# [ RUN      ] global.user_notification_sibling_pid_ns
# fter_ptrace
# [     FAIL ] TRACE_syscall.skip_after_ptrace
# [ RUN      ] TRACE_syscall.kill_after_ptrace
# [       OK ] TRACE_syscall.kill_after_ptrace
# [ RUN      ] global.seccomp_syscall
# [       OK ] global.seccomp_syscall
# [ RUN      ] global.seccomp_syscall_mode_lock
# [       OK ] global.seccomp_syscall_mode_lock
# [ RUN      ] global.detect_seccomp_filter_flags
# [       OK ] global.detect_seccomp_filter_flags
# [ RUN      ] global.TSYNC_first
# [       OK ] global.TSYNC_first
# [ RUN      ] TSYNC.siblings_fail_prctl
# [       OK ] TSYNC.siblings_fail_prctl
# [ RUN      ] TSYNC.two_siblings_with_ancestor
# [       OK ] TSYNC.two_siblings_with_ancestor
# [ RUN      ] TSYNC.two_sibling_want_nnp
# [       OK ] TSYNC.two_sibling_want_nnp
# [ RUN      ] TSYNC.two_siblings_with_no_filter
# [       OK ] TSYNC.two_siblings_with_no_filter
# [ RUN      ] TSYNC.two_siblings_with_one_divergence
# [       OK ] TSYNC.two_siblings_with_one_divergence
# [ RUN      ] TSYNC.two_siblings_not_under_filter
# [       OK ] TSYNC.two_siblings_not_under_filter
# [ RUN      ] global.syscall_restart
# [       OK ] global.syscall_restart
# [ RUN      ] global.filter_flag_log
# [       OK ] global.filter_flag_log
# [ RUN      ] global.get_action_avail
# [       OK ] global.get_action_avail
# [ RUN      ] global.get_metadata
# [       OK ] global.get_metadata
# [ RUN      ] global.user_notification_basic
# [       OK ] global.user_notification_basic
# [ RUN      ] global.user_notification_kill_in_middle
# [       OK ] global.user_notification_kill_in_middle
# [ RUN      ] global.user_notification_signal
# [       OK ] global.user_notification_signal
# [ RUN      ] global.user_notification_closed_listener
# [       OK ] global.user_notification_closed_listener
# [ RUN      ] global.user_notification_child_pid_ns
# [       OK ] global.user_notification_child_pid_ns
# [ RUN      ] global.user_notification_sibling_pid_ns
# [       OK ] global.user_notification_sibling_pid_ns
# [ RUN      ] global.user_notification_fault_recv
# fter_ptrace
# [     FAIL ] TRACE_syscall.skip_after_ptrace
# [ RUN      ] TRACE_syscall.kill_after_ptrace
# [       OK ] TRACE_syscall.kill_after_ptrace
# [ RUN      ] global.seccomp_syscall
# [       OK ] global.seccomp_syscall
# [ RUN      ] global.seccomp_syscall_mode_lock
# [       OK ] global.seccomp_syscall_mode_lock
# [ RUN      ] global.detect_seccomp_filter_flags
# [       OK ] global.detect_seccomp_filter_flags
# [ RUN      ] global.TSYNC_first
# [       OK ] global.TSYNC_first
# [ RUN      ] TSYNC.siblings_fail_prctl
# [       OK ] TSYNC.siblings_fail_prctl
# [ RUN      ] TSYNC.two_siblings_with_ancestor
# [       OK ] TSYNC.two_siblings_with_ancestor
# [ RUN      ] TSYNC.two_sibling_want_nnp
# [       OK ] TSYNC.two_sibling_want_nnp
# [ RUN      ] TSYNC.two_siblings_with_no_filter
# [       OK ] TSYNC.two_siblings_with_no_filter
# [ RUN      ] TSYNC.two_siblings_with_one_divergence
# [       OK ] TSYNC.two_siblings_with_one_divergence
# [ RUN      ] TSYNC.two_siblings_not_under_filter
# [       OK ] TSYNC.two_siblings_not_under_filter
# [ RUN      ] global.syscall_restart
# [       OK ] global.syscall_restart
# [ RUN      ] global.filter_flag_log
# [       OK ] global.filter_flag_log
# [ RUN      ] global.get_action_avail
# [       OK ] global.get_action_avail
# [ RUN      ] global.get_metadata
# [       OK ] global.get_metadata
# [ RUN      ] global.user_notification_basic
# [       OK ] global.user_notification_basic
# [ RUN      ] global.user_notification_kill_in_middle
# [       OK ] global.user_notification_kill_in_middle
# [ RUN      ] global.user_notification_signal
# [       OK ] global.user_notification_signal
# [ RUN      ] global.user_notification_closed_listener
# [       OK ] global.user_notification_closed_listener
# [ RUN      ] global.user_notification_child_pid_ns
# [       OK ] global.user_notification_child_pid_ns
# [ RUN      ] global.user_notification_sibling_pid_ns
# [       OK ] global.user_notification_sibling_pid_ns
# [ RUN      ] global.user_notification_fault_recv
# [       OK ] global.user_notification_fault_recv
# [ RUN      ] global.seccomp_get_notif_sizes
# [       OK ] global.seccomp_get_notif_sizes
# [=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] 70 / 74 tests passed.
# [  FAILED  ]
not ok 1 selftests: seccomp: seccomp_bpf
# selftests: seccomp: seccomp_benchmark
# Calibrating reasonable sample size...
# 1562389449.383267346 - 1562389449.383239985 =3D 27361
# 1562389449.383328435 - 1562389449.383279390 =3D 49045
# 1562389449.383429405 - 1562389449.383331403 =3D 98002
# 1562389449.387731209 - 1562389449.383432235 =3D 4298974
# 1562389449.388243185 - 1562389449.387743790 =3D 499395
# 1562389449.398632320 - 1562389449.388247741 =3D 10384579
# 1562389449.401888449 - 1562389449.398646233 =3D 3242216
# 1562389449.405110716 - 1562389449.401895462 =3D 3215254
# 1562389449.411349735 - 1562389449.405121236 =3D 6228499
# 1562389449.423920285 - 1562389449.411365655 =3D 12554630
# 1562389449.449123404 - 1562389449.423933715 =3D 25189689
# 1562389449.512587437 - 1562389449.449139144 =3D 63448293
# 1562389449.614527835 - 1562389449.512602962 =3D 101924873
# 1562389449.841380992 - 1562389449.614543878 =3D 226837114
# 1562389450.279781845 - 1562389449.841397236 =3D 438384609
# 1562389451.339411557 - 1562389450.279828596 =3D 1059582961
# 1562389453.559263945 - 1562389451.339441914 =3D 2219822031
# 1562389457.655469487 - 1562389453.559273483 =3D 4096196004
# 1562389464.450387899 - 1562389457.655486680 =3D 6794901219
# Benchmarking 8388608 samples...
# 20.791639824 - 13.951606211 =3D 6840033613
# getpid native: 815 ns
# 29.678201931 - 20.791918100 =3D 8886283831
# getpid RET_ALLOW: 1059 ns
# Estimated seccomp overhead per syscall: 244 ns
ok 2 selftests: seccomp: seccomp_benchmark
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047=
bf73353767d70a03db986600ca372a/tools/testing/selftests/seccomp'

2019-07-06 13:04:40 make run_tests -C sigaltstack
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb304=
7bf73353767d70a03db986600ca372a/tools/testing/selftests/sigaltstack'
gcc -Wall    sas.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf=
73353767d70a03db986600ca372a/tools/testing/selftests/sigaltstack/sas
TAP version 13
1..1
# selftests: sigaltstack: sas
# TAP version 13
# 1..3
# ok 1 Initial sigaltstack state was SS_DISABLE
# # [RUN]	signal USR1
# ok 2 sigaltstack is disabled in sighandler
# # [RUN]	switched to user ctx
# # [RUN]	signal USR2
# # [OK]	Stack preserved
# ok 3 sigaltstack is still SS_AUTODISARM after signal
# # Pass 3 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
ok 1 selftests: sigaltstack: sas
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047=
bf73353767d70a03db986600ca372a/tools/testing/selftests/sigaltstack'

2019-07-06 13:04:41 make run_tests -C size
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb304=
7bf73353767d70a03db986600ca372a/tools/testing/selftests/size'
gcc -static -ffreestanding -nostartfiles -s    get_size.c  -o /usr/src/perf=
_selftests-x86_64-rhel-7.6-cd5bbb3047bf73353767d70a03db986600ca372a/tools/t=
esting/selftests/size/get_size
TAP version 13
1..1
# selftests: size: get_size
# TAP version 13
# # Testing system size.
# ok 1 get runtime memory use
# # System runtime memory report (units in Kilobytes):
#  ---
#  Total:  8149596
#  Free:   4165248
#  Buffer: 0
#  In use: 3984348
#  ...
# 1..1
ok 1 selftests: size: get_size
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047=
bf73353767d70a03db986600ca372a/tools/testing/selftests/size'

2019-07-06 13:04:41 make run_tests -C sparc64
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb304=
7bf73353767d70a03db986600ca372a/tools/testing/selftests/sparc64'
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047=
bf73353767d70a03db986600ca372a/tools/testing/selftests/sparc64'

2019-07-06 13:04:42 make run_tests -C splice
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb304=
7bf73353767d70a03db986600ca372a/tools/testing/selftests/splice'
gcc     default_file_splice_read.c  -o /usr/src/perf_selftests-x86_64-rhel-=
7.6-cd5bbb3047bf73353767d70a03db986600ca372a/tools/testing/selftests/splice=
/default_file_splice_read
TAP version 13
1..1
# selftests: splice: default_file_splice_read.sh
ok 1 selftests: splice: default_file_splice_read.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047=
bf73353767d70a03db986600ca372a/tools/testing/selftests/splice'

2019-07-06 13:04:42 make run_tests -C static_keys
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb304=
7bf73353767d70a03db986600ca372a/tools/testing/selftests/static_keys'
TAP version 13
1..1
# selftests: static_keys: test_static_keys.sh
# static_key: ok
ok 1 selftests: static_keys: test_static_keys.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047=
bf73353767d70a03db986600ca372a/tools/testing/selftests/static_keys'

2019-07-06 13:04:42 make run_tests -C sync
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb304=
7bf73353767d70a03db986600ca372a/tools/testing/selftests/sync'
gcc -c sync_alloc.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf=
73353767d70a03db986600ca372a/tools/testing/selftests/sync/sync_alloc.o
gcc -c sync_fence.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf=
73353767d70a03db986600ca372a/tools/testing/selftests/sync/sync_fence.o
gcc -c sync_merge.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf=
73353767d70a03db986600ca372a/tools/testing/selftests/sync/sync_merge.o
gcc -c sync_wait.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf7=
3353767d70a03db986600ca372a/tools/testing/selftests/sync/sync_wait.o
gcc -c sync_stress_parallelism.c -o /usr/src/perf_selftests-x86_64-rhel-7.6=
-cd5bbb3047bf73353767d70a03db986600ca372a/tools/testing/selftests/sync/sync=
_stress_parallelism.o
gcc -c sync_stress_consumer.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-cd=
5bbb3047bf73353767d70a03db986600ca372a/tools/testing/selftests/sync/sync_st=
ress_consumer.o
gcc -c sync_stress_merge.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-cd5bb=
b3047bf73353767d70a03db986600ca372a/tools/testing/selftests/sync/sync_stres=
s_merge.o
gcc -c sync_test.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf7=
3353767d70a03db986600ca372a/tools/testing/selftests/sync/sync_test.o -O2 -g=
 -std=3Dgnu89 -pthread -Wall -Wextra -I../../../../usr/include/
In file included from sync_test.c:37:0:
=2E./kselftest.h: In function =E2=80=98ksft_print_cnts=E2=80=99:
=2E./kselftest.h:73:16: warning: comparison between signed and unsigned int=
eger expressions [-Wsign-compare]
  if (ksft_plan !=3D ksft_test_num())
                ^~
gcc -c sync.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf733537=
67d70a03db986600ca372a/tools/testing/selftests/sync/sync.o -O2 -g -std=3Dgn=
u89 -pthread -Wall -Wextra -I../../../../usr/include/
gcc -o /usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf73353767d70a03db=
986600ca372a/tools/testing/selftests/sync/sync_test /usr/src/perf_selftests=
-x86_64-rhel-7.6-cd5bbb3047bf73353767d70a03db986600ca372a/tools/testing/sel=
ftests/sync/sync_test.o /usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047b=
f73353767d70a03db986600ca372a/tools/testing/selftests/sync/sync.o /usr/src/=
perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf73353767d70a03db986600ca372a/too=
ls/testing/selftests/sync/sync_alloc.o /usr/src/perf_selftests-x86_64-rhel-=
7.6-cd5bbb3047bf73353767d70a03db986600ca372a/tools/testing/selftests/sync/s=
ync_fence.o /usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf73353767d70=
a03db986600ca372a/tools/testing/selftests/sync/sync_merge.o /usr/src/perf_s=
elftests-x86_64-rhel-7.6-cd5bbb3047bf73353767d70a03db986600ca372a/tools/tes=
ting/selftests/sync/sync_wait.o /usr/src/perf_selftests-x86_64-rhel-7.6-cd5=
bbb3047bf73353767d70a03db986600ca372a/tools/testing/selftests/sync/sync_str=
ess_parallelism.o /usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf73353=
767d70a03db986600ca372a/tools/testing/selftests/sync/sync_stress_consumer.o=
 /usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047bf73353767d70a03db986600=
ca372a/tools/testing/selftests/sync/sync_stress_merge.o -O2 -g -std=3Dgnu89=
 -pthread -Wall -Wextra -I../../../../usr/include/ -pthread
TAP version 13
1..1
# selftests: sync: sync_test
# TAP version 13
# 1..10
# # [RUN]	Testing sync framework
# ok 1 [RUN]	test_alloc_timeline
# ok 2 [RUN]	test_alloc_fence
# ok 3 [RUN]	test_alloc_fence_negative
# ok 4 [RUN]	test_fence_one_timeline_wait
# ok 5 [RUN]	test_fence_one_timeline_merge
# ok 6 [RUN]	test_fence_merge_same_fence
# ok 7 [RUN]	test_fence_multi_timeline_wait
# ok 8 [RUN]	test_stress_two_threads_shared_timeline
# ok 9 [RUN]	test_consumer_stress_multi_producer_single_consumer
# ok 10 [RUN]	test_merge_stress_random_merge
# # Pass 10 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
ok 1 selftests: sync: sync_test
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047=
bf73353767d70a03db986600ca372a/tools/testing/selftests/sync'

2019-07-06 13:04:48 make run_tests -C sysctl
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb304=
7bf73353767d70a03db986600ca372a/tools/testing/selftests/sysctl'
TAP version 13
1..1
# selftests: sysctl: sysctl.sh
# Checking production write strict setting ... ok
# Sat Jul  6 13:04:48 CST 2019
# Running test: sysctl_test_0001 - run #0
# =3D=3D Testing sysctl behavior against /proc/sys/debug/test_sysctl/int_00=
01 =3D=3D
# Writing test file ... ok
# Checking sysctl is not set to test value ... ok
# Writing sysctl from shell ... ok
# Resetting sysctl to original value ... ok
# Writing entire sysctl in single write ... ok
# Writing middle of sysctl after synchronized seek ... ok
# Writing beyond end of sysctl ... ok
# Writing sysctl with multiple long writes ... ok
# Testing that 0x0000000100000000 fails as expected...ok
# Testing that 0x0000000100000001 fails as expected...ok
# Testing that 0x00000001ffffffff fails as expected...ok
# Testing that 0x0000000180000000 fails as expected...ok
# Testing that 0x000000017fffffff fails as expected...ok
# Testing that 0xffffffff00000000 fails as expected...ok
# Testing that 0xffffffff00000001 fails as expected...ok
# Testing that 0xffffffffffffffff fails as expected...ok
# Testing that 0xffffffff80000000 fails as expected...ok
# Testing that 0xffffffff7fffffff fails as expected...ok
# Testing that -0x0000000100000000 fails as expected...ok
# Testing that -0x0000000100000001 fails as expected...ok
# Testing that -0x00000001ffffffff fails as expected...ok
# Testing that -0x0000000180000000 fails as expected...ok
# Testing that -0x000000017fffffff fails as expected...ok
# Testing that -0xffffffff00000000 fails as expected...ok
# Testing that -0xffffffff00000001 fails as expected...ok
# Testing that -0xffffffffffffffff fails as expected...ok
# Testing that -0xffffffff80000000 fails as expected...ok
# Testing that -0xffffffff7fffffff fails as expected...ok
# Checking ignoring spaces up to PAGE_SIZE works on write ...ok
# Checking passing PAGE_SIZE of spaces fails on write ...ok
# Sat Jul  6 13:04:49 CST 2019
# Running test: sysctl_test_0002 - run #0
# =3D=3D Testing sysctl behavior against /proc/sys/debug/test_sysctl/string=
_0001 =3D=3D
# Writing test file ... ok
# Checking sysctl is not set to test value ... ok
# Writing sysctl from shell ... ok
# Resetting sysctl to original value ... ok
# Writing entire sysctl in single write ... ok
# Writing middle of sysctl after synchronized seek ... ok
# Writing beyond end of sysctl ... ok
# Writing sysctl with multiple long writes ... ok
# Writing entire sysctl in short writes ... ok
# Writing middle of sysctl after unsynchronized seek ... ok
# Checking sysctl maxlen is at least 65 ... ok
# Checking sysctl keeps original string on overflow append ... ok
# Checking sysctl stays NULL terminated on write ... ok
# Checking sysctl stays NULL terminated on overwrite ... ok
# Sat Jul  6 13:04:49 CST 2019
# Running test: sysctl_test_0003 - run #0
# =3D=3D Testing sysctl behavior against /proc/sys/debug/test_sysctl/int_00=
02 =3D=3D
# Writing test file ... ok
# Checking sysctl is not set to test value ... ok
# Writing sysctl from shell ... ok
# Resetting sysctl to original value ... ok
# Writing entire sysctl in single write ... ok
# Writing middle of sysctl after synchronized seek ... ok
# Writing beyond end of sysctl ... ok
# Writing sysctl with multiple long writes ... ok
# Testing that 0x0000000100000000 fails as expected...ok
# Testing that 0x0000000100000001 fails as expected...ok
# Testing that 0x00000001ffffffff fails as expected...ok
# Testing that 0x0000000180000000 fails as expected...ok
# Testing that 0x000000017fffffff fails as expected...ok
# Testing that 0xffffffff00000000 fails as expected...ok
# Testing that 0xffffffff00000001 fails as expected...ok
# Testing that 0xffffffffffffffff fails as expected...ok
# Testing that 0xffffffff80000000 fails as expected...ok
# Testing that 0xffffffff7fffffff fails as expected...ok
# Testing that -0x0000000100000000 fails as expected...ok
# Testing that -0x0000000100000001 fails as expected...ok
# Testing that -0x00000001ffffffff fails as expected...ok
# Testing that -0x0000000180000000 fails as expected...ok
# Testing that -0x000000017fffffff fails as expected...ok
# Testing that -0xffffffff00000000 fails as expected...ok
# Testing that -0xffffffff00000001 fails as expected...ok
# Testing that -0xffffffffffffffff fails as expected...ok
# Testing that -0xffffffff80000000 fails as expected...ok
# Testing that -0xffffffff7fffffff fails as expected...ok
# Checking ignoring spaces up to PAGE_SIZE works on write ...ok
# Checking passing PAGE_SIZE of spaces fails on write ...ok
# Testing INT_MAX works ...ok
# Testing INT_MAX + 1 will fail as expected...ok
# Testing negative values will work as expected...ok
# Sat Jul  6 13:04:49 CST 2019
# Running test: sysctl_test_0004 - run #0
# =3D=3D Testing sysctl behavior against /proc/sys/debug/test_sysctl/uint_0=
001 =3D=3D
# Writing test file ... ok
# Checking sysctl is not set to test value ... ok
# Writing sysctl from shell ... ok
# Resetting sysctl to original value ... ok
# Writing entire sysctl in single write ... ok
# Writing middle of sysctl after synchronized seek ... ok
# Writing beyond end of sysctl ... ok
# Writing sysctl with multiple long writes ... ok
# Testing that 0x0000000100000000 fails as expected...ok
# Testing that 0x0000000100000001 fails as expected...ok
# Testing that 0x00000001ffffffff fails as expected...ok
# Testing that 0x0000000180000000 fails as expected...ok
# Testing that 0x000000017fffffff fails as expected...ok
# Testing that 0xffffffff00000000 fails as expected...ok
# Testing that 0xffffffff00000001 fails as expected...ok
# Testing that 0xffffffffffffffff fails as expected...ok
# Testing that 0xffffffff80000000 fails as expected...ok
# Testing that 0xffffffff7fffffff fails as expected...ok
# Testing that -0x0000000100000000 fails as expected...ok
# Testing that -0x0000000100000001 fails as expected...ok
# Testing that -0x00000001ffffffff fails as expected...ok
# Testing that -0x0000000180000000 fails as expected...ok
# Testing that -0x000000017fffffff fails as expected...ok
# Testing that -0xffffffff00000000 fails as expected...ok
# Testing that -0xffffffff00000001 fails as expected...ok
# Testing that -0xffffffffffffffff fails as expected...ok
# Testing that -0xffffffff80000000 fails as expected...ok
# Testing that -0xffffffff7fffffff fails as expected...ok
# Checking ignoring spaces up to PAGE_SIZE works on write ...ok
# Checking passing PAGE_SIZE of spaces fails on write ...ok
# Testing UINT_MAX works ...ok
# Testing UINT_MAX + 1 will fail as expected...ok
# Testing negative values will not work as expected ...ok
# Sat Jul  6 13:04:50 CST 2019
# Running test: sysctl_test_0005 - run #0
# Testing array works as expected ... ok
# Testing skipping trailing array elements works ... ok
# Testing PAGE_SIZE limit on array works ... ok
# Testing exceeding PAGE_SIZE limit fails as expected ... ok
# Sat Jul  6 13:04:50 CST 2019
# Running test: sysctl_test_0005 - run #1
# Testing array works as expected ... ok
# Testing skipping trailing array elements works ... ok
# Testing PAGE_SIZE limit on array works ... ok
# Testing exceeding PAGE_SIZE limit fails as expected ... ok
# Sat Jul  6 13:04:50 CST 2019
# Running test: sysctl_test_0005 - run #2
# Testing array works as expected ... ok
# Testing skipping trailing array elements works ... ok
# Testing PAGE_SIZE limit on array works ... ok
# Testing exceeding PAGE_SIZE limit fails as expected ... ok
# Sat Jul  6 13:04:50 CST 2019
# Running test: sysctl_test_0006 - run #0
# Checking bitmap handler... ok
# Sat Jul  6 13:04:56 CST 2019
# Running test: sysctl_test_0006 - run #1
# Checking bitmap handler... ok
# Sat Jul  6 13:05:05 CST 2019
# Running test: sysctl_test_0006 - run #2
# Checking bitmap handler... ok
# Sat Jul  6 13:05:08 CST 2019
# Running test: sysctl_test_0006 - run #3
# Checking bitmap handler... ok
# Sat Jul  6 13:05:16 CST 2019
# Running test: sysctl_test_0006 - run #4
# Checking bitmap handler... ok
# Sat Jul  6 13:05:26 CST 2019
# Running test: sysctl_test_0006 - run #5
# Checking bitmap handler... ok
# Sat Jul  6 13:05:26 CST 2019
# Running test: sysctl_test_0006 - run #6
# Checking bitmap handler... ok
# Sat Jul  6 13:05:31 CST 2019
# Running test: sysctl_test_0006 - run #7
# Checking bitmap handler... ok
# Sat Jul  6 13:05:40 CST 2019
# Running test: sysctl_test_0006 - run #8
# Checking bitmap handler... ok
# Sat Jul  6 13:05:52 CST 2019
# Running test: sysctl_test_0006 - run #9
# Checking bitmap handler... ok
# Sat Jul  6 13:06:03 CST 2019
# Running test: sysctl_test_0006 - run #10
# Checking bitmap handler... ok
# Sat Jul  6 13:06:03 CST 2019
# Running test: sysctl_test_0006 - run #11
# Checking bitmap handler... ok
# Sat Jul  6 13:06:04 CST 2019
# Running test: sysctl_test_0006 - run #12
# Checking bitmap handler... ok
# Sat Jul  6 13:06:09 CST 2019
# Running test: sysctl_test_0006 - run #13
# Checking bitmap handler... ok
# Sat Jul  6 13:06:11 CST 2019
# Running test: sysctl_test_0006 - run #14
# Checking bitmap handler... ok
# Sat Jul  6 13:06:11 CST 2019
# Running test: sysctl_test_0006 - run #15
# Checking bitmap handler... ok
# Sat Jul  6 13:06:18 CST 2019
# Running test: sysctl_test_0006 - run #16
# Checking bitmap handler... ok
# Sat Jul  6 13:06:25 CST 2019
# Running test: sysctl_test_0006 - run #17
# Checking bitmap handler... ok
# Sat Jul  6 13:06:27 CST 2019
# Running test: sysctl_test_0006 - run #18
# Checking bitmap handler... ok
# Sat Jul  6 13:06:34 CST 2019
# Running test: sysctl_test_0006 - run #19
# Checking bitmap handler... ok
# Sat Jul  6 13:06:39 CST 2019
# Running test: sysctl_test_0006 - run #20
# Checking bitmap handler... ok
# Sat Jul  6 13:06:41 CST 2019
# Running test: sysctl_test_0006 - run #21
# Checking bitmap handler... ok
# Sat Jul  6 13:06:48 CST 2019
# Running test: sysctl_test_0006 - run #22
# Checking bitmap handler... ok
# Sat Jul  6 13:06:59 CST 2019
# Running test: sysctl_test_0006 - run #23
# Checking bitmap handler... ok
# Sat Jul  6 13:07:00 CST 2019
# Running test: sysctl_test_0006 - run #24
# Checking bitmap handler... ok
# Sat Jul  6 13:07:00 CST 2019
# Running test: sysctl_test_0006 - run #25
# Checking bitmap handler... ok
# Sat Jul  6 13:07:07 CST 2019
# Running test: sysctl_test_0006 - run #26
# Checking bitmap handler... ok
# Sat Jul  6 13:07:16 CST 2019
# Running test: sysctl_test_0006 - run #27
# Checking bitmap handler... ok
# Sat Jul  6 13:07:19 CST 2019
# Running test: sysctl_test_0006 - run #28
# Checking bitmap handler... ok
# Sat Jul  6 13:07:21 CST 2019
# Running test: sysctl_test_0006 - run #29
# Checking bitmap handler... ok
# Sat Jul  6 13:07:27 CST 2019
# Running test: sysctl_test_0006 - run #30
# Checking bitmap handler... ok
# Sat Jul  6 13:07:30 CST 2019
# Running test: sysctl_test_0006 - run #31
# Checking bitmap handler... ok
# Sat Jul  6 13:07:31 CST 2019
# Running test: sysctl_test_0006 - run #32
# Checking bitmap handler... ok
# Sat Jul  6 13:07:45 CST 2019
# Running test: sysctl_test_0006 - run #33
# Checking bitmap handler... ok
# Sat Jul  6 13:07:52 CST 2019
# Running test: sysctl_test_0006 - run #34
# Checking bitmap handler... ok
# Sat Jul  6 13:08:00 CST 2019
# Running test: sysctl_test_0006 - run #35
# Checking bitmap handler... ok
# Sat Jul  6 13:08:06 CST 2019
# Running test: sysctl_test_0006 - run #36
# Checking bitmap handler... ok
# Sat Jul  6 13:08:07 CST 2019
# Running test: sysctl_test_0006 - run #37
# Checking bitmap handler... ok
# Sat Jul  6 13:08:09 CST 2019
# Running test: sysctl_test_0006 - run #38
# Checking bitmap handler... ok
# Sat Jul  6 13:08:10 CST 2019
# Running test: sysctl_test_0006 - run #39
# Checking bitmap handler... ok
# Sat Jul  6 13:08:15 CST 2019
# Running test: sysctl_test_0006 - run #40
# Checking bitmap handler... ok
# Sat Jul  6 13:08:20 CST 2019
# Running test: sysctl_test_0006 - run #41
# Checking bitmap handler... ok
# Sat Jul  6 13:08:32 CST 2019
# Running test: sysctl_test_0006 - run #42
# Checking bitmap handler... ok
# Sat Jul  6 13:08:39 CST 2019
# Running test: sysctl_test_0006 - run #43
# Checking bitmap handler... ok
# Sat Jul  6 13:08:47 CST 2019
# Running test: sysctl_test_0006 - run #44
# Checking bitmap handler... ok
# Sat Jul  6 13:08:50 CST 2019
# Running test: sysctl_test_0006 - run #45
# Checking bitmap handler... ok
# Sat Jul  6 13:08:54 CST 2019
# Running test: sysctl_test_0006 - run #46
# Checking bitmap handler... ok
# Sat Jul  6 13:08:57 CST 2019
# Running test: sysctl_test_0006 - run #47
# Checking bitmap handler... ok
# Sat Jul  6 13:09:06 CST 2019
# Running test: sysctl_test_0006 - run #48
# Checking bitmap handler... ok
# Sat Jul  6 13:09:13 CST 2019
# Running test: sysctl_test_0006 - run #49
# Checking bitmap handler... ok
ok 1 selftests: sysctl: sysctl.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-cd5bbb3047=
bf73353767d70a03db986600ca372a/tools/testing/selftests/sysctl'

--i7KxW38SoMauyveo--
