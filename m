Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A49CC606CF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 00:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D3920693
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 00:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfGIAby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 20:31:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54810 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725905AbfGIAby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 20:31:54 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x690VSKv146348
        for <linux-kernel@vger.kernel.org>; Mon, 8 Jul 2019 20:31:52 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tmemeb4y7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 20:31:52 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 9 Jul 2019 01:31:50 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 9 Jul 2019 01:31:48 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x690VlBu55967862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Jul 2019 00:31:47 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A2A0A4057;
        Tue,  9 Jul 2019 00:31:47 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 763DCA404D;
        Tue,  9 Jul 2019 00:31:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.110.58])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  9 Jul 2019 00:31:46 +0000 (GMT)
Subject: Re: linux-next: manual merge of the keys tree with the integrity
 tree
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 08 Jul 2019 20:31:35 -0400
In-Reply-To: <20190709101107.0754b26c@canb.auug.org.au>
References: <20190626143333.7ee527ca@canb.auug.org.au>
         <20190709101107.0754b26c@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19070900-0016-0000-0000-000002906DAB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070900-0017-0000-0000-000032EE1DA9
Message-Id: <1562632295.11461.73.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-08_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907090005
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Tue, 2019-07-09 at 10:11 +1000, Stephen Rothwell wrote:
> > diff --cc security/integrity/digsig.c
> > index 868ade3e8970,e432900c00b9..000000000000
> > --- a/security/integrity/digsig.c
> > +++ b/security/integrity/digsig.c
> > @@@ -69,9 -70,8 +70,9 @@@ int integrity_digsig_verify(const unsig
> >   	return -EOPNOTSUPP;
> >   }
> >   
> >  -static int __integrity_init_keyring(const unsigned int id, struct key_acl *acl,
> >  -				    struct key_restriction *restriction)
> >  +static int __init __integrity_init_keyring(const unsigned int id,
> > - 					   key_perm_t perm,
> > ++					   struct key_acl *acl,
> >  +					   struct key_restriction *restriction)
> >   {
> >   	const struct cred *cred = current_cred();
> >   	int err = 0;
> 
> I am still getting this conflict (the commit ids may have changed).
> Just a reminder in case you think Linus may need to know.

Thank you for carrying the patch!  I did remember to mention it in the
pull request.  :)

Mimi

