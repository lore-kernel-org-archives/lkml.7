Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67268C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 13:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B952064A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 13:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555940249;
	bh=xQceLgE4GOqmOy1EnVQPHFmfIiFb8XhkYFKH96y9I/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lhpcPkS10KCZByav+yxjQxQs/V0ftC9LwWZwk4frVxZfvcnhZudZt8cr6Ihbaz9tH
	 QoKUhcdb+/PT5W6Bj/Lda/7m0LWZSFMn4W7m+pciF39b/zG8iaNHlryeb48nZvdHt+
	 rMKur7m5ViYEDMfV6RjfYOMeMjYd2uIeWPrz3+/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbfDVNhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 09:37:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36842 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbfDVN2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 09:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8VAeXYQhAceTMAWihPs9U6+XpVdyQlovkNBbfa8Vd8o=; b=TbTXRfzN9nrv64u8wnCulYfkTd
        CW5gBg3LeQy06X00i+MSRVZXufpLBBd1Eyq8Tf/TG9eVe9govF9aW8Ufk8HO1C6YjirODM14ZerlW
        kV0wggg0dTbD9xue+LjwiDL0eMfFlXxm29ovuiGdC+3u4PDklLzRLGothTVA0lv7txiUKh7pBRzRx
        i/BbeSFuVxgQmJWrWQ4Dy1R+kGUn+s6TCEKyen+svKI3+uv1eGEBuWo3ykdZkfsWVv22Y4q4Mh6pf
        FszBwxhdnbSk3NwZNurqAhmzvD6hmkCRTPAOcq+0xwJ3lm47lo9LKtftac5Kt36E849F3LoRm3pFa
        22xPbfsg==;
Received: from 179.176.125.229.dynamic.adsl.gvt.net.br ([179.176.125.229] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIYzU-0005HV-Jk; Mon, 22 Apr 2019 13:28:12 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hIYzS-0005jZ-9T; Mon, 22 Apr 2019 10:28:10 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v2 02/79] docs: trace: fix some Sphinx warnings
Date:   Mon, 22 Apr 2019 10:26:51 -0300
Message-Id: <f3b8a921f5c19e16dba40a7af5e2fc56baf93c74.1555938375.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555938375.git.mchehab+samsung@kernel.org>
References: <cover.1555938375.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some warnings produced when building trace. Fix them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/trace/ftrace.rst    |  1 +
 Documentation/trace/histogram.rst | 86 ++++++++++++++++---------------
 2 files changed, 45 insertions(+), 42 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 809b39d066ee..f60079259669 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -1435,6 +1435,7 @@ trace has provided some very helpful debugging information.
 
 If we prefer function graph output instead of function, we can set
 display-graph option::
+
  with echo 1 > options/display-graph
 
   # tracer: irqsoff
diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index 7612c7ad5715..2a6b23f779bb 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -2121,33 +2121,33 @@ The following commonly-used handler.action pairs are available:
     the end the event that triggered the snapshot (in this case you
     can verify the timestamps between the sched_waking and
     sched_switch events, which should match the time displayed in the
-    global maximum):
+    global maximum)::
 
-    # cat /sys/kernel/debug/tracing/snapshot
+     # cat /sys/kernel/debug/tracing/snapshot
 
-     <...>-2103  [005] d..3   309.873125: sched_switch: prev_comm=cyclictest prev_pid=2103 prev_prio=19 prev_state=D ==> next_comm=swapper/5 next_pid=0 next_prio=120
-     <idle>-0     [005] d.h3   309.873611: sched_waking: comm=cyclictest pid=2102 prio=19 target_cpu=005
-     <idle>-0     [005] dNh4   309.873613: sched_wakeup: comm=cyclictest pid=2102 prio=19 target_cpu=005
-     <idle>-0     [005] d..3   309.873616: sched_switch: prev_comm=swapper/5 prev_pid=0 prev_prio=120 prev_state=S ==> next_comm=cyclictest next_pid=2102 next_prio=19
-     <...>-2102  [005] d..3   309.873625: sched_switch: prev_comm=cyclictest prev_pid=2102 prev_prio=19 prev_state=D ==> next_comm=swapper/5 next_pid=0 next_prio=120
-     <idle>-0     [005] d.h3   309.874624: sched_waking: comm=cyclictest pid=2102 prio=19 target_cpu=005
-     <idle>-0     [005] dNh4   309.874626: sched_wakeup: comm=cyclictest pid=2102 prio=19 target_cpu=005
-     <idle>-0     [005] dNh3   309.874628: sched_waking: comm=cyclictest pid=2103 prio=19 target_cpu=005
-     <idle>-0     [005] dNh4   309.874630: sched_wakeup: comm=cyclictest pid=2103 prio=19 target_cpu=005
-     <idle>-0     [005] d..3   309.874633: sched_switch: prev_comm=swapper/5 prev_pid=0 prev_prio=120 prev_state=S ==> next_comm=cyclictest next_pid=2102 next_prio=19
-     <idle>-0     [004] d.h3   309.874757: sched_waking: comm=gnome-terminal- pid=1699 prio=120 target_cpu=004
-     <idle>-0     [004] dNh4   309.874762: sched_wakeup: comm=gnome-terminal- pid=1699 prio=120 target_cpu=004
-     <idle>-0     [004] d..3   309.874766: sched_switch: prev_comm=swapper/4 prev_pid=0 prev_prio=120 prev_state=S ==> next_comm=gnome-terminal- next_pid=1699 next_prio=120
- gnome-terminal--1699  [004] d.h2   309.874941: sched_stat_runtime: comm=gnome-terminal- pid=1699 runtime=180706 [ns] vruntime=1126870572 [ns]
-     <idle>-0     [003] d.s4   309.874956: sched_waking: comm=rcu_sched pid=9 prio=120 target_cpu=007
-     <idle>-0     [003] d.s5   309.874960: sched_wake_idle_without_ipi: cpu=7
-     <idle>-0     [003] d.s5   309.874961: sched_wakeup: comm=rcu_sched pid=9 prio=120 target_cpu=007
-     <idle>-0     [007] d..3   309.874963: sched_switch: prev_comm=swapper/7 prev_pid=0 prev_prio=120 prev_state=S ==> next_comm=rcu_sched next_pid=9 next_prio=120
-  rcu_sched-9     [007] d..3   309.874973: sched_stat_runtime: comm=rcu_sched pid=9 runtime=13646 [ns] vruntime=22531430286 [ns]
-  rcu_sched-9     [007] d..3   309.874978: sched_switch: prev_comm=rcu_sched prev_pid=9 prev_prio=120 prev_state=R+ ==> next_comm=swapper/7 next_pid=0 next_prio=120
-      <...>-2102  [005] d..4   309.874994: sched_migrate_task: comm=cyclictest pid=2103 prio=19 orig_cpu=5 dest_cpu=1
-      <...>-2102  [005] d..4   309.875185: sched_wake_idle_without_ipi: cpu=1
-     <idle>-0     [001] d..3   309.875200: sched_switch: prev_comm=swapper/1 prev_pid=0 prev_prio=120 prev_state=S ==> next_comm=cyclictest next_pid=2103 next_prio=19
+         <...>-2103  [005] d..3   309.873125: sched_switch: prev_comm=cyclictest prev_pid=2103 prev_prio=19 prev_state=D ==> next_comm=swapper/5 next_pid=0 next_prio=120
+         <idle>-0     [005] d.h3   309.873611: sched_waking: comm=cyclictest pid=2102 prio=19 target_cpu=005
+         <idle>-0     [005] dNh4   309.873613: sched_wakeup: comm=cyclictest pid=2102 prio=19 target_cpu=005
+         <idle>-0     [005] d..3   309.873616: sched_switch: prev_comm=swapper/5 prev_pid=0 prev_prio=120 prev_state=S ==> next_comm=cyclictest next_pid=2102 next_prio=19
+         <...>-2102  [005] d..3   309.873625: sched_switch: prev_comm=cyclictest prev_pid=2102 prev_prio=19 prev_state=D ==> next_comm=swapper/5 next_pid=0 next_prio=120
+         <idle>-0     [005] d.h3   309.874624: sched_waking: comm=cyclictest pid=2102 prio=19 target_cpu=005
+         <idle>-0     [005] dNh4   309.874626: sched_wakeup: comm=cyclictest pid=2102 prio=19 target_cpu=005
+         <idle>-0     [005] dNh3   309.874628: sched_waking: comm=cyclictest pid=2103 prio=19 target_cpu=005
+         <idle>-0     [005] dNh4   309.874630: sched_wakeup: comm=cyclictest pid=2103 prio=19 target_cpu=005
+         <idle>-0     [005] d..3   309.874633: sched_switch: prev_comm=swapper/5 prev_pid=0 prev_prio=120 prev_state=S ==> next_comm=cyclictest next_pid=2102 next_prio=19
+         <idle>-0     [004] d.h3   309.874757: sched_waking: comm=gnome-terminal- pid=1699 prio=120 target_cpu=004
+         <idle>-0     [004] dNh4   309.874762: sched_wakeup: comm=gnome-terminal- pid=1699 prio=120 target_cpu=004
+         <idle>-0     [004] d..3   309.874766: sched_switch: prev_comm=swapper/4 prev_pid=0 prev_prio=120 prev_state=S ==> next_comm=gnome-terminal- next_pid=1699 next_prio=120
+     gnome-terminal--1699  [004] d.h2   309.874941: sched_stat_runtime: comm=gnome-terminal- pid=1699 runtime=180706 [ns] vruntime=1126870572 [ns]
+         <idle>-0     [003] d.s4   309.874956: sched_waking: comm=rcu_sched pid=9 prio=120 target_cpu=007
+         <idle>-0     [003] d.s5   309.874960: sched_wake_idle_without_ipi: cpu=7
+         <idle>-0     [003] d.s5   309.874961: sched_wakeup: comm=rcu_sched pid=9 prio=120 target_cpu=007
+         <idle>-0     [007] d..3   309.874963: sched_switch: prev_comm=swapper/7 prev_pid=0 prev_prio=120 prev_state=S ==> next_comm=rcu_sched next_pid=9 next_prio=120
+      rcu_sched-9     [007] d..3   309.874973: sched_stat_runtime: comm=rcu_sched pid=9 runtime=13646 [ns] vruntime=22531430286 [ns]
+      rcu_sched-9     [007] d..3   309.874978: sched_switch: prev_comm=rcu_sched prev_pid=9 prev_prio=120 prev_state=R+ ==> next_comm=swapper/7 next_pid=0 next_prio=120
+          <...>-2102  [005] d..4   309.874994: sched_migrate_task: comm=cyclictest pid=2103 prio=19 orig_cpu=5 dest_cpu=1
+          <...>-2102  [005] d..4   309.875185: sched_wake_idle_without_ipi: cpu=1
+         <idle>-0     [001] d..3   309.875200: sched_switch: prev_comm=swapper/1 prev_pid=0 prev_prio=120 prev_state=S ==> next_comm=cyclictest next_pid=2103 next_prio=19
 
   - onchange(var).save(field,..	.)
 
@@ -2201,9 +2201,10 @@ The following commonly-used handler.action pairs are available:
     following the rest of the fields.
 
     If a snaphot was taken, there is also a message indicating that,
-    along with the value and event that triggered the snapshot:
+    along with the value and event that triggered the snapshot::
+
+      # cat /sys/kernel/debug/tracing/events/tcp/tcp_probe/hist
 
-    # cat /sys/kernel/debug/tracing/events/tcp/tcp_probe/hist
       { dport:       1521 } hitcount:          8
 	changed:         10  snd_wnd:      35456  srtt:     154262  rcv_wnd:      42112
 
@@ -2216,14 +2217,15 @@ The following commonly-used handler.action pairs are available:
       { dport:        443 } hitcount:        211
 	changed:         10  snd_wnd:      26960  srtt:      17379  rcv_wnd:      28800
 
-    Snapshot taken (see tracing/snapshot).  Details:
+    Snapshot taken (see tracing/snapshot).  Details::
+
         triggering value { onchange($cwnd) }:         10
         triggered by event with key: { dport:         80 }
 
-    Totals:
-        Hits: 414
-        Entries: 4
-        Dropped: 0
+      Totals:
+          Hits: 414
+          Entries: 4
+          Dropped: 0
 
     In the above case, the event that triggered the snapshot has the
     key with dport == 80.  If you look at the bucket that has 80 as
@@ -2233,18 +2235,18 @@ The following commonly-used handler.action pairs are available:
     the global snapshot).
 
     And finally, looking at the snapshot data should show at or near
-    the end the event that triggered the snapshot:
+    the end the event that triggered the snapshot::
 
-    # cat /sys/kernel/debug/tracing/snapshot
+      # cat /sys/kernel/debug/tracing/snapshot
 
-       gnome-shell-1261  [006] dN.3    49.823113: sched_stat_runtime: comm=gnome-shell pid=1261 runtime=49347 [ns] vruntime=1835730389 [ns]
-     kworker/u16:4-773   [003] d..3    49.823114: sched_switch: prev_comm=kworker/u16:4 prev_pid=773 prev_prio=120 prev_state=R+ ==> next_comm=kworker/3:2 next_pid=135 next_prio=120
-       gnome-shell-1261  [006] d..3    49.823114: sched_switch: prev_comm=gnome-shell prev_pid=1261 prev_prio=120 prev_state=R+ ==> next_comm=kworker/6:2 next_pid=387 next_prio=120
-       kworker/3:2-135   [003] d..3    49.823118: sched_stat_runtime: comm=kworker/3:2 pid=135 runtime=5339 [ns] vruntime=17815800388 [ns]
-       kworker/6:2-387   [006] d..3    49.823120: sched_stat_runtime: comm=kworker/6:2 pid=387 runtime=9594 [ns] vruntime=14589605367 [ns]
-       kworker/6:2-387   [006] d..3    49.823122: sched_switch: prev_comm=kworker/6:2 prev_pid=387 prev_prio=120 prev_state=R+ ==> next_comm=gnome-shell next_pid=1261 next_prio=120
-       kworker/3:2-135   [003] d..3    49.823123: sched_switch: prev_comm=kworker/3:2 prev_pid=135 prev_prio=120 prev_state=T ==> next_comm=swapper/3 next_pid=0 next_prio=120
-            <idle>-0     [004] ..s7    49.823798: tcp_probe: src=10.0.0.10:54326 dest=23.215.104.193:80 mark=0x0 length=32 snd_nxt=0xe3ae2ff5 snd_una=0xe3ae2ecd snd_cwnd=10 ssthresh=2147483647 snd_wnd=28960 srtt=19604 rcv_wnd=29312
+         gnome-shell-1261  [006] dN.3    49.823113: sched_stat_runtime: comm=gnome-shell pid=1261 runtime=49347 [ns] vruntime=1835730389 [ns]
+       kworker/u16:4-773   [003] d..3    49.823114: sched_switch: prev_comm=kworker/u16:4 prev_pid=773 prev_prio=120 prev_state=R+ ==> next_comm=kworker/3:2 next_pid=135 next_prio=120
+         gnome-shell-1261  [006] d..3    49.823114: sched_switch: prev_comm=gnome-shell prev_pid=1261 prev_prio=120 prev_state=R+ ==> next_comm=kworker/6:2 next_pid=387 next_prio=120
+         kworker/3:2-135   [003] d..3    49.823118: sched_stat_runtime: comm=kworker/3:2 pid=135 runtime=5339 [ns] vruntime=17815800388 [ns]
+         kworker/6:2-387   [006] d..3    49.823120: sched_stat_runtime: comm=kworker/6:2 pid=387 runtime=9594 [ns] vruntime=14589605367 [ns]
+         kworker/6:2-387   [006] d..3    49.823122: sched_switch: prev_comm=kworker/6:2 prev_pid=387 prev_prio=120 prev_state=R+ ==> next_comm=gnome-shell next_pid=1261 next_prio=120
+         kworker/3:2-135   [003] d..3    49.823123: sched_switch: prev_comm=kworker/3:2 prev_pid=135 prev_prio=120 prev_state=T ==> next_comm=swapper/3 next_pid=0 next_prio=120
+              <idle>-0     [004] ..s7    49.823798: tcp_probe: src=10.0.0.10:54326 dest=23.215.104.193:80 mark=0x0 length=32 snd_nxt=0xe3ae2ff5 snd_una=0xe3ae2ecd snd_cwnd=10 ssthresh=2147483647 snd_wnd=28960 srtt=19604 rcv_wnd=29312
 
 3. User space creating a trigger
 --------------------------------
-- 
2.20.1

