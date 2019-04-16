Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461ECC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 05:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134032073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 05:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfDPFWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 01:22:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44214 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726016AbfDPFWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 01:22:10 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3G5JOe3091142
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 01:22:09 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rw870h9wy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 01:22:09 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 16 Apr 2019 06:22:07 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 16 Apr 2019 06:22:02 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3G5M1if48234636
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Apr 2019 05:22:01 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD35A11C058;
        Tue, 16 Apr 2019 05:22:01 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C3F011C052;
        Tue, 16 Apr 2019 05:22:01 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.112])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 16 Apr 2019 05:22:01 +0000 (GMT)
Date:   Tue, 16 Apr 2019 08:21:59 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 46/57] docs: cma/debugfs.txt: convert to ReST and move to
 admin-guide/mm
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
 <fad74a378f3e988c9519a784bed2a5b4aa471482.1555382110.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fad74a378f3e988c9519a784bed2a5b4aa471482.1555382110.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19041605-4275-0000-0000-0000032842CD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041605-4276-0000-0000-00003837720E
Message-Id: <20190416052159.GB27735@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-16_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904160039
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

On Mon, Apr 15, 2019 at 11:56:11PM -0300, Mauro Carvalho Chehab wrote:
> The debugfs interface for CMA should be there together with other
> mm-related documents.
> 
> Convert this small file to ReST and move it to its rightful place.
> 
> The conversion is actually quite simple: just add a title for the
> document. In order to make it to look better for the audience,
> also mark the "echo" command as a literal block.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/cma/debugfs.txt | 6 +++++-

It wasn't really moved ;-)

>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/cma/debugfs.txt b/Documentation/cma/debugfs.txt
> index 6cef20a8cedc..4e06ffabd78a 100644
> --- a/Documentation/cma/debugfs.txt
> +++ b/Documentation/cma/debugfs.txt
> @@ -1,3 +1,7 @@
> +=====================
> +CMA Debugfs Interface
> +=====================
> +
>  The CMA debugfs interface is useful to retrieve basic information out of the
>  different CMA areas and to test allocation/release in each of the areas.
> 
> @@ -12,7 +16,7 @@ The structure of the files created under that directory is as follows:
>   - [RO] count: Amount of memory in the CMA area.
>   - [RO] order_per_bit: Order of pages represented by one bit.
>   - [RO] bitmap: The bitmap of page states in the zone.
> - - [WO] alloc: Allocate N pages from that CMA area. For example:
> + - [WO] alloc: Allocate N pages from that CMA area. For example::
> 
>  	echo 5 > <debugfs>/cma/cma-2/alloc
> 
> -- 
> 2.20.1
> 

-- 
Sincerely yours,
Mike.

