Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D46CCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF17120717
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731237AbfJ2JL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:11:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:37924 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731202AbfJ2JL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:11:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 179E3B149;
        Tue, 29 Oct 2019 09:11:23 +0000 (UTC)
Message-ID: <277737d6034b3da072d3b0b808d2fa6e110038b0.camel@suse.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
From:   Dario Faggioli <dfaggioli@suse.com>
To:     Aaron Lu <aaron.lu@linux.alibaba.com>,
        Aubrey Li <aubrey.intel@gmail.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?ISO-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Dario Faggioli <dfaggioli@suse.com>
Date:   Tue, 29 Oct 2019 10:11:20 +0100
In-Reply-To: <20190915141402.GA1349@aaronlu>
References: <20190726152101.GA27884@sinkpad>
         <7dc86e3c-aa3f-905f-3745-01181a3b0dac@linux.intel.com>
         <20190802153715.GA18075@sinkpad>
         <eec72c2d533b7600c63de3c8001cc6ab9e915afe.camel@suse.com>
         <69cd9bca-da28-1d35-3913-1efefe0c1c22@linux.intel.com>
         <fab8eabb-1cfa-9bf6-02af-3afdff3f955d@linux.intel.com>
         <20190911140204.GA52872@aaronlu>
         <7b001860-05b4-4308-df0e-8b60037b8000@linux.intel.com>
         <20190912120400.GA16200@aaronlu>
         <CAERHkrsrszO4hJqVy=g7P74h9d_YJzW7GY4ptPKykTX-mc9Mdg@mail.gmail.com>
         <20190915141402.GA1349@aaronlu>
Organization: SUSE
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-h0/nX3m++BWk5iLht9C2"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-h0/nX3m++BWk5iLht9C2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2019-09-15 at 22:14 +0800, Aaron Lu wrote:
> I'm using the following branch as base which is v5.1.5 based:
> https://github.com/digitalocean/linux-coresched coresched-v3-v5.1.5-
> test
>=20
> And I have pushed Tim's branch to:
> https://github.com/aaronlu/linux coresched-v3-v5.1.5-test-tim
>=20
> Mine:
> https://github.com/aaronlu/linux coresched-v3-v5.1.5-test-
> core_vruntime
>=20
Hello,

As anticipated, I've been trying to follow the development of this
feature and, in the meantime, I have done some benchmarks.

I actually have a lot of data (and am planning for more), so I am
sending a few emails, each one with a subset of the numbers in it,
instead than just one which would be beyond giant! :-)

I'll put, in this first one, some background and some common
information, e.g., about the benchmarking platform and configurations,
and on how to read and interpreet the data that will follow.

It's quite hard to come up with a concise summary, and sometimes it's
even tricky to identify consolidated trends. There are also things that
looks weird and, although I double checked my methodology, I can't
exclude that of glitches or errors may have occurred. For each of the
benchmark, I have at least some information about what the
configuration was when it was run, and also some monitorning and perf
data. So, if interested, try to ask and we'll see what we can dig out.

And in any case, I have the procedure for running these benchmarks
fairly decently (although not completely) automated. So if we see
things that looks really really weird, I can rerun (perhaps with
different configuration, more monitoring, etc).

For each benchmark, I'll "dump" the results, with just some comments
about the things that I find more relevant/interesting. Then, if we
want, we can look at them and analyze them together.
For each experiment, I do have some limited amount of tracing and
debugging information still available, in case it could be useful. And,
as said, I can always rerun.

I can also provide, quite easily, different looking tables. E.g.,
different set of columns, different baselines, etc. Just as what you
thinks it would be the most interesting to see, and, most likely, it
will be possible to do it.

Oh, and I'll upload text files whose contents will be identical to the
emails in this space:

  http://xenbits.xen.org/people/dariof/benchmarks/results/linux/core-sched/=
mmtests/boxes/wayrath/

In case tables are rendered better in a browser than in a MUA.

Thanks and Regards,
Dario
---

Code:=20
 1) Linux 5.1.5 (commit id 835365932f0dc25468840753e071c05ad6abc76f)
 2) https://github.com/digitalocean/linux-coresched/tree/vpillai/coresched-=
v3-v5.1.5-test
 3) https://github.com/aaronlu/linux/tree/coresched-v3-v5.1.5-test-core_vru=
ntime
 4) https://github.com/aaronlu/linux/tree/coresched-v3-v5.1.5-test-tim

Benchmarking suite:
 - MMTests: https://github.com/gormanm/mmtests
 - Tweaked to deal with running benchmarks in VMs. Still working on
   upstreaming that to Mel (a WIP is available here:
   https://github.com/dfaggioli/mmtests/tree/bench-virt )

Benchmarking host:
 - CPU: 1 socket, 4 cores, 2 threads
 - RAM: 32 GB
 - distro: opneSUSE Tumbleweed
 - HW Bugs Mitigations: fully disabled
 - Filesys: XFS

VMs:
 - vCPUs: either 8 or 4
 - distro: opneSUSE Tumbleweed
 - Kernel: 5.1.16
 - HW Bugs Mitigations: fully disabled
 - Filesys: XFS

Benchmarks:
- STREAM         : pure memory benchmark (various kind of mem-ops done
                   in parallel). Parallelism is NR_CPUS/2 tasks
- Kernbench      : builds a kernel, with varying number of compile
                   jobs. HT is, in general, known to help, as it let=20
                   us do "more parallel" builds
- Hackbench      : communication (via pipes, in this case) between
                   group of processes. As we deal with _groups_ of
                   tasks, we're already in saturation with 1 group,
                   hence we expect HyperThreading disabled
                   configurations to suffer
- mutilate       : load generator for memcached, with high request
                   rate;
- netperf-unix   : two communicating tasks. Without any pinning
                   (neither at the host nor at the guest level), we
                   expect HT to play a role. In fact, depending on
                   where the two task are scheduler (i.e., whether on
                   two core of the same thread, or not) performance may
                   vary
- sysbenchcpu    : the process-based CPU stressing workload of sysbench
- sysbenchthread : the thread-based CPU stressing workload of sysbench
- sysbench       : the database workload

This is kind of a legend for the columns you will see in the tables.

- v-*   : vanilla, i.e., benchmarks were run on code _without_ any
          core-scheduling patch applied (see 1 in 'Code' section above)
- *BM-* : baremetal, i.e., benchmarks were run on the host, without=20
          any VM running or anything
- *VM-* : Virtual Machine, i.e., benchmarks were run inside a VM, with
          the following haracteristics:
   - *VM-   : benchmarks were run in a VM with 8 vCPUs. That was the
              only VM running in the system
   - *VM-v4 : benchmarks were run in a VM with 4 vCPUs. That was the
              only VM running in the system
   - *VMx2  : benchmark were run in a VM with 8 vCPUs, and there was
              another VM running, also with 8 vCPUS, generating CPU,
              memory and IO stress load for about 600%
- *-csc-*          : benchmarks were run with Core scheduling v3 patch
                     series (see 2 in 'Code' section above)
- *-csc_stallfix-* : benchmarks were run with Core scheduling v3 and
                     the 'stallfix' feature enabled
- *-csc_vruntime-* : benchmarks were run with Core scheduling v3 + the
                     vruntime patches (see 3 in 'Code' section above)
- *-csc-_tim-*     : benchmarks were run with Core scheduling v3 +
                     Tim's patches (see 4 in 'Code' section above)
- *-noHT           : benchmarks were run with HyperThreading Disabled
- *-HT             : benchmarks were run with Hyperthreading enabled

So, for instance, the column BM-noHT shows data from a run done on
baremetal, with HyperThreading disabled. The column v-VM-HT shows data
from a run done in a 8 vCPUs VM, with HyperThreading enabled, and no
core-scheduling patches applied. The column VM-csc_vruntime-HT shows
data from a run done in a 8 vCPUs VM with core-scheduling v3 patches +
the vruntime patches applied. The column VM-v4-HT shows data from a run
done in a 4 vCPUs VM, core-scheduling patches were applied but not used
(the vCPUs of the VM weren't tagged). The column VMx2-csc_vruntime-HT
shows data from a run done in a 8 vCPUs VM, core-scheduling v3 + Tim's
patchs were applied and the vCPUs of the VM tagged, while there was
another (untagged) VM in the system, trying to introduce ~600% load
(CPU, memory and IO, via stress-ng). Etc.

See the 'Appendix' at the bottom of this email, for a comprehensive
list of all the combinations (or, at least I think is comprehensive...
I hope I haven't missed any :-) ).

In all tables, percent increase and decrease are always relative to the
first column. It is already taken care of whether lower or higher
values are better.
Basically, when we see -x.yz%, it always means performance are worse
than the baseline, and the absolute value of that (i.e., x.yz) tells
you by how much.

If, for instance, we want to compare HT and non HT, on baremetal, we
check the BM-HT and BM-noHT columns.
If we want to compare v3 + vruntime patches against no HyperThreading,
when the system is overloaded, we look at VMx2-noHT and VMx2-
csc_vruntime-HT columns and check by how much they deviates from the
baseline (i.e., which one regresses more). For comparing, the various
core scheduling solutions, we can check by how much each one is either
better or worse than baseline. And so on...

The most relevant comparisons, IMO, are:
- the various core scheduling solutions against their respective HT
baseline. This, in fact, tells us what people will experience if they
start using core scheduling on these workloads
- the various core scheduling solutions against their respective noHT
baseline. This, in fact, tells use whether or not core scheduling is
effective, for the given workload, or if it would just be better to
disable HyperThreading
- the overhead introduced by the core scheduling patches, when they are
not used (i.e., v-BM-HT against BM-HT, or v-VM-HT against VM-HT). This,
in fact, tells us what happens to *everyone*, including the ones that
do not want core scheduling and will keep it disabled, if we merge it

Note that the overhead, so far, has been evaluated only for the -csc
case, i.e., when patches from point 2 in 'Code' above are applied, but
tasks/vCPUs are not tagged, and hence core scheduling is not really
used,

Anyway, let's get to the point where I give you some data already! :-D
:-D

STREAM
=3D=3D=3D=3D=3D=3D

http://xenbits.xen.org/people/dariof/benchmarks/results/linux/core-sched/mm=
tests/boxes/wayrath/coresched-email-1_stream.txt

                                  v                      v                 =
    BM                     BM                     BM                     BM=
                     BM                     BM
                              BM-HT                BM-noHT                 =
    HT                   noHT                 csc-HT        csc_stallfix-HT=
             csc_tim-HT        csc_vruntime-HT
MB/sec copy     33827.50 (   0.00%)    33654.32 (  -0.51%)    33683.34 (  -=
0.43%)    33819.30 (  -0.02%)    33830.88 (   0.01%)    33731.02 (  -0.29%)=
    33573.76 (  -0.75%)    33292.76 (  -1.58%)
MB/sec scale    22762.02 (   0.00%)    22524.00 (  -1.05%)    22416.54 (  -=
1.52%)    22444.16 (  -1.40%)    22652.56 (  -0.48%)    22462.80 (  -1.31%)=
    22461.90 (  -1.32%)    22670.84 (  -0.40%)
MB/sec add      26141.76 (   0.00%)    26241.42 (   0.38%)    26559.40 (   =
1.60%)    26365.36 (   0.86%)    26607.10 (   1.78%)    26384.50 (   0.93%)=
    26117.78 (  -0.09%)    26192.12 (   0.19%)
MB/sec triad    26522.46 (   0.00%)    26555.26 (   0.12%)    26499.62 (  -=
0.09%)    26373.26 (  -0.56%)    26667.32 (   0.55%)    26642.70 (   0.45%)=
    26505.38 (  -0.06%)    26409.60 (  -0.43%)
                                  v                      v                 =
    VM                     VM                     VM                     VM=
                     VM                     VM
                              VM-HT                VM-noHT                 =
    HT                   noHT                 csc-HT        csc_stallfix-HT=
             csc_tim-HT        csc_vruntime-HT
MB/sec copy     34559.32 (   0.00%)    34153.30 (  -1.17%)    34236.64 (  -=
0.93%)    33724.38 (  -2.42%)    33535.60 (  -2.96%)    33534.10 (  -2.97%)=
    33469.70 (  -3.15%)    33873.18 (  -1.99%)
MB/sec scale    22556.18 (   0.00%)    22834.88 (   1.24%)    22733.12 (   =
0.78%)    23010.46 (   2.01%)    22480.60 (  -0.34%)    22552.94 (  -0.01%)=
    22756.50 (   0.89%)    22434.96 (  -0.54%)
MB/sec add      26209.70 (   0.00%)    26640.08 (   1.64%)    26692.54 (   =
1.84%)    26747.40 (   2.05%)    26358.20 (   0.57%)    26353.50 (   0.55%)=
    26686.62 (   1.82%)    26256.50 (   0.18%)
MB/sec triad    26521.80 (   0.00%)    26490.26 (  -0.12%)    26598.66 (   =
0.29%)    26466.30 (  -0.21%)    26560.48 (   0.15%)    26496.30 (  -0.10%)=
    26609.10 (   0.33%)    26450.68 (  -0.27%)
                                  v                      v                 =
    VM                     VM                     VM                     VM=
                     VM                     VM
                           VM-v4-HT             VM-v4-noHT                 =
 v4-HT                v4-noHT              v4-csc-HT     v4-csc_stallfix-HT=
          v4-csc_tim-HT     v4-csc_vruntime-HT
MB/sec copy     32257.48 (   0.00%)    32504.18 (   0.76%)    32375.66 (   =
0.37%)    32261.98 (   0.01%)    31940.84 (  -0.98%)    32070.88 (  -0.58%)=
    31926.80 (  -1.03%)    31882.18 (  -1.16%)
MB/sec scale    19806.46 (   0.00%)    20281.18 (   2.40%)    20266.80 (   =
2.32%)    20075.46 (   1.36%)    19847.66 (   0.21%)    20119.00 (   1.58%)=
    19899.84 (   0.47%)    20060.48 (   1.28%)
MB/sec add      22178.58 (   0.00%)    22426.92 (   1.12%)    22185.54 (   =
0.03%)    22153.52 (  -0.11%)    21975.80 (  -0.91%)    22097.72 (  -0.36%)=
    21827.66 (  -1.58%)    22068.04 (  -0.50%)
MB/sec triad    22149.10 (   0.00%)    22200.54 (   0.23%)    22142.10 (  -=
0.03%)    21933.04 (  -0.98%)    21898.50 (  -1.13%)    22160.64 (   0.05%)=
    22003.40 (  -0.66%)    21951.16 (  -0.89%)
                                  v                      v                 =
  VMx2                   VMx2                   VMx2                   VMx2=
                   VMx2                   VMx2
                            VMx2-HT              VMx2-noHT                 =
    HT                   noHT                 csc-HT        csc_stallfix-HT=
             csc_tim-HT        csc_vruntime-HT
MB/sec copy     33514.96 (   0.00%)    24740.70 ( -26.18%)    30410.96 (  -=
9.26%)    22157.24 ( -33.89%)    29552.60 ( -11.82%)    29374.78 ( -12.35%)=
    28717.38 ( -14.31%)    29143.88 ( -13.04%)
MB/sec scale    22605.74 (   0.00%)    15473.56 ( -31.55%)    19051.76 ( -1=
5.72%)    15278.64 ( -32.41%)    19246.98 ( -14.86%)    19081.04 ( -15.59%)=
    18747.60 ( -17.07%)    18776.02 ( -16.94%)
MB/sec add      26249.56 (   0.00%)    18559.92 ( -29.29%)    21143.90 ( -1=
9.45%)    18664.30 ( -28.90%)    21236.00 ( -19.10%)    21067.40 ( -19.74%)=
    20878.78 ( -20.46%)    21266.92 ( -18.98%)
MB/sec triad    26290.16 (   0.00%)    19274.10 ( -26.69%)    20573.62 ( -2=
1.74%)    17631.52 ( -32.93%)    21066.94 ( -19.87%)    20975.04 ( -20.22%)=
    20944.56 ( -20.33%)    20942.18 ( -20.34%)

So, STREAM, at least in this configuration, it is not (as it could have
been expected) really sensitive to HyperThreading. In fact, in most
cases, both when run on baremetal and in VMs, HT and noHT results are
pretty much the same. When core scheduling is used, things does not
look bad at all to me, although results are, most of the time, only
marginally worse.

Do check, however, the overloaded case. There, disabling HT has quite a
big impact, and core scheduling does a rather good job in restoring
good performance.

=46rom the overhead point of view, the situation does not look too bad
either. In fact, in the first three group of measurements, the overhead
introduced by having core scheduling patches in, is acceptable (there
are actually cases where they seem to do more good than harm! :-P).
However, when the system is overloaded, despite there not being any
tagged task, numbers look pretty bad. It seems that, for instance, of
the 13.04% performance drop between v-VMx2-HT and VMx2-csc_vruntime-HT,=20
9.26% comes from overhead (as that's there already in VMx2-HT)!!

Something to investigate better, I guess...


Appendix

* v-BM-HT      : no coresched patch applied, baremetal, HyperThreading enab=
led
* v-BM-noHT    : no coresched patch applied, baremetal, Hyperthreading disa=
bled
* v-VM-HT      : no coresched patch applied, 8 vCPUs VM, HyperThreading ena=
bled
* v-VM-noHT    : no coresched patch applied, 8 vCPUs VM, Hyperthreading dis=
abled
* v-VM-v4-HT   : no coresched patch applied, 4 vCPUs VM, HyperThreading ena=
bled
* v-VM-v4-noHT : no coresched patch applied, 4 vCPUs VM, Hyperthreading dis=
abled
* v-VMx2-HT    : no coresched patch applied, 8 vCPUs VM + 600% stress overh=
ead, HyperThreading enabled
* v-VMx2-noHT  : no coresched patch applied, 8 vCPUs VM + 600% stress overh=
ead, Hyperthreading disabled

* BM-HT              : baremetal, HyperThreading enabled
* BM-noHT            : baremetal, Hyperthreading disabled
* BM-csc-HT          : baremetal, coresched-v3 (Hyperthreading enabled, of =
course)
* BM-csc_stallfix-HT : baremetal, coresched-v3 + stallfix (Hyperthreading e=
nabled, of course)
* BM-csc_tim-HT      : baremetal, coresched-v3 + Tim's patches (Hyperthread=
ing enabeld, of course)
* BM-csc_vruntime-HT : baremetal, coresched-v3 + vruntime patches (Hyperthr=
eading enabled, of course)

* VM-HT              : 8 vCPUs VM, HyperThreading enabled
* VM-noHT            : 8 vCPUs VM, Hyperthreading disabled
* VM-csc-HT          : 8 vCPUs VM, coresched-v3 (Hyperthreading enabled, of=
 course)
* VM-csc_stallfix-HT : 8 vCPUs VM, coresched-v3 + stallfix (Hyperthreading =
enabled, of course)
* VM-csc_tim-HT      : 8 vCPUs VM, coresched-v3 + Tim's patches (Hyperthrea=
ding enabeld, of course)
* VM-csc_vruntime-HT : 8 vCPUs VM, coresched-v3 + vruntime patches (Hyperth=
reading enabled, of course)

* VM-v4-HT              : 4 vCPUs VM, HyperThreading enabled
* VM-v4-noHT            : 4 vCPUs VM, Hyperthreading disabled
* VM-v4-csc-HT          : 4 vCPUs VM, coresched-v3 (Hyperthreading enabled,=
 of course)
* VM-v4-csc_stallfix-HT : 4 vCPUs VM, coresched-v3 + stallfix (Hyperthreadi=
ng enabled, of course)
* VM-v4-csc_tim-HT      : 4 vCPUs VM, coresched-v3 + Tim's patches (Hyperth=
reading enabeld, of course)
* VM-v4-csc_vruntime-HT : 4 vCPUs VM, coresched-v3 + vruntime patches (Hype=
rthreading enabled, of course)

* VMx2-HT              : 8 vCPUs VM + 600% stress overhead, HyperThreading =
enabled
* VMx2-noHT            : 8 vCPUs VM + 600% stress overhead, Hyperthreading =
disabled
* VMx2-csc-HT          : 8 vCPUs VM + 600% stress overhead, coresched-v3 (H=
yperthreading enabled, of course)
* VMx2-csc_stallfix-HT : 8 vCPUs VM + 600% stress overhead, coresched-v3 + =
stallfix (Hyperthreading enabled, of course)
* VMx2-csc_tim-HT      : 8 vCPUs VM + 600% stress overhead, coresched-v3 + =
Tim's patches (Hyperthreading enabeld, of course)
* VMx2-csc_vruntime-HT : 8 vCPUs VM + 600% stress overhead,
                        coresched-v3 + vruntime patches (Hyperthreading ena=
bled, of course)

--=20
Dario Faggioli, Ph.D
http://about.me/dario.faggioli
Virtualization Software Engineer
SUSE Labs, SUSE https://www.suse.com/
-------------------------------------------------------------------
<<This happens because _I_ choose it to happen!>> (Raistlin Majere)


--=-h0/nX3m++BWk5iLht9C2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEES5ssOj3Vhr0WPnOLFkJ4iaW4c+4FAl24AjgACgkQFkJ4iaW4
c+7VlRAAlcv197oI8/iBOWdRdSdAIGhb1j0cOoslJoMbwAfruQX01b+/KTcofNVz
h+DDpWC/MXsK71SRCERcfxyOqTWR8vdP+QxgJi4iiNYOsEd1UvZJ+IdLSHRO8rNu
Qfxq2G/1qoaaCypFJ0YviFr8LGrjEUfZeUkmeslZoYm5nRhnNaXFPV78Afakt2UB
deDgefQHSy2dbO4eypsR8mIKTFJoVEZz9gZTQEju2JGZv0HlTMFp89yGZpg5EL01
DUo2WHb42ovgVkBSssirUdDN09wd2CpgFvRnrGWWCDgpFJy6KI2z2DrX5lcmCadq
IcOwufSOFC/XWVn3RNS+3zcwk/GuMWNUHIHYxoKFa8Cho33mmqiUYQqqFjDepaD5
kTCGRzb05CGcqY+1SHGyBq8hSgzyBiUDQskbuLFLn4HmBlhZHu33rfXkEiCeWc0/
2p75OfSt7a2SwqoI9LGC5jKGpu6N2xL+rLbFecDQ22Z7pgadeiDqQx/cKe0KgWTs
G5QA+koQIiCvrlzlhm8V+prkpRyDadsjxz6kViHbKuD9FJdhJeqyAZoN0oqVsa+W
er+esz0ScXxvbS5ir7DKL4Dlcu7fpO9jrqWuW9gDms+P9/wylAbnhds9OzM4Ne0p
fKzZ2d0fSDLkwKCitDGbtJfD2Qx7ZmiKhvKIS9qBQqDfuqQuPV4=
=Wlfz
-----END PGP SIGNATURE-----

--=-h0/nX3m++BWk5iLht9C2--

