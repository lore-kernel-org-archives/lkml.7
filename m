Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E98FC04AAB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 00:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF7A620835
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 00:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfEGAFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 20:05:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44430 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726400AbfEGAE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 20:04:59 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4702GYK005105
        for <linux-kernel@vger.kernel.org>; Mon, 6 May 2019 20:04:58 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2saujq7nts-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 20:04:58 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 7 May 2019 01:04:57 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 7 May 2019 01:04:53 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4704qw327984092
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 May 2019 00:04:52 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DB21B2072;
        Tue,  7 May 2019 00:04:52 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19F2FB205F;
        Tue,  7 May 2019 00:04:52 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  7 May 2019 00:04:52 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 89AFB16C5DD3; Mon,  6 May 2019 17:04:53 -0700 (PDT)
Date:   Mon, 6 May 2019 17:04:53 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] doc/rcu: Correct field_count field naming in examples
Reply-To: paulmck@linux.ibm.com
References: <20190505020328.165839-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190505020328.165839-1-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19050700-0072-0000-0000-000004289D4B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011062; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01199625; UDB=6.00629371; IPR=6.00980501;
 MB=3.00026763; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-07 00:04:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050700-0073-0000-0000-00004C1EC4B0
Message-Id: <20190507000453.GB3923@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-06_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905060181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 04, 2019 at 10:03:10PM -0400, Joel Fernandes (Google) wrote:
> I believe this field should be called field_count instead of file_count.
> Correct the doc with the same.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

But if we are going to update this, why not update it with the current
audit_filter_task(), audit_del_rule(), and audit_add_rule() code?

Hmmm...  One reason is that some of them have changed beyond recognition.

And this example code predates v2.6.12.  ;-)

So good eyes, but I believe that this really does reflect the ancient
code...

On the other hand, would you have ideas for more modern replacement
examples?

							Thanx, Paul

> ---
>  Documentation/RCU/listRCU.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/RCU/listRCU.txt b/Documentation/RCU/listRCU.txt
> index adb5a3782846..190e666fc359 100644
> --- a/Documentation/RCU/listRCU.txt
> +++ b/Documentation/RCU/listRCU.txt
> @@ -175,7 +175,7 @@ otherwise, the added fields would need to be filled in):
>  		list_for_each_entry(e, list, list) {
>  			if (!audit_compare_rule(rule, &e->rule)) {
>  				e->rule.action = newaction;
> -				e->rule.file_count = newfield_count;
> +				e->rule.field_count = newfield_count;
>  				write_unlock(&auditsc_lock);
>  				return 0;
>  			}
> @@ -204,7 +204,7 @@ RCU ("read-copy update") its name.  The RCU code is as follows:
>  					return -ENOMEM;
>  				audit_copy_rule(&ne->rule, &e->rule);
>  				ne->rule.action = newaction;
> -				ne->rule.file_count = newfield_count;
> +				ne->rule.field_count = newfield_count;
>  				list_replace_rcu(&e->list, &ne->list);
>  				call_rcu(&e->rcu, audit_free_rule);
>  				return 0;
> -- 
> 2.21.0.1020.gf2820cf01a-goog
> 

