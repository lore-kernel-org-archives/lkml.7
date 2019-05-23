Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C940FC04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 05:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A492321019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 05:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbfEWFpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 01:45:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58706 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725806AbfEWFpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 01:45:45 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4N5cmoW018594
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 01:45:43 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2snhjcywaw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 01:45:43 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 23 May 2019 06:45:41 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 23 May 2019 06:45:37 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4N5jaJJ45351160
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 May 2019 05:45:36 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B149911C052;
        Thu, 23 May 2019 05:45:36 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FAD311C05B;
        Thu, 23 May 2019 05:45:36 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.112])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 23 May 2019 05:45:35 +0000 (GMT)
Date:   Thu, 23 May 2019 08:45:34 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Markus Heiser <markus.heiser@darmarit.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH 3/8] docs: fix numaperf.rst and add it to the doc tree
References: <20190522205034.25724-1-corbet@lwn.net>
 <20190522205034.25724-4-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522205034.25724-4-corbet@lwn.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19052305-0012-0000-0000-0000031E8977
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052305-0013-0000-0000-0000215740D9
Message-Id: <20190523054534.GB23850@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-23_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905230040
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 02:50:29PM -0600, Jonathan Corbet wrote:
> Commit 13bac55ef7ae ("doc/mm: New documentation for memory performance")
> added numaperf.rst, but did not add it to the TOC tree.  There was also an
> incorrectly marked literal block leading to this warning sequence:
> 
>   numaperf.rst:24: WARNING: Unexpected indentation.
>   numaperf.rst:24: WARNING: Inline substitution_reference start-string without end-string.
>   numaperf.rst:25: WARNING: Block quote ends without a blank line; unexpected unindent.
> 
> Fix the block and add the file to the document tree.
> 
> Fixes: 13bac55ef7ae ("doc/mm: New documentation for memory performance")
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  Documentation/admin-guide/mm/index.rst    | 1 +
>  Documentation/admin-guide/mm/numaperf.rst | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/mm/index.rst b/Documentation/admin-guide/mm/index.rst
> index 8edb35f11317..ddf8d8d33377 100644
> --- a/Documentation/admin-guide/mm/index.rst
> +++ b/Documentation/admin-guide/mm/index.rst
> @@ -31,6 +31,7 @@ the Linux memory management.
>     ksm
>     memory-hotplug
>     numa_memory_policy
> +   numaperf
>     pagemap
>     soft-dirty
>     transhuge
> diff --git a/Documentation/admin-guide/mm/numaperf.rst b/Documentation/admin-guide/mm/numaperf.rst
> index b79f70c04397..c067ed145158 100644
> --- a/Documentation/admin-guide/mm/numaperf.rst
> +++ b/Documentation/admin-guide/mm/numaperf.rst
> @@ -15,7 +15,7 @@ characteristics.  Some memory may share the same node as a CPU, and others
>  are provided as memory only nodes. While memory only nodes do not provide
>  CPUs, they may still be local to one or more compute nodes relative to
>  other nodes. The following diagram shows one such example of two compute
> -nodes with local memory and a memory only node for each of compute node:
> +nodes with local memory and a memory only node for each of compute node::
>  
>   +------------------+     +------------------+
>   | Compute Node 0   +-----+ Compute Node 1   |
> -- 
> 2.21.0
> 

-- 
Sincerely yours,
Mike.

