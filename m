Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AADDC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05019217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbfDWQiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:38:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36688 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729409AbfDWQiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:38:15 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3NGaSc9019995
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 12:38:14 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s26cj82df-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 12:38:14 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 23 Apr 2019 17:38:13 +0100
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 23 Apr 2019 17:38:10 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3NGc9iv35979346
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Apr 2019 16:38:09 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B88DEB2068;
        Tue, 23 Apr 2019 16:38:09 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B33CB2066;
        Tue, 23 Apr 2019 16:38:09 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.109])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 23 Apr 2019 16:38:09 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 4BE7516C0E9F; Tue, 23 Apr 2019 09:38:09 -0700 (PDT)
Date:   Tue, 23 Apr 2019 09:38:09 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [rcu:dev.2019.04.16a 38/72] kernel/rcu/tree.c:2408:36: sparse:
 sparse: incorrect type in initializer (different address spaces)
Reply-To: paulmck@linux.ibm.com
References: <201904231828.a3jAyl28%lkp@intel.com>
 <20190423124619.GH3923@linux.ibm.com>
 <20190423150814.4lhcavywthyiwipd@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190423150814.4lhcavywthyiwipd@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19042316-0072-0000-0000-0000041D92F2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010981; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01193297; UDB=6.00625541; IPR=6.00974117;
 MB=3.00026560; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-23 16:38:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042316-0073-0000-0000-00004BEE253A
Message-Id: <20190423163809.GQ3923@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-23_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904230113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 05:08:14PM +0200, Sebastian Andrzej Siewior wrote:
> On 2019-04-23 05:46:19 [-0700], Paul E. McKenney wrote:
> > On Tue, Apr 23, 2019 at 06:33:33PM +0800, kbuild test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2019.04.16a
> > > head:   ca8714f549be5a186d086a223184095759eb7094
> > > commit: 9a1a31194644dfc6b8f19755ea44ecf84f37cf40 [38/72] rcu: Enable elimination of Tree-RCU softirq processing
> > > reproduce:
> > >         # apt-get install sparse
> > >         git checkout 9a1a31194644dfc6b8f19755ea44ecf84f37cf40
> > >         make ARCH=x86_64 allmodconfig
> > >         make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
> > > 
> > > If you fix the issue, kindly add following tag
> > > Reported-by: kbuild test robot <lkp@intel.com>
> > > 
> > > 
> > > 
> > > sparse warnings: (new ones prefixed by >>)
> > > 
> > > >> kernel/rcu/tree.c:2408:36: sparse: sparse: incorrect type in initializer (different address spaces) @@    expected struct task_struct [noderef] <asn:3> **store @@    got struct task_struct [noderef] <asn:3> **store @@
> > 
> > Line 2408 of kernel/rcu/tree.c for commit 9a1a31194644 ("rcu: Enable
> > elimination of Tree-RCU softirq processing") is this:
> > 
> > 	.store			= &rcu_data.rcu_cpu_kthread_task,
> > 
> > So I am having some difficulty understanding this sparse diagnostic.
> > 
> > Help?
> 
> this helps
> 
> diff --git a/include/linux/smpboot.h b/include/linux/smpboot.h
> index d0884b5250010..c2678e29807c1 100644
> --- a/include/linux/smpboot.h
> +++ b/include/linux/smpboot.h
> @@ -29,7 +29,7 @@ struct smpboot_thread_data;
>   * @thread_comm:	The base name of the thread
>   */
>  struct smp_hotplug_thread {
> -	struct task_struct __percpu	**store;
> +	struct task_struct		*__percpu *store;
>  	struct list_head		list;
>  	int				(*thread_should_run)(unsigned int cpu);
>  	void				(*thread_fn)(unsigned int cpu);
> 
> 
> I just need to find the correct words for it.
> And yes, it is not RCU related…

Ah, thank you!  Shall I fold the above patch into your existing one,
or are you looking to do something else here?

							Thanx, Paul

