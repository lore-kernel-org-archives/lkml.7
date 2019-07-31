Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BB9C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 08:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4480920693
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 08:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbfGaI6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 04:58:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30222 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727736AbfGaI63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 04:58:29 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6V8l8xe056924
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 04:58:28 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u379a2592-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 04:58:27 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Wed, 31 Jul 2019 09:58:25 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 31 Jul 2019 09:58:23 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6V8w5Jr19005810
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Jul 2019 08:58:05 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C6D0A405C;
        Wed, 31 Jul 2019 08:58:21 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 573FEA4060;
        Wed, 31 Jul 2019 08:58:21 +0000 (GMT)
Received: from osiris (unknown [9.152.212.134])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 31 Jul 2019 08:58:21 +0000 (GMT)
Date:   Wed, 31 Jul 2019 10:58:20 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390@vger.kernel.org,
        Harald Freudenberger <freude@linux.ibm.com>,
        Patrick Steuer <steuer@linux.ibm.com>
Subject: Re: linux-next: Tree for Jul 31 - s390 crypto build breakage
References: <20190731163915.3fdfcb14@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731163915.3fdfcb14@canb.auug.org.au>
X-TM-AS-GCONF: 00
x-cbid: 19073108-0012-0000-0000-00000337EE06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19073108-0013-0000-0000-000021719646
Message-Id: <20190731085819.GA3488@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-31_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907310095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 04:39:15PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20190730:

Hello Ard,

two of your patches in the crypto tree cause build breakage on s390:

The patch ("crypto: aes - create AES library based on the fixed time AES code")
causes this:

arch/s390/crypto/aes_s390.c:111:13: error: conflicting types for 'aes_encrypt'
  111 | static void aes_encrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
      |             ^~~~~~~~~~~

And the commit ("crypto: aegis128 - add support for SIMD acceleration") causes
another build breakage:

crypto/aegis128-core.c:19:10: fatal error: asm/simd.h: No such file or directory
   19 | #include <asm/simd.h>
      |          ^~~~~~~~~~~~

