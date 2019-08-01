Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45F9C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 20:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D0652084C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 20:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388851AbfHAUOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 16:14:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59774 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726667AbfHAUOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 16:14:40 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71KCSxH072518;
        Thu, 1 Aug 2019 16:14:38 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u448nx01q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 16:14:38 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x71K5EKT015700;
        Thu, 1 Aug 2019 20:14:37 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma04wdc.us.ibm.com with ESMTP id 2u0e85vxkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 20:14:37 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71KEYP99700048
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 20:14:34 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5AEABB205F;
        Thu,  1 Aug 2019 20:14:34 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3EB68B2065;
        Thu,  1 Aug 2019 20:14:34 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 20:14:34 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6EE4A16C5D7D; Thu,  1 Aug 2019 13:14:35 -0700 (PDT)
Date:   Thu, 1 Aug 2019 13:14:35 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 0/9] Apply new rest conversion patches to /dev branch
Message-ID: <20190801201435.GQ5913@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190801181411.96429-1-joel@joelfernandes.org>
 <20190801195832.GP5913@linux.ibm.com>
 <CAEXW_YQ-JnuZGj7zUtmvY0Cn4swoHXoR6UD=iPKw56N55CL3-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YQ-JnuZGj7zUtmvY0Cn4swoHXoR6UD=iPKw56N55CL3-Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010212
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 04:04:15PM -0400, Joel Fernandes wrote:
> On Thu, Aug 1, 2019 at 3:58 PM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
> >
> > On Thu, Aug 01, 2019 at 02:14:02PM -0400, Joel Fernandes (Google) wrote:
> > > This series fixes the rcu/dev branch so it can apply the new ReST conversion patches.
> > >
> > > Patches based on "00ec8f46465e  rcu/nohz: Make multi_cpu_stop() enable tick on
> > > all online CPUs"
> > >
> > > The easiest was to do this is to revert the patches that conflict and then
> > > applying the doc patches, and then applying them again. But in the
> > > re-application, we convert the documentation
> > >
> > > No manual fix ups were done in this process, other than to documentation.
> >
> > Ah, I was expecting that you would forward-port the conversion, but
> > yes, that could be painful and error prone.
> >
> > But given that there are some dependencies on these patches, could you
> > please use the following alternative procedure for the patches that
> > touch both code and documentation?
> >
> > o       Revert only the documentation portion of each commit.  I will
> >         then merge the partial reverts with the original commits.
> >
> > o       Apply the documentation conversion.
> >
> > o       Reapply the documentation portions on top of the conversion.
> 
> Sure, this would be better. I will do this in the evening and send it
> to you. Thanks,

Very good, looking forward to seeing it!

The smoke tests of the rebase onto v5.3-rc2 passed, so on to create
the usual branches.  Yes, this will complicate merging of the partial
reverts, but there will be the need to apply review comments and the
like anyway, so not really a net increase in complexity.  ;-)

							Thanx, Paul
