Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8BFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 873B4206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731813AbfCZQZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:25:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48968 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731519AbfCZQZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:25:33 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QGE9Ct093711
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 12:25:32 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rfp18w9ex-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 12:25:32 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <jejb@linux.ibm.com>;
        Tue, 26 Mar 2019 16:25:31 -0000
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Mar 2019 16:25:28 -0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2QGPQ3I5505258
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 16:25:26 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C90713605E;
        Tue, 26 Mar 2019 16:25:26 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 328BA136053;
        Tue, 26 Mar 2019 16:25:24 +0000 (GMT)
Received: from jarvis.ext.hansenpartnership.com (unknown [9.85.205.129])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 26 Mar 2019 16:25:23 +0000 (GMT)
Subject: Re: Bad file pattern in MAINTAINERS section 'KEYS-TRUSTED'
From:   James Bottomley <jejb@linux.ibm.com>
To:     Denis Kenzior <denkenz@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, Mimi Zohar <zohar@us.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        James Morris <james.morris@microsoft.com>
Date:   Tue, 26 Mar 2019 09:25:23 -0700
In-Reply-To: <c7f70a06-65a5-a1cd-69c5-dae7567b851f@gmail.com>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
         <20190325212705.26837-1-joe@perches.com>
         <20190326113725.GA10898@linux.intel.com>
         <1553602220.3960.29.camel@linux.ibm.com>
         <1553610317.2900.2.camel@linux.ibm.com>
         <c7f70a06-65a5-a1cd-69c5-dae7567b851f@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19032616-0012-0000-0000-0000171D7C78
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010818; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01179997; UDB=6.00617490; IPR=6.00960712;
 MB=3.00026165; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-26 16:25:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032616-0013-0000-0000-000056A5C80F
Message-Id: <1553617523.2900.26.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903260113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-26 at 09:59 -0500, Denis Kenzior wrote:
> Hi James,
> 
> On 03/26/2019 09:25 AM, James Bottomley wrote:
> > Looking at the contents of linux/keys/trusted.h, it looks like the
> > wrong decision to move it.  The contents are way too improperly
> > named
> > and duplicative to be in a standard header.  It's mostly actually
> > TPM
> > code including a redefinition of the tpm_buf structure, so it
> > doesn't
> > even seem to be necessary for trusted keys.
> 
> The reason this was done was because asym_tpm.c needed a bunch of
> the same functionality already provided by trusted.c, e.g.
> TSS_authmac and  friends.

So make a header which only includes those.  We can't have things like
this:

struct tpm_buf {
	int len;
	unsigned char data[MAX_BUF_SIZE];
};

Which means you can't include drivers/char/tpm/tpm.h with this file. 
The storeX functions are also way too generically named and are, in
fact, duplicating the tpm buffer functions in tpm.h

The solution looks to be to elevate agreed tpm_buf functions into
linux/tpm.h and use them.

> > If you want to fix this as a bug, I'd move it back again, but long
> > term I think it should simply be combined with trusted.c because
> > nothing else can include it sanely anyway.
> 
> Ideally I'd like to see the TPM subsystem expose these functions
> using some proper API / library abstraction.  David Howells had an
> RFC patch set that tried to address some of this a while back.  Not
> sure if that went anywhere.

I'm not actually sure I saw it but the solution seems pretty simple:
The TSS functions you want can be renamed tpm1_whatever and we can put
them in tpm1-cmd.c ... tpm2-cmd.c is where all the TPM 2.0 trusted key
stuff is anyway.

James

