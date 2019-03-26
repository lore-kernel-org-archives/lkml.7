Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D20C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 428C220811
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733089AbfCZXbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:31:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52900 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732979AbfCZXbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:31:31 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QNT3MJ043063
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:31:29 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rfunyccm0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:31:28 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Mar 2019 23:31:25 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Mar 2019 23:31:19 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2QNVIPl18219054
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 23:31:18 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84755B2064;
        Tue, 26 Mar 2019 23:31:18 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52010B2065;
        Tue, 26 Mar 2019 23:31:18 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Mar 2019 23:31:18 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 71A4316C60F7; Tue, 26 Mar 2019 16:31:19 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 2/9] tools/.../rcutorture: Convert to SPDX license identifier
Date:   Tue, 26 Mar 2019 16:31:11 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190326233054.GA21523@linux.ibm.com>
References: <20190326233054.GA21523@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19032623-0052-0000-0000-000003A18888
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010820; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01180139; UDB=6.00617576; IPR=6.00960854;
 MB=3.00026170; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-26 23:31:24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032623-0053-0000-0000-00006048DFB6
Message-Id: <20190326233118.23057-2-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903260158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the license boiler plate with a SPDX license identifier.
While in the area, update an email address and add copyright notices.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 .../selftests/rcutorture/bin/configNR_CPUS.sh  | 17 ++---------------
 .../rcutorture/bin/config_override.sh          | 17 ++---------------
 .../selftests/rcutorture/bin/configcheck.sh    | 18 +++---------------
 .../selftests/rcutorture/bin/configinit.sh     | 17 ++---------------
 .../selftests/rcutorture/bin/cpus2use.sh       | 17 ++---------------
 .../selftests/rcutorture/bin/functions.sh      | 17 ++---------------
 .../testing/selftests/rcutorture/bin/jitter.sh | 17 ++---------------
 .../selftests/rcutorture/bin/kvm-build.sh      | 17 ++---------------
 .../rcutorture/bin/kvm-find-errors.sh          |  5 +++++
 .../rcutorture/bin/kvm-recheck-lock.sh         | 17 ++---------------
 .../rcutorture/bin/kvm-recheck-rcu.sh          | 17 ++---------------
 .../bin/kvm-recheck-rcuperf-ftrace.sh          | 17 ++---------------
 .../rcutorture/bin/kvm-recheck-rcuperf.sh      | 17 ++---------------
 .../selftests/rcutorture/bin/kvm-recheck.sh    | 17 ++---------------
 .../selftests/rcutorture/bin/kvm-test-1-run.sh | 17 ++---------------
 tools/testing/selftests/rcutorture/bin/kvm.sh  | 17 ++---------------
 .../selftests/rcutorture/bin/mkinitrd.sh       | 15 +--------------
 .../selftests/rcutorture/bin/parse-build.sh    | 17 ++---------------
 .../selftests/rcutorture/bin/parse-console.sh  | 17 ++---------------
 .../rcutorture/configs/lock/ver_functions.sh   | 17 ++---------------
 .../rcutorture/configs/rcu/ver_functions.sh    | 17 ++---------------
 .../configs/rcuperf/ver_functions.sh           | 17 ++---------------
 22 files changed, 47 insertions(+), 314 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/configNR_CPUS.sh b/tools/testing/selftests/rcutorture/bin/configNR_CPUS.sh
index 43540f1828cc..2deea2169fc2 100755
--- a/tools/testing/selftests/rcutorture/bin/configNR_CPUS.sh
+++ b/tools/testing/selftests/rcutorture/bin/configNR_CPUS.sh
@@ -1,4 +1,5 @@
 #!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
 #
 # Extract the number of CPUs expected from the specified Kconfig-file
 # fragment by checking CONFIG_SMP and CONFIG_NR_CPUS.  If the specified
@@ -7,23 +8,9 @@
 #
 # Usage: configNR_CPUS.sh config-frag
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, you can access it online at
-# http://www.gnu.org/licenses/gpl-2.0.html.
-#
 # Copyright (C) IBM Corporation, 2013
 #
-# Authors: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+# Authors: Paul E. McKenney <paulmck@linux.ibm.com>
 
 cf=$1
 if test ! -r $cf
diff --git a/tools/testing/selftests/rcutorture/bin/config_override.sh b/tools/testing/selftests/rcutorture/bin/config_override.sh
index ef7fcbac3d42..90016c359e83 100755
--- a/tools/testing/selftests/rcutorture/bin/config_override.sh
+++ b/tools/testing/selftests/rcutorture/bin/config_override.sh
@@ -1,4 +1,5 @@
 #!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
 #
 # config_override.sh base override
 #
@@ -6,23 +7,9 @@
 # that conflict with any in override, concatenating what remains and
 # sending the result to standard output.
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, you can access it online at
-# http://www.gnu.org/licenses/gpl-2.0.html.
-#
 # Copyright (C) IBM Corporation, 2017
 #
-# Authors: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+# Authors: Paul E. McKenney <paulmck@linux.ibm.com>
 
 base=$1
 if test -r $base
diff --git a/tools/testing/selftests/rcutorture/bin/configcheck.sh b/tools/testing/selftests/rcutorture/bin/configcheck.sh
index 197deece7c7c..5b25524d0366 100755
--- a/tools/testing/selftests/rcutorture/bin/configcheck.sh
+++ b/tools/testing/selftests/rcutorture/bin/configcheck.sh
@@ -1,23 +1,11 @@
 #!/bin/bash
-# Usage: configcheck.sh .config .config-template
-#
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
+# SPDX-License-Identifier: GPL-2.0+
 #
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, you can access it online at
-# http://www.gnu.org/licenses/gpl-2.0.html.
+# Usage: configcheck.sh .config .config-template
 #
 # Copyright (C) IBM Corporation, 2011
 #
-# Authors: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+# Authors: Paul E. McKenney <paulmck@linux.ibm.com>
 
 T=${TMPDIR-/tmp}/abat-chk-config.sh.$$
 trap 'rm -rf $T' 0
diff --git a/tools/testing/selftests/rcutorture/bin/configinit.sh b/tools/testing/selftests/rcutorture/bin/configinit.sh
index 65541c21a544..40359486b3a8 100755
--- a/tools/testing/selftests/rcutorture/bin/configinit.sh
+++ b/tools/testing/selftests/rcutorture/bin/configinit.sh
@@ -1,4 +1,5 @@
 #!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
 #
 # Usage: configinit.sh config-spec-file build-output-dir results-dir
 #
@@ -14,23 +15,9 @@
 # for example, "O=/tmp/foo".  If this argument is omitted, the .config
 # file will be generated directly in the current directory.
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, you can access it online at
-# http://www.gnu.org/licenses/gpl-2.0.html.
-#
 # Copyright (C) IBM Corporation, 2013
 #
-# Authors: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+# Authors: Paul E. McKenney <paulmck@linux.ibm.com>
 
 T=${TMPDIR-/tmp}/configinit.sh.$$
 trap 'rm -rf $T' 0
diff --git a/tools/testing/selftests/rcutorture/bin/cpus2use.sh b/tools/testing/selftests/rcutorture/bin/cpus2use.sh
index bb99cde3f5f9..ff7102212703 100755
--- a/tools/testing/selftests/rcutorture/bin/cpus2use.sh
+++ b/tools/testing/selftests/rcutorture/bin/cpus2use.sh
@@ -1,26 +1,13 @@
 #!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
 #
 # Get an estimate of how CPU-hoggy to be.
 #
 # Usage: cpus2use.sh
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, you can access it online at
-# http://www.gnu.org/licenses/gpl-2.0.html.
-#
 # Copyright (C) IBM Corporation, 2013
 #
-# Authors: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+# Authors: Paul E. McKenney <paulmck@linux.ibm.com>
 
 ncpus=`grep '^processor' /proc/cpuinfo | wc -l`
 idlecpus=`mpstat | tail -1 | \
diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
index 65f6655026f0..6bcb8b5b2ff2 100644
--- a/tools/testing/selftests/rcutorture/bin/functions.sh
+++ b/tools/testing/selftests/rcutorture/bin/functions.sh
@@ -1,24 +1,11 @@
 #!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
 #
 # Shell functions for the rest of the scripts.
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, you can access it online at
-# http://www.gnu.org/licenses/gpl-2.0.html.
-#
 # Copyright (C) IBM Corporation, 2013
 #
-# Authors: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+# Authors: Paul E. McKenney <paulmck@linux.ibm.com>
 
 # bootparam_hotplug_cpu bootparam-string
 #
diff --git a/tools/testing/selftests/rcutorture/bin/jitter.sh b/tools/testing/selftests/rcutorture/bin/jitter.sh
index 3633828375e3..435b60933985 100755
--- a/tools/testing/selftests/rcutorture/bin/jitter.sh
+++ b/tools/testing/selftests/rcutorture/bin/jitter.sh
@@ -1,4 +1,5 @@
 #!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
 #
 # Alternate sleeping and spinning on randomly selected CPUs.  The purpose
 # of this script is to inflict random OS jitter on a concurrently running
@@ -11,23 +12,9 @@
 # sleepmax: Maximum microseconds to sleep, defaults to one second.
 # spinmax: Maximum microseconds to spin, defaults to one millisecond.
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, you can access it online at
-# http://www.gnu.org/licenses/gpl-2.0.html.
-#
 # Copyright (C) IBM Corporation, 2016
 #
-# Authors: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+# Authors: Paul E. McKenney <paulmck@linux.ibm.com>
 
 me=$(($1 * 1000))
 duration=$2
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-build.sh b/tools/testing/selftests/rcutorture/bin/kvm-build.sh
index 9115fcdb5617..c27a0bbb9c02 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-build.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-build.sh
@@ -1,26 +1,13 @@
 #!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
 #
 # Build a kvm-ready Linux kernel from the tree in the current directory.
 #
 # Usage: kvm-build.sh config-template build-dir resdir
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, you can access it online at
-# http://www.gnu.org/licenses/gpl-2.0.html.
-#
 # Copyright (C) IBM Corporation, 2011
 #
-# Authors: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+# Authors: Paul E. McKenney <paulmck@linux.ibm.com>
 
 config_template=${1}
 if test -z "$config_template" -o ! -f "$config_template" -o ! -r "$config_template"
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
index 98f650c9bf54..8426fe1f15ee 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
@@ -1,4 +1,5 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
 #
 # Invoke a text editor on all console.log files for all runs with diagnostics,
 # that is, on all such files having a console.log.diags counterpart.
@@ -10,6 +11,10 @@
 #
 # The "directory" above should end with the date/time directory, for example,
 # "tools/testing/selftests/rcutorture/res/2018.02.25-14:27:27".
+#
+# Copyright (C) IBM Corporation, 2018
+#
+# Author: Paul E. McKenney <paulmck@linux.ibm.com>
 
 rundir="${1}"
 if test -z "$rundir" -o ! -d "$rundir"
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck-lock.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck-lock.sh
index 2de92f43ee8c..f3a7a5e2b89d 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck-lock.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck-lock.sh
@@ -1,26 +1,13 @@
 #!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
 #
 # Analyze a given results directory for locktorture progress.
 #
 # Usage: kvm-recheck-lock.sh resdir
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, you can access it online at
-# http://www.gnu.org/licenses/gpl-2.0.html.
-#
 # Copyright (C) IBM Corporation, 2014
 #
-# Authors: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+# Authors: Paul E. McKenney <paulmck@linux.ibm.com>
 
 i="$1"
 if test -d "$i" -a -r "$i"
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh
index 0fa8a61ccb7b..2a7f3f4756a7 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh
@@ -1,26 +1,13 @@
 #!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
 #
 # Analyze a given results directory for rcutorture progress.
 #
 # Usage: kvm-recheck-rcu.sh resdir
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, you can access it online at
-# http://www.gnu.org/licenses/gpl-2.0.html.
-#
 # Copyright (C) IBM Corporation, 2014
 #
-# Authors: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+# Authors: Paul E. McKenney <paulmck@linux.ibm.com>
 
 i="$1"
 if test -d "$i" -a -r "$i"
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuperf-ftrace.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuperf-ftrace.sh
index 8948f7926b21..7d3c2be66c64 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuperf-ftrace.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuperf-ftrace.sh
@@ -1,4 +1,5 @@
 #!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
 #
 # Analyze a given results directory for rcuperf performance measurements,
 # looking for ftrace data.  Exits with 0 if data was found, analyzed, and
@@ -7,23 +8,9 @@
 #
 # Usage: kvm-recheck-rcuperf-ftrace.sh resdir
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, you can access it online at
-# http://www.gnu.org/licenses/gpl-2.0.html.
-#
 # Copyright (C) IBM Corporation, 2016
 #
-# Authors: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+# Authors: Paul E. McKenney <paulmck@linux.ibm.com>
 
 i="$1"
 . functions.sh
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuperf.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuperf.sh
index ccebf772fa1e..db0375a57f28 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuperf.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuperf.sh
@@ -1,26 +1,13 @@
 #!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
 #
 # Analyze a given results directory for rcuperf performance measurements.
 #
 # Usage: kvm-recheck-rcuperf.sh resdir
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, you can access it online at
-# http://www.gnu.org/licenses/gpl-2.0.html.
-#
 # Copyright (C) IBM Corporation, 2016
 #
-# Authors: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+# Authors: Paul E. McKenney <paulmck@linux.ibm.com>
 
 i="$1"
 if test -d "$i" -a -r "$i"
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
index c9bab57a77eb..2adde6aaafdb 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
@@ -1,4 +1,5 @@
 #!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
 #
 # Given the results directories for previous KVM-based torture runs,
 # check the build and console output for errors.  Given a directory
@@ -6,23 +7,9 @@
 #
 # Usage: kvm-recheck.sh resdir ...
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, you can access it online at
-# http://www.gnu.org/licenses/gpl-2.0.html.
-#
 # Copyright (C) IBM Corporation, 2011
 #
-# Authors: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+# Authors: Paul E. McKenney <paulmck@linux.ibm.com>
 
 PATH=`pwd`/tools/testing/selftests/rcutorture/bin:$PATH; export PATH
 . functions.sh
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index 58ca758a5786..0eb1ec16d78a 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -1,4 +1,5 @@
 #!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
 #
 # Run a kvm-based test of the specified tree on the specified configs.
 # Fully automated run and error checking, no graphics console.
@@ -20,23 +21,9 @@
 #
 # More sophisticated argument parsing is clearly needed.
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, you can access it online at
-# http://www.gnu.org/licenses/gpl-2.0.html.
-#
 # Copyright (C) IBM Corporation, 2011
 #
-# Authors: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+# Authors: Paul E. McKenney <paulmck@linux.ibm.com>
 
 T=${TMPDIR-/tmp}/kvm-test-1-run.sh.$$
 trap 'rm -rf $T' 0
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 19864f1cb27a..8f1e337b9b54 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -1,4 +1,5 @@
 #!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
 #
 # Run a series of tests under KVM.  By default, this series is specified
 # by the relevant CFLIST file, but can be overridden by the --configs
@@ -6,23 +7,9 @@
 #
 # Usage: kvm.sh [ options ]
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, you can access it online at
-# http://www.gnu.org/licenses/gpl-2.0.html.
-#
 # Copyright (C) IBM Corporation, 2011
 #
-# Authors: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+# Authors: Paul E. McKenney <paulmck@linux.ibm.com>
 
 scriptname=$0
 args="$*"
diff --git a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
index 83552bb007b4..6fa9bd1ddc09 100755
--- a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
+++ b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
@@ -1,21 +1,8 @@
 #!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
 #
 # Create an initrd directory if one does not already exist.
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, you can access it online at
-# http://www.gnu.org/licenses/gpl-2.0.html.
-#
 # Copyright (C) IBM Corporation, 2013
 #
 # Author: Connor Shu <Connor.Shu@ibm.com>
diff --git a/tools/testing/selftests/rcutorture/bin/parse-build.sh b/tools/testing/selftests/rcutorture/bin/parse-build.sh
index 24fe5f822b28..0701b3bf6ade 100755
--- a/tools/testing/selftests/rcutorture/bin/parse-build.sh
+++ b/tools/testing/selftests/rcutorture/bin/parse-build.sh
@@ -1,4 +1,5 @@
 #!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
 #
 # Check the build output from an rcutorture run for goodness.
 # The "file" is a pathname on the local system, and "title" is
@@ -8,23 +9,9 @@
 #
 # Usage: parse-build.sh file title
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, you can access it online at
-# http://www.gnu.org/licenses/gpl-2.0.html.
-#
 # Copyright (C) IBM Corporation, 2011
 #
-# Authors: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+# Authors: Paul E. McKenney <paulmck@linux.ibm.com>
 
 F=$1
 title=$2
diff --git a/tools/testing/selftests/rcutorture/bin/parse-console.sh b/tools/testing/selftests/rcutorture/bin/parse-console.sh
index 84933f6aed77..4508373a922f 100755
--- a/tools/testing/selftests/rcutorture/bin/parse-console.sh
+++ b/tools/testing/selftests/rcutorture/bin/parse-console.sh
@@ -1,4 +1,5 @@
 #!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
 #
 # Check the console output from an rcutorture run for oopses.
 # The "file" is a pathname on the local system, and "title" is
@@ -6,23 +7,9 @@
 #
 # Usage: parse-console.sh file title
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, you can access it online at
-# http://www.gnu.org/licenses/gpl-2.0.html.
-#
 # Copyright (C) IBM Corporation, 2011
 #
-# Authors: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+# Authors: Paul E. McKenney <paulmck@linux.ibm.com>
 
 T=${TMPDIR-/tmp}/parse-console.sh.$$
 file="$1"
diff --git a/tools/testing/selftests/rcutorture/configs/lock/ver_functions.sh b/tools/testing/selftests/rcutorture/configs/lock/ver_functions.sh
index 80eb646e1319..d3e4b2971f92 100644
--- a/tools/testing/selftests/rcutorture/configs/lock/ver_functions.sh
+++ b/tools/testing/selftests/rcutorture/configs/lock/ver_functions.sh
@@ -1,24 +1,11 @@
 #!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
 #
 # Kernel-version-dependent shell functions for the rest of the scripts.
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, you can access it online at
-# http://www.gnu.org/licenses/gpl-2.0.html.
-#
 # Copyright (C) IBM Corporation, 2014
 #
-# Authors: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+# Authors: Paul E. McKenney <paulmck@linux.ibm.com>
 
 # locktorture_param_onoff bootparam-string config-file
 #
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/ver_functions.sh b/tools/testing/selftests/rcutorture/configs/rcu/ver_functions.sh
index 7bab8246392b..effa415f9b92 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/ver_functions.sh
+++ b/tools/testing/selftests/rcutorture/configs/rcu/ver_functions.sh
@@ -1,24 +1,11 @@
 #!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
 #
 # Kernel-version-dependent shell functions for the rest of the scripts.
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, you can access it online at
-# http://www.gnu.org/licenses/gpl-2.0.html.
-#
 # Copyright (C) IBM Corporation, 2013
 #
-# Authors: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+# Authors: Paul E. McKenney <paulmck@linux.ibm.com>
 
 # rcutorture_param_n_barrier_cbs bootparam-string
 #
diff --git a/tools/testing/selftests/rcutorture/configs/rcuperf/ver_functions.sh b/tools/testing/selftests/rcutorture/configs/rcuperf/ver_functions.sh
index d36b8fd6f0fc..777d5b0c190f 100644
--- a/tools/testing/selftests/rcutorture/configs/rcuperf/ver_functions.sh
+++ b/tools/testing/selftests/rcutorture/configs/rcuperf/ver_functions.sh
@@ -1,24 +1,11 @@
 #!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
 #
 # Torture-suite-dependent shell functions for the rest of the scripts.
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, you can access it online at
-# http://www.gnu.org/licenses/gpl-2.0.html.
-#
 # Copyright (C) IBM Corporation, 2015
 #
-# Authors: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+# Authors: Paul E. McKenney <paulmck@linux.ibm.com>
 
 # per_version_boot_params bootparam-string config-file seconds
 #
-- 
2.17.1

