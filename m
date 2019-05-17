Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2B3C04E84
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 11:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE47720848
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 11:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbfEQL5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 07:57:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59186 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727927AbfEQL5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 07:57:42 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4HBsvJ0005582
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 07:57:41 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2shssn7fer-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 07:57:41 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 17 May 2019 12:57:39 +0100
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 17 May 2019 12:57:35 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4HBvYZo37159404
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 May 2019 11:57:35 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6D2FB2066;
        Fri, 17 May 2019 11:57:34 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5A3EB2064;
        Fri, 17 May 2019 11:57:34 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.212.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 17 May 2019 11:57:34 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E637216C168F; Fri, 17 May 2019 04:57:34 -0700 (PDT)
Date:   Fri, 17 May 2019 04:57:34 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Philippe Mazenauer <philippe.mazenauer@outlook.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rcu: Remove unused variable
Reply-To: paulmck@linux.ibm.com
References: <AM0PR07MB4417DD6F49126041FFC18864FD0B0@AM0PR07MB4417.eurprd07.prod.outlook.com>
 <20190517105111.GW4319@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190517105111.GW4319@dell>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19051711-0052-0000-0000-000003C09A5F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011111; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01204598; UDB=6.00632385; IPR=6.00985533;
 MB=3.00026931; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-17 11:57:38
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051711-0053-0000-0000-000060EE1E39
Message-Id: <20190517115734.GJ28207@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-17_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=897 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905170078
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 11:51:11AM +0100, Lee Jones wrote:
> On Fri, 17 May 2019, Philippe Mazenauer wrote:
> 
> > Variable 'rdp' is set but not used in synchronize_rcu_expidited(). The
> > macro per_cpu_ptr() used to set the value of 'rdp' has no side effect.
> > 
> > ../kernel/rcu/tree_exp.h:768:19: warning: variable ‘rdp’ set but not used [-Wunused-but-set-variable]
> >    struct rcu_data *rdp;
> >                     ^~~
> > 
> > Signed-off-by: Philippe Mazenauer <philippe.mazenauer@outlook.de>
> > ---
> >  kernel/rcu/tree_exp.h | 2 --
> >  1 file changed, 2 deletions(-)
> 
> Looks reasonable:
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>

Good eyes!

However, Jiang Biao beat you to it.  Please see commmit a18e1552af94
("rcu: Remove unused rdp local from synchronize_rcu_expedited()") in -rcu:
git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git branch
"dev".

							Thanx, Paul

