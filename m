Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43538C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2733923FF6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfFDLvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 07:51:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45346 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727374AbfFDLvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 07:51:54 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x54BkXNI064863
        for <linux-kernel@vger.kernel.org>; Tue, 4 Jun 2019 07:51:52 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2swqwbgm4f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 07:51:52 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <fbarrat@linux.ibm.com>;
        Tue, 4 Jun 2019 12:51:50 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 4 Jun 2019 12:51:46 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x54Bpjia60424434
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Jun 2019 11:51:45 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B23BC52054;
        Tue,  4 Jun 2019 11:51:45 +0000 (GMT)
Received: from [9.143.107.15] (unknown [9.143.107.15])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 58C8452051;
        Tue,  4 Jun 2019 11:51:45 +0000 (GMT)
Subject: Re: [PATCH] ocxl: do not use C++ style comments in uapi header
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
References: <20190604111632.22479-1-yamada.masahiro@socionext.com>
From:   Frederic Barrat <fbarrat@linux.ibm.com>
Date:   Tue, 4 Jun 2019 13:51:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190604111632.22479-1-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-MC
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19060411-0016-0000-0000-00000283E89E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060411-0017-0000-0000-000032E0F85B
Message-Id: <90aa6d91-7592-17b0-17fd-e33676bd0a46@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-04_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=888 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906040081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 04/06/2019 à 13:16, Masahiro Yamada a écrit :
> Linux kernel tolerates C++ style comments these days. Actually, the
> SPDX License tags for .c files start with //.
> 
> On the other hand, uapi headers are written in more strict C, where
> the C++ comment style is forbidden.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Thanks!
Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>


> 
>   include/uapi/misc/ocxl.h | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/include/uapi/misc/ocxl.h b/include/uapi/misc/ocxl.h
> index 97937cfa3baa..6d29a60a896a 100644
> --- a/include/uapi/misc/ocxl.h
> +++ b/include/uapi/misc/ocxl.h
> @@ -33,23 +33,23 @@ struct ocxl_ioctl_attach {
>   };
>   
>   struct ocxl_ioctl_metadata {
> -	__u16 version; // struct version, always backwards compatible
> +	__u16 version; /* struct version, always backwards compatible */
>   
> -	// Version 0 fields
> +	/* Version 0 fields */
>   	__u8  afu_version_major;
>   	__u8  afu_version_minor;
> -	__u32 pasid;		// PASID assigned to the current context
> +	__u32 pasid;		/* PASID assigned to the current context */
>   
> -	__u64 pp_mmio_size;	// Per PASID MMIO size
> +	__u64 pp_mmio_size;	/* Per PASID MMIO size */
>   	__u64 global_mmio_size;
>   
> -	// End version 0 fields
> +	/* End version 0 fields */
>   
> -	__u64 reserved[13]; // Total of 16*u64
> +	__u64 reserved[13]; /* Total of 16*u64 */
>   };
>   
>   struct ocxl_ioctl_p9_wait {
> -	__u16 thread_id; // The thread ID required to wake this thread
> +	__u16 thread_id; /* The thread ID required to wake this thread */
>   	__u16 reserved1;
>   	__u32 reserved2;
>   	__u64 reserved3[3];
> 

