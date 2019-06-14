Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C22C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D39B420850
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbfFNMcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 08:32:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45494 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727544AbfFNMcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 08:32:18 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5ECVgGK022932
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 08:32:16 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t49bxds3h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 08:32:16 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Fri, 14 Jun 2019 13:32:14 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 14 Jun 2019 13:32:13 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5ECWCY448890010
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jun 2019 12:32:12 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C47E42041;
        Fri, 14 Jun 2019 12:32:12 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E20E94204D;
        Fri, 14 Jun 2019 12:32:10 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri, 14 Jun 2019 12:32:10 +0000 (GMT)
Date:   Fri, 14 Jun 2019 18:02:10 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Eiichi Tsukata <devel@etsukata.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] tracing/uprobe: Fix obsolete comment on
 trace_uprobe_create()
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20190614074026.8045-1-devel@etsukata.com>
 <20190614074026.8045-2-devel@etsukata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190614074026.8045-2-devel@etsukata.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 19061412-0028-0000-0000-0000037A4B9F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061412-0029-0000-0000-0000243A4869
Message-Id: <20190614123210.GB16523@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906140105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Eiichi Tsukata <devel@etsukata.com> [2019-06-14 16:40:26]:

> Commit 0597c49c69d5 ("tracing/uprobes: Use dyn_event framework for
> uprobe events") cleaned up the usage of trace_uprobe_create(), and the
> function has been no longer used for removing uprobe/uretprobe.
> 

Agree

Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

> Signed-off-by: Eiichi Tsukata <devel@etsukata.com>
> ---
>  kernel/trace/trace_uprobe.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index 7dc8ee55cf84..7860e3f59fad 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -426,8 +426,6 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
>  /*
>   * Argument syntax:
>   *  - Add uprobe: p|r[:[GRP/]EVENT] PATH:OFFSET [FETCHARGS]
> - *
> - *  - Remove uprobe: -:[GRP/]EVENT
>   */
>  static int trace_uprobe_create(int argc, const char **argv)
>  {
> -- 
> 2.21.0
> 

-- 
Thanks and Regards
Srikar Dronamraju

