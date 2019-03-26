Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEACC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32D1020857
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731548AbfCZO1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:27:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49960 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726111AbfCZO1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 10:27:04 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QEQsg1099634
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 10:27:02 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rfmc852yy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 10:26:58 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <jejb@linux.ibm.com>;
        Tue, 26 Mar 2019 14:25:24 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Mar 2019 14:25:20 -0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2QEPJ7I7536848
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 14:25:19 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08EC7AE060;
        Tue, 26 Mar 2019 14:25:19 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 985F0AE062;
        Tue, 26 Mar 2019 14:25:17 +0000 (GMT)
Received: from jarvis.ext.hansenpartnership.com (unknown [9.85.205.129])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Mar 2019 14:25:17 +0000 (GMT)
Subject: Re: Bad file pattern in MAINTAINERS section 'KEYS-TRUSTED'
From:   James Bottomley <jejb@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, Mimi Zohar <zohar@us.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Denis Kenzior <denkenz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        James Morris <james.morris@microsoft.com>
Date:   Tue, 26 Mar 2019 07:25:17 -0700
In-Reply-To: <1553602220.3960.29.camel@linux.ibm.com>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
         <20190325212705.26837-1-joe@perches.com>
         <20190326113725.GA10898@linux.intel.com>
         <1553602220.3960.29.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19032614-0040-0000-0000-000004D77ECD
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010818; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01179957; UDB=6.00606765; IPR=6.00960672;
 MB=3.00026164; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-26 14:25:23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032614-0041-0000-0000-000008E29FB3
Message-Id: <1553610317.2900.2.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=842 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903260101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-26 at 08:10 -0400, Mimi Zohar wrote:
> Hi Jarrko,
> 
> On Tue, 2019-03-26 at 13:37 +0200, Jarkko Sakkinen wrote:
> > Mimi,
> > 
> > Can you fix this and I can ack and send PR through my tree?
> 
> Making the "trusted.h" include file public was part of David's "KEYS:
> Support TPM-wrapped key and crypto ops" patch set.  I wasn't involved
> in reviewing or upstreaming this patch set.  As I recall, it was
> upstreamed rather quickly without much review.  As it is TPM related,
> it should have at least been posted on the linux-integrity mailing
> list.  I have no idea if "trusted.h" should have been made public.
> 
> I'm not sure just "fixing" the MAINTAINERS file is the right
> solution.  I was hoping to look at it later this week.  Perhaps you
> and James could take a look?

Looking at the contents of linux/keys/trusted.h, it looks like the
wrong decision to move it.  The contents are way too improperly named
and duplicative to be in a standard header.  It's mostly actually TPM
code including a redefinition of the tpm_buf structure, so it doesn't
even seem to be necessary for trusted keys.

If you want to fix this as a bug, I'd move it back again, but long term
I think it should simply be combined with trusted.c because nothing
else can include it sanely anyway.

James

