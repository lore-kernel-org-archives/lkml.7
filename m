Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F17CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 10:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0162220863
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 10:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfJZKPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 06:15:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51388 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726098AbfJZKPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 06:15:08 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9QAC1Nf028857
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2019 06:15:06 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vvfruea68-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2019 06:15:06 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gor@linux.ibm.com>;
        Sat, 26 Oct 2019 11:15:04 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 26 Oct 2019 11:15:01 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9QAF0eG42663954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Oct 2019 10:15:00 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0AA452051;
        Sat, 26 Oct 2019 10:14:59 +0000 (GMT)
Received: from localhost (unknown [9.145.71.195])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 93E475204E;
        Sat, 26 Oct 2019 10:14:59 +0000 (GMT)
Date:   Sat, 26 Oct 2019 12:14:58 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.4-rc5
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
x-cbid: 19102610-0012-0000-0000-0000035DCBD9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102610-0013-0000-0000-000021990487
Message-Id: <your-ad-here.call-01572084898-ext-1277@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-26_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910260106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.4-rc5.

Thank you,
Vasily

The following changes since commit 7d194c2100ad2a6dded545887d02754948ca5241:

  Linux 5.4-rc4 (2019-10-20 15:56:22 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.4-5

for you to fetch changes up to ac49303d9ef0ad98b79867a380ef23480e48870b:

  s390/kaslr: add support for R_390_GLOB_DAT relocation type (2019-10-22 17:55:51 +0200)

----------------------------------------------------------------
s390 updates for 5.4-rc5

- Add R_390_GLOB_DAT relocation type support. This fixes boot problem
  on linux-next.

- Fix memory leak in zcrypt.

----------------------------------------------------------------
Gerald Schaefer (1):
      s390/kaslr: add support for R_390_GLOB_DAT relocation type

Johan Hovold (1):
      s390/zcrypt: fix memleak at release

 arch/s390/boot/startup.c               | 14 +++++++++++---
 arch/s390/kernel/machine_kexec_reloc.c |  1 +
 drivers/s390/crypto/zcrypt_api.c       |  3 +--
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/s390/boot/startup.c b/arch/s390/boot/startup.c
index 596ca7cc4d7b..5367950510f6 100644
--- a/arch/s390/boot/startup.c
+++ b/arch/s390/boot/startup.c
@@ -101,10 +101,18 @@ static void handle_relocs(unsigned long offset)
 	dynsym = (Elf64_Sym *) vmlinux.dynsym_start;
 	for (rela = rela_start; rela < rela_end; rela++) {
 		loc = rela->r_offset + offset;
-		val = rela->r_addend + offset;
+		val = rela->r_addend;
 		r_sym = ELF64_R_SYM(rela->r_info);
-		if (r_sym)
-			val += dynsym[r_sym].st_value;
+		if (r_sym) {
+			if (dynsym[r_sym].st_shndx != SHN_UNDEF)
+				val += dynsym[r_sym].st_value + offset;
+		} else {
+			/*
+			 * 0 == undefined symbol table index (STN_UNDEF),
+			 * used for R_390_RELATIVE, only add KASLR offset
+			 */
+			val += offset;
+		}
 		r_type = ELF64_R_TYPE(rela->r_info);
 		rc = arch_kexec_do_relocs(r_type, (void *) loc, val, 0);
 		if (rc)
diff --git a/arch/s390/kernel/machine_kexec_reloc.c b/arch/s390/kernel/machine_kexec_reloc.c
index 3b664cb3ec4d..d5035de9020e 100644
--- a/arch/s390/kernel/machine_kexec_reloc.c
+++ b/arch/s390/kernel/machine_kexec_reloc.c
@@ -27,6 +27,7 @@ int arch_kexec_do_relocs(int r_type, void *loc, unsigned long val,
 		*(u32 *)loc = val;
 		break;
 	case R_390_64:		/* Direct 64 bit.  */
+	case R_390_GLOB_DAT:
 		*(u64 *)loc = val;
 		break;
 	case R_390_PC16:	/* PC relative 16 bit.	*/
diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index 45bdb47f84c1..9157e728a362 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -522,8 +522,7 @@ static int zcrypt_release(struct inode *inode, struct file *filp)
 	if (filp->f_inode->i_cdev == &zcrypt_cdev) {
 		struct zcdn_device *zcdndev;
 
-		if (mutex_lock_interruptible(&ap_perms_mutex))
-			return -ERESTARTSYS;
+		mutex_lock(&ap_perms_mutex);
 		zcdndev = find_zcdndev_by_devt(filp->f_inode->i_rdev);
 		mutex_unlock(&ap_perms_mutex);
 		if (zcdndev) {

