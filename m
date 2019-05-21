Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8561CC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 13:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6441A208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 13:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbfEUNhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 09:37:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41098 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727969AbfEUNhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 09:37:46 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4LDbe0M047783
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 09:37:45 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2smhua9mrq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 09:37:44 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <brueckner@linux.ibm.com>;
        Tue, 21 May 2019 14:36:43 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 21 May 2019 14:36:39 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4LDacpc63176788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 13:36:38 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E54FA405B;
        Tue, 21 May 2019 13:36:38 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C9D7A4057;
        Tue, 21 May 2019 13:36:38 +0000 (GMT)
Received: from lynx.boeblingen.de.ibm.com (unknown [9.152.224.87])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 21 May 2019 13:36:38 +0000 (GMT)
Received: from brueckh by lynx.boeblingen.de.ibm.com with local (Exim 4.90_1)
        (envelope-from <brueckner@linux.ibm.com>)
        id 1hT4wY-0007j1-2b; Tue, 21 May 2019 15:36:38 +0200
Date:   Tue, 21 May 2019 15:36:38 +0200
From:   Hendrik Brueckner <brueckner@linux.ibm.com>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, brueckner@linux.vnet.ibm.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Subject: Re: [PATCH] pert/report: Support s390 diag event display on x86
References: <20190520144242.53207-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520144242.53207-1-tmricht@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19052113-4275-0000-0000-0000033714DA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052113-4276-0000-0000-00003846A9BC
Message-Id: <20190521133638.GB10877@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-21_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905210087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 04:42:42PM +0200, Thomas Richter wrote:
> Perf report fails to display s390 specific event numbered bd000
> on an x86 platform. For example on s390 this works without error:
> 
> [root@m35lp76 perf]# uname -m
> s390x
> [root@m35lp76 perf]# ./perf record -e rbd000 -- find / >/dev/null
> [ perf record: Woken up 3 times to write data ]
> [ perf record: Captured and wrote 0.549 MB perf.data ]
> [root@m35lp76 perf]# ./perf report -D --stdio  > /dev/null
> [root@m35lp76 perf]#
> 
> Transfering this perf.data file to an x86 platform and executing
> the same report command produces:
> 
> [root@f29 perf]# uname -m
> x86_64
> [root@f29 perf]# ./perf report -i ~/perf.data.m35lp76 --stdio
> interpreting bpf_prog_info from systems with endianity is not yet supported
> interpreting btf from systems with endianity is not yet supported
> 0x8c890 [0x8]: failed to process type: 68
> Error:
> failed to process sample
> 
> Event bd000 generates auxiliary data which is stored in big endian
> format in the perf data file.
> This error is caused by missing endianess handling on the x86 platform
> when the data is displayed. Fix this by handling s390 auxiliary event
> data depending on the local platform endianness.
> 
> Output after on x86:
> 
> [root@f29 perf]# ./perf report -D -i ~/perf.data.m35lp76 --stdio > /dev/null
> interpreting bpf_prog_info from systems with endianity is not yet supported
> interpreting btf from systems with endianity is not yet supported
> [root@f29 perf]#
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/util/s390-cpumsf.c | 95 ++++++++++++++++++++++++++++-------
>  1 file changed, 77 insertions(+), 18 deletions(-)
> 

Looks sane to me.

Thanks, Thomas.

Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>

