Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8B2C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C700D21743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbfEUPJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 11:09:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60498 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728357AbfEUPJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 11:09:50 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4LF3aEp022456
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 11:09:49 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2smkn1r90k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 11:09:48 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <linuxram@us.ibm.com>;
        Tue, 21 May 2019 16:09:47 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 21 May 2019 16:09:42 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4LF9fb857606362
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 15:09:41 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A194A52051;
        Tue, 21 May 2019 15:09:40 +0000 (GMT)
Received: from ram.ibm.com (unknown [9.85.154.252])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 9D4715204F;
        Tue, 21 May 2019 15:09:37 +0000 (GMT)
Date:   Tue, 21 May 2019 08:09:35 -0700
From:   Ram Pai <linuxram@us.ibm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Anshuman Khandual <anshuman.linux@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Anderson <andmike@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Claudio Carvalho <cclaudio@linux.ibm.com>
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20190521044912.1375-1-bauerman@linux.ibm.com>
 <20190521044912.1375-3-bauerman@linux.ibm.com>
 <20190521051326.GC29120@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521051326.GC29120@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19052115-0016-0000-0000-0000027E06E9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052115-0017-0000-0000-000032DAF3D4
Message-Id: <20190521150935.GB8402@ram.ibm.com>
Subject: Re:  Re: [RFC PATCH 02/12] powerpc: Add support for adding an ESM blob to
 the zImage wrapper
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-21_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905210094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 07:13:26AM +0200, Christoph Hellwig wrote:
> On Tue, May 21, 2019 at 01:49:02AM -0300, Thiago Jung Bauermann wrote:
> > From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > 
> > For secure VMs, the signing tool will create a ticket called the "ESM blob"
> > for the Enter Secure Mode ultravisor call with the signatures of the kernel
> > and initrd among other things.
> > 
> > This adds support to the wrapper script for adding that blob via the "-e"
> > option to the zImage.pseries.
> > 
> > It also adds code to the zImage wrapper itself to retrieve and if necessary
> > relocate the blob, and pass its address to Linux via the device-tree, to be
> > later consumed by prom_init.
> 
> Where does the "BLOB" come from?  How is it licensed and how can we
> satisfy the GPL with it?

The "BLOB" is not a piece of code. Its just a piece of data that gets
generated by our build tools. This data contains the
signed hash of the kernel, initrd, and kernel command line parameters.
Also it contains any information that the creator the the BLOB wants to
be made available to anyone needing it, inside the
secure-virtual-machine. All of this is integrity-protected and encrypted
to safegaurd it when at rest and at runtime.
 
Bottomline -- Blob is data, and hence no licensing implication. And due
to some reason, even data needs to have licensing statement, we can
make it available to have no conflicts with GPL.


-- 
Ram Pai

