Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA57BC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8022B206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388914AbfHAT6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 15:58:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54288 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388600AbfHAT6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 15:58:35 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71JuNOx037893;
        Thu, 1 Aug 2019 15:58:33 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u44dy58gx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 15:58:33 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x71JtCJu013198;
        Thu, 1 Aug 2019 19:58:32 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma02wdc.us.ibm.com with ESMTP id 2u0e85vwxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 19:58:32 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71JwVOC8716762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 19:58:31 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8BA5B2064;
        Thu,  1 Aug 2019 19:58:31 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A013B205F;
        Thu,  1 Aug 2019 19:58:31 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 19:58:31 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A449816C9A15; Thu,  1 Aug 2019 12:58:32 -0700 (PDT)
Date:   Thu, 1 Aug 2019 12:58:32 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH 0/9] Apply new rest conversion patches to /dev branch
Message-ID: <20190801195832.GP5913@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190801181411.96429-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801181411.96429-1-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010209
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 02:14:02PM -0400, Joel Fernandes (Google) wrote:
> This series fixes the rcu/dev branch so it can apply the new ReST conversion patches.
> 
> Patches based on "00ec8f46465e  rcu/nohz: Make multi_cpu_stop() enable tick on
> all online CPUs"
> 
> The easiest was to do this is to revert the patches that conflict and then
> applying the doc patches, and then applying them again. But in the
> re-application, we convert the documentation
> 
> No manual fix ups were done in this process, other than to documentation.

Ah, I was expecting that you would forward-port the conversion, but
yes, that could be painful and error prone.

But given that there are some dependencies on these patches, could you
please use the following alternative procedure for the patches that
touch both code and documentation?

o	Revert only the documentation portion of each commit.  I will
	then merge the partial reverts with the original commits.

o	Apply the documentation conversion.

o	Reapply the documentation portions on top of the conversion.

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> And in the process I learnt about get_user() and compiler barriers ;-)
> 
> Joel Fernandes (Google) (8):
> Revert "rcu: Restore barrier() to rcu_read_lock() and
> rcu_read_unlock()"
> Revert "rcu: Add support for consolidated-RCU reader checking"
> Revert "treewide: Rename rcu_dereference_raw_notrace() to _check()"
> docs: rcu: Correct links referring to titles
> docs: rcu: Increase toctree to 3
> Revert "Revert "treewide: Rename rcu_dereference_raw_notrace() to
> _check()""
> Revert "Revert "rcu: Add support for consolidated-RCU reader
> checking""
> Revert "Revert "rcu: Restore barrier() to rcu_read_lock() and
> rcu_read_unlock()""
> 
> Mauro Carvalho Chehab (1):
> docs: rcu: convert some articles from html to ReST
> 
> .../Data-Structures/Data-Structures.html      | 1391 -------
> .../Data-Structures/Data-Structures.rst       | 1163 ++++++
> .../Expedited-Grace-Periods.html              |  668 ----
> .../Expedited-Grace-Periods.rst               |  521 +++
> .../Memory-Ordering/Tree-RCU-Diagram.html     |    9 -
> .../Tree-RCU-Memory-Ordering.html             |  704 ----
> .../Tree-RCU-Memory-Ordering.rst              |  624 +++
> .../RCU/Design/Requirements/Requirements.html | 3401 -----------------
> .../RCU/Design/Requirements/Requirements.rst  | 2704 +++++++++++++
> Documentation/RCU/index.rst                   |    7 +-
> Documentation/RCU/whatisRCU.txt               |    4 +-
> 11 files changed, 5020 insertions(+), 6176 deletions(-)
> delete mode 100644 Documentation/RCU/Design/Data-Structures/Data-Structures.html
> create mode 100644 Documentation/RCU/Design/Data-Structures/Data-Structures.rst
> delete mode 100644 Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.html
> create mode 100644 Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst
> delete mode 100644 Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Diagram.html
> delete mode 100644 Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html
> create mode 100644 Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
> delete mode 100644 Documentation/RCU/Design/Requirements/Requirements.html
> create mode 100644 Documentation/RCU/Design/Requirements/Requirements.rst
> 
> --
> 2.22.0.770.g0f2c4a37fd-goog
> 
