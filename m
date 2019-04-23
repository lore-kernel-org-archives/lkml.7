Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571BBC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F0120811
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbfDWQMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:12:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43998 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728438AbfDWQMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:12:48 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3NGB7h4120179
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 12:12:47 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s25da1x9f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 12:12:46 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alifm@linux.ibm.com>;
        Tue, 23 Apr 2019 17:12:46 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 23 Apr 2019 17:12:43 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3NGCf5n33488966
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Apr 2019 16:12:41 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B949B2067;
        Tue, 23 Apr 2019 16:12:41 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A990B2066;
        Tue, 23 Apr 2019 16:12:41 +0000 (GMT)
Received: from [9.56.58.73] (unknown [9.56.58.73])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 23 Apr 2019 16:12:41 +0000 (GMT)
Subject: Re: [PATCH v2 31/79] docs: s390: convert docs to ReST and rename to
 *.rst
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
References: <cover.1555938375.git.mchehab+samsung@kernel.org>
 <fb86b676b3b426732f1f11378868a9bd3b580b46.1555938376.git.mchehab+samsung@kernel.org>
From:   Farhan Ali <alifm@linux.ibm.com>
Date:   Tue, 23 Apr 2019 12:12:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <fb86b676b3b426732f1f11378868a9bd3b580b46.1555938376.git.mchehab+samsung@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19042316-0060-0000-0000-000003309516
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010981; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01193288; UDB=6.00625536; IPR=6.00974109;
 MB=3.00026560; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-23 16:12:45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042316-0061-0000-0000-0000490E0AB8
Message-Id: <3b40a683-a77e-0219-b5bc-2ead38e627af@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-23_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904230110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/22/2019 09:27 AM, Mauro Carvalho Chehab wrote:
> Convert all text files with s390 documentation to ReST format.
> 
> Tried to preserve as much as possible the original document
> format. Still, some of the files required some work in order
> for it to be visible on both plain text and after converted
> to html.
> 
> The conversion is actually:
>    - add blank lines and identation in order to identify paragraphs;
>    - fix tables markups;
>    - add some lists markups;
>    - mark literal blocks;
>    - adjust title markups.
> 
> At its new index.rst, let's add a :orphan: while this is not linked to
> the main index.rst file, in order to avoid build warnings.
> 
> Signed-off-by: Mauro Carvalho Chehab<mchehab+samsung@kernel.org>
> ---

Hi Mauro,

How would the s390 rst files be accessed from a top level index.rst 
file? Is there a view of the changes? I looked at a link you posted [1] 
as a reply in another thread, but I couldn't find the s390 docs there.

[1] https://www.infradead.org/~mchehab/rst_conversion/

Thanks
Farhan

