Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78125C76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 14:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 514F921743
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 14:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfGQOXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 10:23:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26186 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726452AbfGQOXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 10:23:35 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6HEHxZ6025887
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 10:23:34 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tt3bdpm9w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 10:23:33 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <jremus@linux.ibm.com>;
        Wed, 17 Jul 2019 15:23:31 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 17 Jul 2019 15:23:27 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6HENQCl49938456
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 14:23:26 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 125BB11C075;
        Wed, 17 Jul 2019 14:23:26 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B35A211C070;
        Wed, 17 Jul 2019 14:23:25 +0000 (GMT)
Received: from [9.152.97.218] (unknown [9.152.97.218])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 17 Jul 2019 14:23:25 +0000 (GMT)
From:   Jens Remus <jremus@linux.ibm.com>
Subject: WARNING in con_is_bound
To:     Daniel Vetter <daniel.vetter@intel.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-s390@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Martin Hostettler <textshell@uchuujin.de>,
        Adam Borowski <kilobyte@angband.pl>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Mikulas Patocka <mpatocka@redhat.com>
Organization: IBM Deutschland Research & Development GmbH
Date:   Wed, 17 Jul 2019 16:23:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19071714-4275-0000-0000-0000034E26D2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071714-4276-0000-0000-0000385E3D1A
Message-Id: <84012ee0-e1e3-2eef-b927-b865fd141f78@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-17_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=799 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907170170
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Our CI on s390x constantly triggers the following warning in function con_is_bound() when reading the SysFS attribute /sys/class/vtconsole/vtcon0/bind.
I verified this to be the case since WARN_CONSOLE_UNLOCKED() was introduced in function con_is_bound() with commit ddde3c18b700 ("vt: More locking checks"), which has recently been merged into Linus' master branch.


From CI with recent Linus' master branch built with arch/s390/configs/defconfig. dump2tar is a utility we use to collect the whole SysFS as tar archive for problem determination.

WARNING: CPU: 7 PID: 47758 at drivers/tty/vt/vt.c:3825 con_is_bound+0x8e/0x98
Kernel panic - not syncing: panic_on_warn set ...
CPU: 7 PID: 47758 Comm: dump2tar Tainted: G           OE     5.3.0-20190715.rc0.git0.1d039859330b.301.fc30.s390x+git #1
Hardware name: IBM ... (z/VM 7.1.0)
Call Trace:
([<00000000291b7b46>] show_stack+0x8e/0xd0)
 [<0000000029b82242>] dump_stack+0x7a/0xa8
 [<00000000291e9aea>] panic+0x112/0x308
 [<00000000291e991a>] __warn+0xc2/0x118
 [<0000000029b81312>] report_bug+0xfa/0x158
 [<00000000291a534c>] do_report_trap+0xc4/0xe0
 [<00000000291a5522>] illegal_op+0x13a/0x150
 [<0000000029ba2a1c>] pgm_check_handler+0x1c8/0x220
 [<0000000029877626>] con_is_bound+0x8e/0x98
([<000000008fed2820>] 0x8fed2820)
 [<0000000029878502>] show_bind+0x32/0x58
 [<00000000298f46f4>] dev_attr_show+0x2c/0x70
 [<00000000294d57ac>] sysfs_kf_seq_show+0xac/0x158
 [<00000000294565a0>] seq_read+0xe0/0x478
 [<000000002942774c>] vfs_read+0x94/0x150
 [<0000000029427b10>] ksys_read+0x68/0xf8
 [<0000000029ba2624>] system_call+0xd8/0x2c8


From verification with Kernel based on commit ddde3c18b700 ("vt: More locking checks") built with arch/s390/configs/performance_defconfig. I used cat /sys/class/vtconsole/vtcon0/bind to trigger the warning.

WARNING: CPU: 0 PID: 923 at drivers/tty/vt/vt.c:3825 con_is_bound+0x8e/0x98
Modules linked in: ...
CPU: 0 PID: 923 Comm: cat Not tainted 5.2.0-rc4-00004-gddde3c18b700 #2
Hardware name: IBM 3906 M03 703 (z/VM 7.1.0)
Krnl PSW : 0704c00180000000 0000000041418856 (con_is_bound+0x8e/0x98)
           R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
Krnl GPRS: 000000003d6a4000 0000000000000000 0000000000000000 0000000041b3cd88
           000000007aba3000 0000000041493378 000000007b52b428 0000000000000000
           000003e000abfef8 0000000078dc6540 0000000041bbe310 0000000041bbbf10
           000000007ac4a000 000000007b52b440 0000000041418842 000003e000abfca8
Krnl Code: 000000004141884c: 1612                or      %r1,%r2
           000000004141884e: a774ffd5            brc     7,414187f8
          #0000000041418852: a7f40001            brc     15,41418854
          >0000000041418856: a7f4ffd1            brc     15,414187f8
           000000004141885a: 0707                bcr     0,%r7
           000000004141885c: 0707                bcr     0,%r7
           000000004141885e: 0707                bcr     0,%r7
           0000000041418860: c00400000000        brcl    0,41418860
Call Trace:
([<000003e000abfca0>] 0x3e000abfca0)
 [<0000000041419732>] show_bind+0x32/0x58
 [<00000000414933a8>] dev_attr_show+0x30/0x70
 [<00000000410798e8>] sysfs_kf_seq_show+0xb0/0x158
 [<0000000040ffa95c>] seq_read+0xe4/0x478
 [<0000000040fcbe84>] vfs_read+0x94/0x150
 [<0000000040fcc248>] ksys_read+0x68/0xf8
 [<0000000041733530>] system_call+0xdc/0x2c8
Last Breaking-Event-Address:
 [<0000000041418852>] con_is_bound+0x8a/0x98
---[ end trace 80e05e05ec2ee660 ]---


Thanks and regards,
Jens Remus
-- 
Linux on Z and z/VSE Development & Service (D3229)
IBM Systems & Technology Group, Pure Systems & Modular Software Development

IBM Data Privacy Statement: https://www.ibm.com/privacy/us/en/

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294

