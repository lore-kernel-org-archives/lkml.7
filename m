Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4F4CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 20:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9691F21E6F
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 20:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbfJYU0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 16:26:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51100 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728279AbfJYU0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 16:26:03 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9PKMEO3059721
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 16:26:02 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vv59cn3td-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 16:26:01 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Fri, 25 Oct 2019 21:25:59 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 25 Oct 2019 21:25:56 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9PKPtPX44630456
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Oct 2019 20:25:55 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5D72A4040;
        Fri, 25 Oct 2019 20:25:55 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F3AFA404D;
        Fri, 25 Oct 2019 20:25:55 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.205.37])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 25 Oct 2019 20:25:55 +0000 (GMT)
Date:   Fri, 25 Oct 2019 23:25:53 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     corbet@lwn.net, willy@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] docs/core-api: memory-allocation: minor cleanups
References: <20191024195016.11054-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024195016.11054-1-chris.packham@alliedtelesis.co.nz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19102520-4275-0000-0000-00000377AF9E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102520-4276-0000-0000-0000388ADE63
Message-Id: <20191025202552.GC8710@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-25_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910250186
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 08:50:13AM +1300, Chris Packham wrote:
> Clean up some formatting and add references to helpers for calculating sizes
> safely.
> 
> This series is based of v5.4-rc4.
> 
> There was a merge conflict with commit 59bb47985c1d ("mm, sl[aou]b: guarantee
> natural alignment for kmalloc(power-of-two)") and the c:func: patch is
> dependent on the typo fix. The former was resolved with a rebase, the latter by
> actually sending it as part of the series.
> 
> Chris Packham (3):
>   docs/core-api: memory-allocation: fix typo
>   docs/core-api: memory-allocation: remove uses of c:func:
>   docs/core-api: memory-allocation: mention size helpers

For the series:

Acked-by: Mike Rapoport <rppt@linux.ibm.com>
 
>  Documentation/core-api/memory-allocation.rst | 50 ++++++++++----------
>  1 file changed, 24 insertions(+), 26 deletions(-)
> 
> -- 
> 2.23.0
> 

-- 
Sincerely yours,
Mike.

