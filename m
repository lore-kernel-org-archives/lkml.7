Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD996C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 03:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B17EE20835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 03:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfCGD4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 22:56:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52698 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726128AbfCGD4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 22:56:49 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x273sqcM050824
        for <linux-kernel@vger.kernel.org>; Wed, 6 Mar 2019 22:56:48 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r2t3vungm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 22:56:48 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 7 Mar 2019 03:56:46 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 7 Mar 2019 03:56:43 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x273ugpC54198484
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Mar 2019 03:56:42 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2EE6A52057;
        Thu,  7 Mar 2019 03:56:42 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.93.211])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 751FB52051;
        Thu,  7 Mar 2019 03:56:41 +0000 (GMT)
Subject: Re: [PULL REQUEST] Kernel lockdown patches for 5.2
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Matthew Garrett <matthewgarrett@google.com>, jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Date:   Wed, 06 Mar 2019 22:56:30 -0500
In-Reply-To: <20190306235913.6631-1-matthewgarrett@google.com>
References: <20190306235913.6631-1-matthewgarrett@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19030703-0012-0000-0000-000002FF91D8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030703-0013-0000-0000-000021369EBD
Message-Id: <1551930990.31706.279.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-07_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903070026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-03-06 at 15:58 -0800, Matthew Garrett wrote:

> 3) The integration with IMA has been dropped for now. IMA is in the
> process of adding support for architecture-specific policies that will
> interact correctly with the lockdown feature, and a followup patch will
> integrate that so we don't end up with an ordering dependency on the
> merge

The architecture specific policy is an attempt to coordinate between
the different signature verification methods (eg. PE and IMA kexec
kernel image signatures, appended and IMA kernel module signatures).
 The coordination between these signature verification methods is
independent of the "lockdown" feature.

To prevent requiring multiple signature verifications, an IMA policy
rule(s) is defined only if either KEXEC_VERIFY_SIG or MODULE_SIG is
not enabled.

The kexec and kernel modules patches in this patch set continues to
ignore IMA.  This patch set should up front either provide an
alternative solution to coordinate the different signature
verification methods or rely on the architecture specific policy for
that coordination.

Mimi

