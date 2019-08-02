Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5BEC0650F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 23:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B5642087C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 23:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437334AbfHBXF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 19:05:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11384 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730376AbfHBXF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 19:05:56 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x72Mv54r114259;
        Fri, 2 Aug 2019 19:05:24 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u4t301a6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Aug 2019 19:05:24 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x72Mvj1W115173;
        Fri, 2 Aug 2019 19:05:24 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u4t301a64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Aug 2019 19:05:24 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x72MtMOL016711;
        Fri, 2 Aug 2019 23:05:22 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03wdc.us.ibm.com with ESMTP id 2u0e85x46n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Aug 2019 23:05:22 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x72N5Mgh48890274
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Aug 2019 23:05:22 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40D77B2065;
        Fri,  2 Aug 2019 23:05:22 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 236B9B205F;
        Fri,  2 Aug 2019 23:05:22 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  2 Aug 2019 23:05:22 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 226FD16C9A3A; Fri,  2 Aug 2019 16:05:24 -0700 (PDT)
Date:   Fri, 2 Aug 2019 16:05:24 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Ethan Hansen <1ethanhansen@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 1/1] rcu: Remove unused function
 hlist_bl_del_init_rcu
Message-ID: <20190802230524.GT28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <1564778278-21186-1-git-send-email-1ethanhansen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564778278-21186-1-git-send-email-1ethanhansen@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-02_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908020239
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 01:37:58PM -0700, Ethan Hansen wrote:
> The function hlist_bl_del_init_rcu is declared in rculist_bl.h,
> but never used. Remove hlist_bl_del_init_rcu to clean code.
> 
> Signed-off-by: Ethan Hansen <1ethanhansen@gmail.com>

Queued, thank you!

							Thanx, Paul

> ---
>  include/linux/rculist_bl.h | 28 ----------------------------
>  1 file changed, 28 deletions(-)
> 
> diff --git a/include/linux/rculist_bl.h b/include/linux/rculist_bl.h
> index 66e73ec..0b952d0 100644
> --- a/include/linux/rculist_bl.h
> +++ b/include/linux/rculist_bl.h
> @@ -25,34 +25,6 @@ static inline struct hlist_bl_node *hlist_bl_first_rcu(struct hlist_bl_head *h)
>  }
>  
>  /**
> - * hlist_bl_del_init_rcu - deletes entry from hash list with re-initialization
> - * @n: the element to delete from the hash list.
> - *
> - * Note: hlist_bl_unhashed() on the node returns true after this. It is
> - * useful for RCU based read lockfree traversal if the writer side
> - * must know if the list entry is still hashed or already unhashed.
> - *
> - * In particular, it means that we can not poison the forward pointers
> - * that may still be used for walking the hash list and we can only
> - * zero the pprev pointer so list_unhashed() will return true after
> - * this.
> - *
> - * The caller must take whatever precautions are necessary (such as
> - * holding appropriate locks) to avoid racing with another
> - * list-mutation primitive, such as hlist_bl_add_head_rcu() or
> - * hlist_bl_del_rcu(), running on this same list.  However, it is
> - * perfectly legal to run concurrently with the _rcu list-traversal
> - * primitives, such as hlist_bl_for_each_entry_rcu().
> - */
> -static inline void hlist_bl_del_init_rcu(struct hlist_bl_node *n)
> -{
> -	if (!hlist_bl_unhashed(n)) {
> -		__hlist_bl_del(n);
> -		n->pprev = NULL;
> -	}
> -}
> -
> -/**
>   * hlist_bl_del_rcu - deletes entry from hash list without re-initialization
>   * @n: the element to delete from the hash list.
>   *
> -- 
> 1.8.3.1
> 
