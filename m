Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B44C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 22:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D450216C4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 22:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfEIWTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 18:19:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46248 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726824AbfEIWTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 18:19:02 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x49MGXNh071428
        for <linux-kernel@vger.kernel.org>; Thu, 9 May 2019 18:19:01 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2scsufxpa4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 18:19:01 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 9 May 2019 23:19:00 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 9 May 2019 23:18:58 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x49MIvk928508228
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 May 2019 22:18:57 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53C80B2068;
        Thu,  9 May 2019 22:18:57 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3813AB2065;
        Thu,  9 May 2019 22:18:57 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  9 May 2019 22:18:57 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9DE2A16C5DD8; Thu,  9 May 2019 15:18:57 -0700 (PDT)
Date:   Thu, 9 May 2019 15:18:57 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:peterz.2019.05.09a 2/5] ERROR: "tracing_stop"
 [kernel/rcu/rcutorture.ko] undefined!
Reply-To: paulmck@linux.ibm.com
References: <201905100531.n2nODfWZ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201905100531.n2nODfWZ%lkp@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19050922-0072-0000-0000-0000042A1ABD
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011079; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01201013; UDB=6.00630212; IPR=6.00981904;
 MB=3.00026819; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-09 22:18:59
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050922-0073-0000-0000-00004C28E167
Message-Id: <20190509221857.GN3923@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-09_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905090127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 05:47:32AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git peterz.2019.05.09a
> head:   9aaf2ab4ea3d421a1efa413020bbd5c30ecb5f86
> commit: 88437e0ce11d4b74d9606e2c587cdebbdfb41cf3 [2/5] EXP rcutorture: Test setup for sched_setaffinity()
> config: x86_64-lkp (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         git checkout 88437e0ce11d4b74d9606e2c587cdebbdfb41cf3
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> ERROR: "tracing_stop" [kernel/rcu/rcutorture.ko] undefined!

Apologies, this is an experimental commit not intended for mainline.
So it only works when rcutorture is built in.

							Thanx, Paul

